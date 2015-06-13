{**
 * templates/author/submission/status.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the submission status table.
 *
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
		</p>

		<p><strong>{translate key="submission.initiated"}</strong><br/>
		{$submission->getDateStatusModified()|date_format:$dateFormatShort}

		<p><strong>{translate key="submission.lastModified"}</strong><br/>
		{$submission->getLastModified()|date_format:$dateFormatShort}
	</p>

</div>
{* MODIFICADO OJS V.2.4.2 / 04-2013*}