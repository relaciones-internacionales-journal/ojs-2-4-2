{**
 * templates/author/submission/copyedit.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the copyediting table.
 *
 *}
<div id="copyedit">
<h3>{translate key="submission.copyediting"}</h3>

{if $useCopyeditors}
<table class="data" width="100%">
	<tr>
		<td class="label" width="20%">{translate key="user.role.copyeditor"}</td>
		<td class="label" width="80%">{if $submission->getUserIdBySignoffType('SIGNOFF_COPYEDITING_INITIAL')}{$copyeditor->getFullName()|escape}{else}{translate key="common.none"}{/if}</td>
	</tr>
</table>
{/if}

<table width="100%" class="info">
	<tr>
		<td width="40%" colspan="2"><a href="{url op="viewMetadata" path=$submission->getId()}" class="action editar_general">{translate key="submission.reviewMetadata"}</a></td>
		<td width="20%" class="heading">{translate key="submission.request"}</td>
		<td width="20%" class="heading">{translate key="submission.underway"}</td>
		<td width="20%" class="heading">{translate key="submission.complete"}</td>
	</tr>
	<tr>
		<td width="5%">1.</td>
		{assign var="copyeditInitialSignoff" value=$submission->getSignoff('SIGNOFF_COPYEDITING_INITIAL')}
		<td width="35%">{translate key="submission.copyedit.initialCopyedit"}</td>
		<td>{$copyeditInitialSignoff->getDateNotified()|date_format:$dateFormatShort|default:"&mdash;"}</td>
		<td>{$copyeditInitialSignoff->getDateUnderway()|date_format:$dateFormatShort|default:"&mdash;"}</td>
		<td>{$copyeditInitialSignoff->getDateCompleted()|date_format:$dateFormatShort|default:"&mdash;"}</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td colspan="4">
			{translate key="common.file"}:
			{if $copyeditInitialSignoff->getDateCompleted() && $initialCopyeditFile}
				<a href="{url op="downloadFile" path=$submission->getId()|to_array:$copyeditInitialSignoff->getFileId():$copyeditInitialSignoff->getFileRevision()}" class="file">{$initialCopyeditFile->getFileName()|escape}</a>&nbsp;&nbsp;{$initialCopyeditFile->getDateModified()|date_format:$dateFormatShort}
			{else}
				{translate key="common.none"}
			{/if}
		</td>
	</tr>
	<tr>
		<td colspan="5" class="separator">&nbsp;</td>
	</tr>
	<tr>
		<td>2.</td>
		{assign var="copyeditAuthorSignoff" value=$submission->getSignoff('SIGNOFF_COPYEDITING_AUTHOR')}
		<td>{translate key="submission.copyedit.editorAuthorReview"}</td>
		<td>{$copyeditAuthorSignoff->getDateNotified()|date_format:$dateFormatShort|default:"&mdash;"}</td>
		<td>{$copyeditAuthorSignoff->getDateUnderway()|date_format:$dateFormatShort|default:"&mdash;"}</td>
		<td>
			{if not $copyeditAuthorSignoff->getDateNotified() or $copyeditAuthorSignoff->getDateCompleted()}
				{icon name="mail" disabled="disabled"}
			{else}
				{url|assign:"url" op="completeAuthorCopyedit" articleId=$submission->getId()}
				{translate|assign:"confirmMessage" key="common.confirmComplete"}
				{icon name="mail" onclick="return confirm('$confirmMessage')" url=$url}
			{/if}
			{$copyeditAuthorSignoff->getDateCompleted()|date_format:$dateFormatShort|default:""}
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td colspan="5">
			{translate key="common.file"}:
			{if $copyeditAuthorSignoff->getDateNotified() && $editorAuthorCopyeditFile}
				<a href="{url op="downloadFile" path=$submission->getId()|to_array:$copyeditAuthorSignoff->getFileId():$copyeditAuthorSignoff->getFileRevision()}" class="file">{$editorAuthorCopyeditFile->getFileName()|escape}</a>&nbsp;&nbsp;{$editorAuthorCopyeditFile->getDateModified()|date_format:$dateFormatShort}
			{else}
				{translate key="common.none"}
			{/if}
			<br /><br />
			<form method="post" action="{url op="uploadCopyeditVersion"}"  enctype="multipart/form-data">
				<input type="hidden" name="articleId" value="{$submission->getId()}" />
				<input type="hidden" name="copyeditStage" value="author" />
				<div class="fileupload fileupload-new" data-provides="fileupload">
					<span class="btn btn-file btn-small">
						<span class="fileupload-new">{translate key="plugins.block.navigation.journalContent"}</span>
						<span class="fileupload-exists">{translate key="submission.changeSection"}</span>
						<input type="file" name="upload"{if not $copyeditAuthorSignoff->getDateNotified() or $copyeditAuthorSignoff->getDateCompleted()} disabled="disabled"{/if} class="uploadField" />
					</span>
					<span class="fileupload-preview"></span>
					<a href="#" class="close fileupload-exists" data-dismiss="fileupload" style="float: none">X</a> 
					<input type="submit" class="btn btn-small" value="{translate key="common.upload"}"{if not $copyeditAuthorSignoff->getDateNotified() or $copyeditAuthorSignoff->getDateCompleted()} disabled="disabled"{/if} />
				</div>
				
				
			</form>
		</td>
	</tr>
	<tr>
		<td colspan="5" class="separator">&nbsp;</td>
	</tr>
	<tr>
		<td>3.</td>
		{assign var="copyeditFinalSignoff" value=$submission->getSignoff('SIGNOFF_COPYEDITING_FINAL')}
		<td>{translate key="submission.copyedit.finalCopyedit"}</td>
		<td>{$copyeditFinalSignoff->getDateNotified()|date_format:$dateFormatShort|default:"&mdash;"}</td>
		<td>{$copyeditFinalSignoff->getDateUnderway()|date_format:$dateFormatShort|default:"&mdash;"}</td>
		<td>{$copyeditFinalSignoff->getDateCompleted()|date_format:$dateFormatShort|default:"&mdash;"}</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td colspan="4">
			{translate key="common.file"}:
			{if $copyeditFinalSignoff->getDateCompleted() && $finalCopyeditFile}
				<a href="{url op="downloadFile" path=$submission->getId()|to_array:$copyeditFinalSignoff->getFileId():$copyeditFinalSignoff->getFileRevision()}" class="file">{$finalCopyeditFile->getFileName()|escape}</a>&nbsp;&nbsp;{$finalCopyeditFile->getDateModified()|date_format:$dateFormatShort}
			{else}
				{translate key="common.none"}
			{/if}
		</td>
	</tr>
	<tr>
		<td colspan="5" class="separator">&nbsp;</td>
	</tr>
</table>

{translate key="submission.copyedit.copyeditComments"}
{if $submission->getMostRecentCopyeditComment()}
	{assign var="comment" value=$submission->getMostRecentCopyeditComment()}
	<a href="javascript:openComments('{url op="viewCopyeditComments" path=$submission->getId() anchor=$comment->getId()}');" class="icon">{icon name="comment"}</a>{$comment->getDatePosted()|date_format:$dateFormatShort}
{else}
	<a href="javascript:openComments('{url op="viewCopyeditComments" path=$submission->getId()}');" class="icon">{icon name="comment"}</a>{translate key="common.noComments"}
{/if}

{if $currentJournal->getLocalizedSetting('copyeditInstructions') != ''}
&nbsp;&nbsp;
<a href="javascript:openHelp('{url op="instructions" path="copy"}')" class="action info_general">{translate key="submission.copyedit.instructions"}</a>
{/if}
</div>
{* MODIFICADO OJS V.2.4.2 / 04-2013*}