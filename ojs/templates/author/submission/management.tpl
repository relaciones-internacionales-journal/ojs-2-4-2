{**
 * templates/author/submission/management.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the author's submission management table.
 *
 *}
<div id="submission_management">
<h3>{translate key="article.submission"}</h3>
<p><strong>{translate key="article.authors"}</strong><br/>
		{$submission->getAuthorString(false)|escape}
</p>
<p><strong>{translate key="article.title"}</strong><br/>
		<td width="80%" colspan="2" class="data">{$submission->getLocalizedTitle()|strip_unsafe_html}
</p>
<p><strong>{translate key="submission.originalFile"}</strong><br/>
			{if $submissionFile}
				<a href="{url op="downloadFile" path=$submission->getId()|to_array:$submissionFile->getFileId():$submissionFile->getRevision()}" class="file descargar_general">{$submissionFile->getFileName()|escape}</a>&nbsp;&nbsp;{$submissionFile->getDateModified()|date_format:$dateFormatShort}
			{else}
				{translate key="common.none"}
			{/if}

</p>
<p><strong>{translate key="article.suppFilesAbbrev"}</strong><br/>
			{foreach name="suppFiles" from=$suppFiles item=suppFile}
				<a href="{if $submission->getStatus() != STATUS_PUBLISHED && $submission->getStatus() != STATUS_ARCHIVED}{url op="editSuppFile" path=$submission->getId()|to_array:$suppFile->getId()}{else}{url op="downloadFile" path=$submission->getId()|to_array:$suppFile->getFileId()}{/if}" class="file descargar_general">{$suppFile->getFileName()|escape}</a>&nbsp;&nbsp;{$suppFile->getDateModified()|date_format:$dateFormatShort}<br />
			{foreachelse}
				{translate key="common.none"}
			{/foreach}

			{if $submission->getStatus() != STATUS_PUBLISHED && $submission->getStatus() != STATUS_ARCHIVED}
				<a href="{url op="addSuppFile" path=$submission->getId()}" class="action crear_general">{translate key="submission.addSuppFile"}</a>
			{else}
				&nbsp;
			{/if}
</p>
<p><strong>{translate key="submission.submitter"}</strong><br/>
			{assign var="submitter" value=$submission->getUser()}
			{assign var=emailString value=$submitter->getFullName()|concat:" <":$submitter->getEmail():">"}
			{url|assign:"url" page="user" op="email" to=$emailString|to_array redirectUrl=$currentUrl subject=$submission->getLocalizedTitle|strip_tags articleId=$submission->getId()}
			{$submitter->getFullName()|escape} {icon name="mail" url=$url}

</p>
<p><strong>{translate key="common.dateSubmitted"}</strong><br/>
		{$submission->getDateSubmitted()|date_format:$datetimeFormatLong}
</p>
<p><strong>{translate key="section.section"}</strong><br/>
		{$submission->getSectionTitle()|escape}
</p>
<p><strong>{translate key="user.role.editor"}</strong><br/>
		{assign var="editAssignments" value=$submission->getEditAssignments()}
			{foreach from=$editAssignments item=editAssignment}
				{assign var=emailString value=$editAssignment->getEditorFullName()|concat:" <":$editAssignment->getEditorEmail():">"}
				{url|assign:"url" page="user" op="email" to=$emailString|to_array redirectUrl=$currentUrl subject=$submission->getLocalizedTitle|strip_tags articleId=$submission->getId()}
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
{if $submission->getCommentsToEditor()}
	<p><strong>{translate key="article.commentsToEditor"}</strong><br/>
			{$submission->getCommentsToEditor()|strip_unsafe_html|nl2br}
	</p>
{/if}
{if $publishedArticle}
	<p><strong>{translate key="submission.abstractViews"}</strong><br/>
	{$publishedArticle->getViews()}
{/if}

</div>
{* MODIFICADO OJS V.2.4.2 / 04-2013*}