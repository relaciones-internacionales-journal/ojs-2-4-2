{**
 * templates/sectionEditor/submission/summary.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the submission summary table.
 *
 *}
<div id="submission_editing">
<h3>{translate key="article.submission"}</h3>

	<p><strong>{translate key="article.authors"}: </strong>
			{url|assign:"url" page="user" op="email" redirectUrl=$currentUrl to=$submission->getAuthorEmails() subject=$submission->getLocalizedTitle() articleId=$submission->getId()}
			{$submission->getAuthorString()|escape} {icon name="mail" url=$url}
	</p>
	<p><strong>{translate key="article.title"}: </strong>
		{$submission->getLocalizedTitle()|strip_unsafe_html}
	</p>
	<p><strong>{translate key="section.section"}: </strong>
		<td>{$submission->getSectionTitle()|escape}
	</p>
	<p><strong>{translate key="user.role.editor"}: </strong>
			{assign var=editAssignments value=$submission->getEditAssignments()}
			{foreach from=$editAssignments item=editAssignment}
				{assign var=emailString value=$editAssignment->getEditorFullName()|concat:" <":$editAssignment->getEditorEmail():">"}
				{url|assign:"url" page="user" op="email" redirectUrl=$currentUrl to=$emailString|to_array subject=$submission->getLocalizedTitle()|strip_tags articleId=$submission->getId()}
				{$editAssignment->getEditorFullName()|escape} {icon name="mail" url=$url}
				{if !$editAssignment->getCanEdit() || !$editAssignment->getCanReview()}
					{if $editAssignment->getCanEdit()}
						({translate key="submission.editing"})
					{else}
						({translate key="submission.review"})
					{/if}
				{/if}
				<br/>
			{foreachelse}
				{translate key="common.noneAssigned"}
			{/foreach}

	</p>
</div>
{* MODIFICADO OJS V.2.4.2 / 04-2013*}
