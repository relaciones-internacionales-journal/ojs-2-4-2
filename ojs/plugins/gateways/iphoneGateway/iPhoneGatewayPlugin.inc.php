<?php

/**
 * @file iPhoneGatewayPlugin.inc.php
 *
 * Copyright (c) 2010 Martin Six
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class iPhoneGatewayPlugin
 * @ingroup plugins
 *
 * @brief A plugin that exports journal data in xml for use with the iphone app
 */

import('classes.plugins.GatewayPlugin');

class iPhoneGatewayPlugin extends GatewayPlugin {

    /**
     * Called as a plugin is registered to the registry
     * @param $category String Name of category plugin was registered to
     * @return boolean True iff plugin initialized successfully; if false,
     * 	the plugin will not be registered.
     */
    public function register($category, $path) {
        $success = parent::register($category, $path);
        $this->addLocaleData();
        return $success;
    }

    /**
     * Get the name of this plugin. The name must be unique within
     * its category.
     * @return String name of plugin
     */
    public function getName() {
        return 'iPhoneGatewayPlugin';
    }

    public function getDisplayName() {
        return __('plugins.gateways.iPhoneGateway.displayName');
    }

    public function getDescription() {
        return __('plugins.gateways.iPhoneGateway.description');
    }

    public function getManagementVerbs() {
        return parent::getManagementVerbs();
    }

    public function manage($verb, $args) {
        if (parent::manage($verb, $args))
            return true;
        if (!$this->getEnabled())
            return false;
        switch ($verb) {
            case 'settings':
                $journal = & Request::getJournal();
                $this->import('SettingsForm');
                $form = new SettingsForm($this, $journal->getJournalId());
                if (Request::getUserVar('save')) {
                    $form->readInputData();
                    if ($form->validate()) {
                        $form->execute();
                        Request::redirect(null, null, 'plugins');
                    } else {
                        $form->display();
                    }
                } else {
                    $form->initData();
                    $form->display();
                }
                break;
            default:
                return false;
        }
        return true;
    }

    /**
     * Handle fetch requests for this plugin.
     */
    public function fetch($args) {
        if (!$this->getEnabled()) {
            return false;
        }

        if (empty($args)) {
            $errors = array();
        } else {
            $this->journal = & Request::getJournal();
            $this->journalId = $this->journal->getJournalId();

            $task = array_shift($args);
            switch ($task) {
                case 'journal':
                    $this->printXML($this->getJournalData());
                    break;
                case 'issues':
                    $page = array_shift($args);
                    $this->printXML($this->getIssueData($page));
                    break;
                case 'sections':
                    $issueId = array_shift($args);
                    if ($issueId)
                        $this->printXML($this->getSectionData($issueId));
                    break;
                case 'comment':
                    $username = array_shift($args);
                    $password = array_shift($args);
                    $articleId = array_shift($args);
                    $title = base64_decode(array_shift($args));
                    $body = base64_decode(array_shift($args));

                    echo $this->handleComment($username, $password, $articleId, $title, $body);
                    break;
                case 'comments':
                    $articleId = array_shift($args);
                    $this->printXML($this->getCommentData($articleId));
                    break;
                case 'auth':
                    $username = array_shift($args);
                    $password = array_shift($args);
                    echo $this->doAuth($username, $password);
                    break;
                default:
                    break;
            }

            return true;
        }

        // Failure.
        header("HTTP/1.0 500 Internal Server Error");
        $templateMgr = & TemplateManager::getManager();
        $templateMgr->assign('message', 'plugins.gateways.iPhoneGateway.errors.errorMessage');
        $templateMgr->display('common/message.tpl');
        exit;
    }

    protected function getJournalData() {
        $this->import('iPhoneExportDom');

        $output = '<ojs type="journal" id="' . $this->journalId . '">';
        $output .= iPhoneExportDom::getHeaderXML();
        $output .= '<data>';
        $output .= iPhoneExportDom::getJournalXML($this->journal); // get journal info (title + id)
        $output .= '</data>';
        $output .= '</ojs>';

        return $output;
    }

    protected function getIssueData($page) {
        $this->import('iPhoneExportDom');

        $issueDao = & DAORegistry::getDAO('IssueDAO');

        $count = Handler::getRangeInfo('issues');
        /* $count->setCount(5);
          if($page)
          $count->setPage($page); */

        $issuesResultSet = & $issueDao->getPublishedIssues($this->journalId, $count);

        $output = '<ojs type="issues" journalId="' . $this->journalId . '">';
        $output .= iPhoneExportDom::getJournalXML($this->journal); // get journal info (title + id)
        $output .= '<data>';

        while (!$issuesResultSet->eof() && $issue = $issuesResultSet->next()) {
            $output .= iPhoneExportDom::getIssueXML($issue, $this->journal);
        }

        $output .= '</data>';
        $output .= '</ojs>';

        return $output;
    }

    protected function getSectionData(&$issueId) {
        $this->import('iPhoneExportDom');


        $issueDao = & DAORegistry::getDAO('IssueDAO');
        $issue = $issueDao->getIssueById($issueId);
        if (!$issue)
            return 'NO_SUCH_ISSUE';

        $sectionDAO = & DAORegistry::getDAO('SectionDAO');
        $sections = & array_reverse($sectionDAO->getSectionsForIssue($issueId));

        $articleDao = & DAORegistry::getDAO('PublishedArticleDAO');

        $output = '<ojs type="sections" issueId="' . $issueId . '">';
        $output .= iPhoneExportDom::getIssueXML($issue, $this->journal); // get journal info (title + id)
        $output .= '<data>';

        foreach ($sections as $section) {
            $articles = & $articleDao->getPublishedArticlesBySectionId($section->getSectionId(), $issue->getIssueId());
            $output .= iPhoneExportDom::getSectionXML($section, $issue, $articles);
        }

        $output .= '</data>';
        $output .= '</ojs>';

        return $output;
    }

    protected function getCommentData($articleId) {
        $this->import('iPhoneExportDom');

        $commentDao = & DAORegistry::getDAO('CommentDAO');
        $comments = $commentDao->getRootCommentsBySubmissionId($articleId);

        $output = '<ojs>
        <article id="' . $articleId . '" />
        <comments>';

        foreach ($comments as $comment) {
            $output .= iPhoneExportDom::getCommentXML($comment);
        }
        $output .= '</comments>
        </ojs>';
        
        return $output;
    }

    protected function handleComment(&$username, &$password, &$articleId, &$title, &$body) {
        $userDAO = DAORegistry::getDAO('UserDAO');
        $user = $userDAO->getUserByCredentials($username, $password);

        if ($user == null) {
            return 'ERROR_CREDENTIALS';
        }

        if ($title == null || $title == '' || $body == null || $body == '' || $articleId == null || $articleId == '') {
            return 'ERROR_PARAMS';
        }

        if (DAORegistry::getDAO('PublishedArticleDAO')->getPublishedArticleByArticleId($articleId) == null) {
            return 'ERROR_NO_ARTICLE';
        }

        $commentDao = & DAORegistry::getDAO('CommentDAO');
        $comment = new Comment();
        $comment->setSubmissionId($articleId);
        $comment->setBody($body);
        $comment->setTitle($title);
        $comment->setUser($user);
        $comment->setChildCommentCount(0);
        $comment->setPosterName($user->getFullName());
        $comment->setPosterEmail($user->getEmail());
        $result = $commentDao->insertComment($comment);
        echo (int) $result;
    }

    protected function doAuth(&$username, &$password) {
        $userDAO = DAORegistry::getDAO('UserDAO');
        $user = $userDAO->getUserByCredentials($username, $password);

        if ($user == null) {
            return 'ERROR_CREDENTIALS';
        }

        if ($user->getDisabled()) {
            // The user has been disabled.
            $reason = $user->getDisabledReason();
            if ($reason === null)
                $reason = '';
            return 'ERROR_USER_DISABLED';
        }

        // The user is valid, mark user as logged in in current session
        $sessionManager = &SessionManager::getManager();

        // Regenerate session ID first
        $sessionManager->regenerateSessionId();

        $session = &$sessionManager->getUserSession();
        $session->setSessionVar('userId', $user->getUserId());
        $session->setUserId($user->getUserId());
        $session->setSessionVar('username', $user->getUsername());

        $user->setDateLastLogin(Core::getCurrentDate());
        $userDAO->updateUser($user);

        return 'SUCCESS';
    }

    protected function printXML(&$output) {
        header("Content-Type: application/xml");
        echo $output;
        return true;
    }

}

?>
