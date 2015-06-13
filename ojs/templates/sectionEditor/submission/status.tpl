{**
 * templates/sectionEditor/submission/status.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the submission status table.
 *}
<div id="status">
<h3>{translate key="common.status"}</h3>
	{assign var="status" value=$submission->getSubmissionStatus()}
	<p><strong>{translate key="common.status"}</strong><br/>
		{if $status == STATUS_ARCHIVED}{translate key="submissions.archived"}
		{elseif $status==STATUS_QUEUED_UNASSIGNED}{translate key="submissions.queuedUnassigned"}
		{elseif $status==STATUS_QUEUED_EDITING}{translate key="submissions.queuedEditing"}
		{elseif $status==STATUS_QUEUED_REVIEW}{translate key="submissions.queuedReview"}
		{elseif $status==STATUS_PUBLISHED}{translate key="submissions.published"}&nbsp;&nbsp;&nbsp;&nbsp;{$issue->getIssueIdentification()|escape}
		{elseif $status==STATUS_DECLINED}{translate key="submissions.declined"}
		{/if}	
		<br/>
			{if $status != STATUS_ARCHIVED}
				<a href="{url op="unsuitableSubmission" articleId=$submission->getId()}" class="action delete">{translate key="editor.article.archiveSubmission"}</a>
			{else}
				<a href="{url op="restoreToQueue" path=$submission->getId()}" class="action crear_general">{translate key="editor.article.restoreToQueue"}</a>
			{/if}
	</p>
	
	<p><strong>{translate key="submission.initiated"}</strong><br/>
	{$submission->getDateStatusModified()|date_format:$dateFormatShort}
	</p>
	
	<p><strong>{translate key="submission.lastModified"}</strong><br/>
	{$submission->getLastModified()|date_format:$dateFormatShort}
	</p>
	
	{if $enableComments}
	<p><strong>{translate key="comments.readerComments"}</strong><br/>
		{translate key=$submission->getCommentsStatusString()}<br/>
		<form action="{url op="updateCommentsStatus" path=$submission->getId()}" method="post">{translate key="submission.changeComments"} <br/>
		<select name="commentsStatus" size="1" class="selectMenu input-medium">{html_options_translate options=$commentsStatusOptions selected=$submission->getCommentsStatus()}</select> <br/>
		<input type="submit" value="{translate key="common.record"}" class="btn btn-small" /></form>
	</p>
	{/if}
</div>

{* MODIFICADO OJS V.2.4.2 / 04-2013*}