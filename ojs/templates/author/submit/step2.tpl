{**
 * templates/author/submit/step2.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Step 2 of author article submission.
 *
 *}
{assign var="pageTitle" value="author.submit.step2"}
{include file="author/submit/submitHeader.tpl"}

<form method="post" action="{url op="saveSubmit" path=$submitStep}" enctype="multipart/form-data">
<input type="hidden" name="articleId" value="{$articleId|escape}" />
{include file="common/formErrors.tpl"}

<div id="author_submissionFile">
<h3>{translate key="author.submit.submissionFile"}</h3>
{if $submissionFile}
<p><strong>{translate key="common.fileName"}: </strong>
	<a href="{url op="download" path=$articleId|to_array:$submissionFile->getFileId()}">{$submissionFile->getFileName()|escape}</a>
</p>
<p><strong>{translate key="common.originalFileName"}: </strong>
	{$submissionFile->getOriginalFileName()|escape}
	</p>
<p><strong>{translate key="common.fileSize"}: </strong>
	{$submissionFile->getNiceFileSize()}
</p>
<p><strong>{translate key="common.dateUploaded"}: </strong>
	{$submissionFile->getDateUploaded()|date_format:$datetimeFormatShort}
</p>
{else}
<p><strong>{translate key="author.submit.noSubmissionFile"}</strong></p>
{/if}
</div>
<hr/>
<div id="addSubmissionFile">
		{if $submissionFile}
			<p><strong>{fieldLabel name="submissionFile" key="author.submit.replaceSubmissionFile"}</strong></p>
		{else}
			<p><strong>{fieldLabel name="submissionFile" key="author.submit.uploadSubmissionFile"}</strong></p>
		{/if}
		<div class="fileupload fileupload-new" data-provides="fileupload">
			<span class="btn btn-file btn-small">
				<span class="fileupload-new">{translate key="plugins.block.navigation.journalContent"}</span>
				<span class="fileupload-exists">{translate key="submission.changeSection"}</span>
				<input type="file" class="uploadField" name="submissionFile" id="submissionFile" />
			</span>
			<span class="fileupload-preview"></span>
			<a href="#" class="close fileupload-exists" data-dismiss="fileupload" style="float: none">X</a><br/><br/>
			<input name="uploadSubmissionFile" type="submit" class="btn btn-small" value="{translate key="common.upload"}" />
			</div>
		{if $currentJournal->getSetting('showEnsuringLink')}<a class="action info_general" href="javascript:openHelp('{get_help_id key="editorial.sectionEditorsRole.review.blindPeerReview" url="true"}')">{translate key="reviewer.article.ensuringBlindReview"}</a>{/if}
</div>
<hr/>
<p style="text-align:right;"><input type="button" value="{translate key="common.cancel"}" class="btn btn-danger btn-small" onclick="confirmAction('{url page="author"}', '{translate|escape:"jsparam" key="author.submit.cancelSubmission"}')" /> <input type="submit"{if !$submissionFile} onclick="return confirm('{translate|escape:"jsparam" key="author.submit.noSubmissionConfirm"}')"{/if} value="{translate key="common.saveAndContinue"}" class="btn btn-small" /></p>
<hr/>
<div id="uploadInstructions">{translate key="author.submit.uploadInstructions"}</div>

{if $journalSettings.supportPhone}
	{assign var="howToKeyName" value="author.submit.howToSubmit"}
{else}
	{assign var="howToKeyName" value="author.submit.howToSubmitNoPhone"}
{/if}

<p>{translate key=$howToKeyName supportName=$journalSettings.supportName supportEmail=$journalSettings.supportEmail supportPhone=$journalSettings.supportPhone}</p>

</form>

{include file="common/footer.tpl"}
{* MODIFICADO OJS V.2.4.2 / 04-2013*}
