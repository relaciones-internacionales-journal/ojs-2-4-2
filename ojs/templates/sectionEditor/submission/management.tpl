{**
 * templates/sectionEditor/submission/management.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the submission management table.
 *
 *}
<div id="submission_management">
<h3>{translate key="article.submission"}</h3>

{assign var="submissionFile" value=$submission->getSubmissionFile()}
{assign var="suppFiles" value=$submission->getSuppFiles()}

	<p><strong>{translate key="article.authors"}</strong><br/>
		{url|assign:"url" page="user" op="email" redirectUrl=$currentUrl to=$submission->getAuthorEmails() subject=$submission->getLocalizedTitle() articleId=$submission->getId()}
		{$submission->getAuthorString()|escape url=$url} {icon name="mail" url=$url}
	</p>
	<p><strong>{translate key="article.title"}</strong><br/>
		{$submission->getLocalizedTitle()|strip_unsafe_html}
	</p>
	<p><strong>{translate key="submission.originalFile"}</strong><br/>
			{if $submissionFile}
				<a href="{url op="downloadFile" path=$submission->getId()|to_array:$submissionFile->getFileId()}" class="file descargar_general">{$submissionFile->getFileName()|escape}</a>&nbsp;&nbsp;{$submissionFile->getDateModified()|date_format:$dateFormatShort}
			{else}
				{translate key="common.none"}
			{/if}
	</p>
	<p><strong>{translate key="article.suppFilesAbbrev"}</strong><br/>
			{foreach name="suppFiles" from=$suppFiles item=suppFile}
				{if $suppFile->getFileId()}
					<a href="{url op="downloadFile" path=$submission->getId()|to_array:$suppFile->getFileId()}" class="file descargar_general">{$suppFile->getFileName()|escape}</a>
					&nbsp;&nbsp;
				{/if}
				{if $suppFile->getDateModified()}
					{$suppFile->getDateModified()|date_format:$dateFormatShort}<br/>
				{else}
					{$suppFile->getDateSubmitted()|date_format:$dateFormatShort}<br/>
				{/if}
				<a href="{url op="editSuppFile" from="submission" path=$submission->getId()|to_array:$suppFile->getId()}" class="action editar_general">{translate key="common.edit"}</a>
				&nbsp;|&nbsp;
				<a href="{url op="deleteSuppFile" from="submission" path=$submission->getId()|to_array:$suppFile->getId()}" onclick="return confirm('{translate|escape:"jsparam" key="author.submit.confirmDeleteSuppFile"}')" class="action delete">{translate key="common.delete"}</a>
				{if !$notFirst}
					<br/>
					<a href="{url op="addSuppFile" from="submission" path=$submission->getId()}" class="action crear_general">{translate key="submission.addSuppFile"}</a>
				{/if}
				<br />
				{assign var=notFirst value=1}
			{foreachelse}
				{translate key="common.none"}&nbsp;&nbsp;&nbsp;&nbsp;<a href="{url op="addSuppFile" from="submission" path=$submission->getId()}" class="action crear_general">{translate key="submission.addSuppFile"}</a>
			{/foreach}
	</p>
	<p><strong>{translate key="submission.submitter"}</strong><br/>
		<td colspan="2" class="value">
			{assign var="submitter" value=$submission->getUser()}
			{assign var=emailString value=$submitter->getFullName()|concat:" <":$submitter->getEmail():">"}
			{url|assign:"url" page="user" op="email" redirectUrl=$currentUrl to=$emailString|to_array subject=$submission->getLocalizedTitle|strip_tags articleId=$submission->getId()}
			{$submitter->getFullName()|escape} {icon name="mail" url=$url}
		</td>
	</p>
	<p><strong>{translate key="common.dateSubmitted"}</strong><br/>
		{$submission->getDateSubmitted()|date_format:$dateFormatShort}
	</p>
	<p><strong>{translate key="section.section"}</strong><br/>
		{$submission->getSectionTitle()|escape}<br/>
		<form action="{url op="updateSection" path=$submission->getId()}" method="post">{translate key="submission.changeSection"} <br/>
		<select name="section" size="1" class="selectMenu input-medium">{html_options options=$sections selected=$submission->getSectionId()}</select> <br/>
		<input type="submit" value="{translate key="common.record"}" class="btn btn-small" /></form>
	</p>
	{if $submission->getCommentsToEditor()}
	<p><strong>{translate key="article.commentsToEditor"}</strong><br/>
		{$submission->getCommentsToEditor()|strip_unsafe_html|nl2br}
	</p>
	{/if}
	{if $publishedArticle}
	<p><strong>{translate key="submission.abstractViews"}</strong><br/>	
		{$publishedArticle->getViews()}	
	</p>
	{/if}
</div>
{* MODIFICADO OJS V.2.4.2 / 04-2013*}
