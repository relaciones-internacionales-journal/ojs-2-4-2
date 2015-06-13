<?php

/**
 * @defgroup GatewayPlugin
 */

/**
 * @file iPhoneExportDom.inc.php
 *
 * Copyright (c) 2010 Martin Six
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class iPhoneExportDom
 * @ingroup GatewayPlugin
 *
 * @brief iPhoneExportDom export plugin DOM functions for export
 */
class iPhoneExportDom {

    /**
     *  returns xml represantion of relevant journal data
     */
    function getJournalXML(&$journal) {
        $data = '
    <journal id="' . $journal->getJournalId() . '">
      <title>' . htmlspecialchars($journal->getJournalTitle()) . '</title>
      <encryption>' . Config::getVar('security', 'encryption') . '</encryption>
    </journal>';
        return $data;
    }

    /**
     *  returns xml represantion of relevant issue data
     */
    function getIssueXML(&$issue, &$journal) {
        import('classes.config.Config');
        $base_url = & Config::getVar('general', 'public_url');
        $url = $base_url . '/index.php/' . $journal->getPath() . '/issue/view/' . $issue->getIssueId();

        $data = '<issue id="' . $issue->getIssueId() . '">
      <issueTitle>' . htmlspecialchars($issue->getIssueTitle()) . '</issueTitle>';

        if ($issue->getIssueDescription() != '') {
            $data .= '<description>' . htmlspecialchars($issue->getIssueDescription()) . '</description>';
        }

        $data .= '<url type="uri">' . $url . '</url>
      <dateIssued>' . date('Y-m-d\TH:i:s+00:00', strtotime($issue->getDatePublished())) . '</dateIssued>
      <details>
        <volume>' . $issue->getVolume() . '</volume>
        <number>' . $issue->getNumber() . '</number>
        <year>' . $issue->getYear() . '</year>
      </details>
    </issue>';

        return $data;
    }

    /**
     *  returns xml represantion of relevant section data
     */
    function getSectionXML(&$section, &$issue, &$articles) {
        $data = '<section id="' . $section->getSectionId() . '">
        <sectionTitle>' . htmlspecialchars($section->getSectionTitle()) . '</sectionTitle>';

        //TODO: find solution, just fixed now
        /*if ($section->getSectionAbbrev() != '') {
            $data .= '<abbrev>' . $section->getSectionAbbrev() . '</abbrev>';
        }*/

        $data .= '<data>';

        foreach ($articles as $article) {
            $data .= iPhoneExportDom::getArticleXML($article, $issue, true);
        }

        $data .= '</data>';

        $data .= '</section>';

        return $data;
    }

    function getArticleXML(&$article, &$issue, $all = false) {

        $authors = $article->getAuthors();

        $data = '<article id="' . $article->getArticleId() . '">
      <title>' . htmlspecialchars($article->getArticleTitle()) . '</title>
      <authors>';

        foreach ($authors as $author) {
            $data .= '<author>
        <firstName>' . htmlspecialchars($author->getFirstName()) . '</firstName>
        <middleName>' . htmlspecialchars($author->getMiddleName()) . '</middleName>
        <lastName>' . htmlspecialchars($author->getLastName()) . '</lastName>
      </author>';
        }

        $data .= '
      </authors>';

        if ($article->getLanguage() != '')
            $data .= '<language>' . $article->getLanguage() . '</language>';

        if ($all) {
            if ($article->getArticleAbstract() != '')
                $data .= '<abstract>' . htmlspecialchars($article->getArticleAbstract()) . '</abstract>';
            if ($article->getArticleDiscipline() != '') {
                $data .= '<subject>';
                $disciplines = explode(";", htmlspecialchars($article->getArticleDiscipline()));
                foreach ($disciplines as $discipline) {
                    $data .= '<topic>' . $discipline . '</topic>';
                }
                $data .= '</subject>';
            }

            // get file stuff

            import('classes.file.PublicFileManager');
            import('classes.file.FileManager');
            $galleyDao = & DAORegistry::getDAO('ArticleGalleyDAO');
            $galleys = $galleyDao->getGalleysByArticle($article->getArticleId());
            $data .= '<files>';
            foreach ($galleys as $galley) {
                if (!$galley->isHTMLGalley()) {
                    $filePath = iPhoneExportDom::getPublicFilePath($galley, 'public');
                    $md5checksum = md5_file($filePath);
                    $data .= '<file id="' . $galley->getFileId() . '">
            <fileUrl>' . iPhoneExportDom::getPublicFileUrl($galley) . '</fileUrl>
            <fileSize>' . $galley->getFileSize() . '</fileSize>
            <mimeType>' . $galley->getFileType() . '</mimeType>
            <originalFileName>' . $galley->getFileName() . '</originalFileName>
            <md5checksum>' . $md5checksum . '</md5checksum>
          </file>';
                }
            }
            $data .= '</files>
      <suppfiles>';

            $SuppFileDAO = & DAORegistry::getDAO('SuppFileDAO');
            $suppFilesArray = & $SuppFileDAO->getSuppFilesByArticle($article->getArticleId());

            foreach ($suppFilesArray as $suppFile) {
                $filePath = iPhoneExportDom::getPublicFilePath($suppFile, '/supp/');
                ;
                $md5checksum = md5_file($filePath);
                $data .= '<file id="' . $suppFile->getFileId() . '">
          <fileUrl>' . iPhoneExportDom::getPublicSuppFileUrl($suppFile) . '</fileUrl>
          <fileSize>' . $suppFile->getFileSize() . '</fileSize>
          <mimeType>' . $suppFile->getFileType() . '</mimeType>
          <originalFileName>' . $suppFile->getFileName() . '</originalFileName>
          <md5checksum>' . $md5checksum . '</md5checksum>
        </file>';
            }

            $data .= '</suppfiles>';
        }

        $data .= '</article>';

        return $data;
    }

    /**
     *  Create <header> for export
     */
    function getHeaderXML() {
        $organization = $this->getSetting($this->journalId, 'organization');
        if ($organization == '') {
            $siteDao = & DAORegistry::getDAO('SiteDAO');
            $site = $siteDao->getSite();
            $organization = $site->getSitePageHeaderTitle();
        }

        $data = '
    <header>
      <name>' . htmlspecialchars($organization) . '</name>
      <creator>' . iPhoneExportDom::getCreatorString() . '</creator>
    </header>';

        return $data;
    }

    function getCommentXML($comment) {
        $data = '<comment id="' . $comment->getCommentId() . '">
      <title>' . htmlspecialchars($comment->getTitle()) . '</title>
      <body>' . htmlspecialchars($comment->getBody()) . '</body>
      <datePosted>' . $comment->getDatePosted() . '</datePosted>
      <authorName>' . $comment->getPosterName() . '</authorName>
      <authorEmail>' . $comment->getPosterEmail() . '</authorEmail>
      <children>';
        if (is_array($comment->getChildren())) {
            foreach ($comment->getChildren() as $child) {
                $data .= iPhoneExportDom::getCommentXML($child);
            }
        }
        $data .= '  </children>
    </comment>';

        return $data;
    }

    /**
     *  Creator is the OJS Sysytem
     */
    function getCreatorString() {
        $versionDAO = & DAORegistry::getDAO('VersionDAO');
        $cVersion = $versionDAO->getCurrentVersion();
        return sprintf('Open Journal Systems v%d.%d.%d build %d', $cVersion->getMajor(), $cVersion->getMinor(), $cVersion->getRevision(), $cVersion->getBuild());
    }

    /**
     *  getPublicFilePath had to be added due to problems in the current 
     *  $PaperFile->getFilePath(); for Galley Files
     */
    function getPublicFilePath(&$File, $pathComponent) {
        $articleId = $File->getArticleId();
        $articleDao = & DAORegistry::getDAO('ArticleDAO');
        $article = & $articleDao->getArticle($articleId);
        $journalId = $article->getJournalId();
        return Config::getVar('files', 'files_dir') . '/journals/' . $journalId .
        '/articles/' . $File->getArticleId() . '/' . $pathComponent . '/' . $File->getFileName();
    }

    /**
     *  getPublicFileUrl !!!! must be a better way....
     */
    function getPublicFileUrl(&$File) {
        import('classes.config.Config');
        $base_url = & Config::getVar('general', 'public_url');
        $articleDao = & DAORegistry::getDAO('ArticleDAO');
        $article = & $articleDao->getArticle($File->getArticleId());
        $JournalDAO = & DAORegistry::getDAO('JournalDAO');
        $journal = $JournalDAO->getJournal($article->getJournalId());
        $base_url = & Config::getVar('general', 'public_url');
        $url = $base_url . '/index.php/' . $journal->getPath() . '/article/download/' . $File->getArticleId() . '/' . $File->getBestGalleyId($journal);
        return $url;
    }

    /**
     *  getPublicSuppFileUrl !!!! must be a better way....
     */
    function getPublicSuppFileUrl(&$File) {
        import('classes.config.Config');
        $base_url = & Config::getVar('general', 'base_url');
        $articleDao = & DAORegistry::getDAO('ArticleDAO');
        $article = & $articleDao->getArticle($File->getArticleId());
        $JournalDAO = & DAORegistry::getDAO('JournalDAO');
        $journal = $JournalDAO->getJournal($article->getJournalId());
        $base_url = & Config::getVar('general', 'base_url');
        $url = $base_url . '/index.php/' . $journal->getPath() . '/article/downloadSuppFile/' . $File->getArticleId() . '/' . $File->getSuppFileId();
        return $url;
    }

}
