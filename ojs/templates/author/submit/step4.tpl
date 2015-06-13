{**
 * templates/author/submit/step4.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Step 4 of author article submission.
 *
 *}
{assign var="pageTitle" value="author.submit.step4"}
{include file="author/submit/submitHeader.tpl"}

<script type="text/javascript">
{literal}
<!--
function confirmForgottenUpload() {
	var fieldValue = document.getElementById('submitForm').uploadSuppFile.value;
	if (fieldValue) {
		return confirm("{/literal}{translate key="author.submit.forgottenSubmitSuppFile"}{literal}");
	}
	return true;
}
// -->
{/literal}
</script>

<form id="submitForm" method="post" action="{url op="saveSubmit" path=$submitStep}" enctype="multipart/form-data">
<input type="hidden" name="articleId" value="{$articleId|escape}" />
{include file="common/formErrors.tpl"}

<p>{translate key="author.submit.supplementaryFilesInstructions"}</p>

{foreach from=$suppFiles item=file}
<hr/>
	<p><strong>{translate key="common.id"}: </strong>{$file->getSuppFileId()}</p>
	<p><strong>{translate key="common.title"}: </strong>{$file->getSuppFileTitle()|escape}</p>
	<p><strong>{translate key="common.originalFileName"}: </strong>{$file->getOriginalFileName()|escape}</p>
	<p><strong>{translate key="common.dateUploaded"}: </strong>{$file->getDateSubmitted()|date_format:$dateFormatTrunc}</p>
	<p><strong>{translate key="common.action"}: </strong><br/><a href="{url op="submitSuppFile" path=$file->getSuppFileId() articleId=$articleId}" class="action editar_general">{translate key="common.edit"}</a>&nbsp;|&nbsp;<a href="{url op="deleteSubmitSuppFile" path=$file->getSuppFileId() articleId=$articleId}" onclick="return confirm('{translate|escape:"jsparam" key="author.submit.confirmDeleteSuppFile"}')" class="action delete">{translate key="common.delete"}</a></p>
<hr/>
{foreachelse}
<p><strong>{translate key="author.submit.noSupplementaryFiles"}</strong></p>
{/foreach}

<p><strong>{fieldLabel name="uploadSuppFile" key="author.submit.uploadSuppFile"} </strong></p>

		<div class="fileupload fileupload-new" data-provides="fileupload">
			<span class="btn btn-file btn-small">
				<span class="fileupload-new">{translate key="plugins.block.navigation.journalContent"}</span>
				<span class="fileupload-exists">{translate key="submission.changeSection"}</span>
				<input type="file" name="uploadSuppFile" id="uploadSuppFile"  class="uploadField" />
			</span>
			<span class="fileupload-preview"></span>
			<a href="#" class="close fileupload-exists" data-dismiss="fileupload" style="float: none">X</a><br/><br/>
			<input name="submitUploadSuppFile" type="submit" class="btn btn-small" value="{translate key="common.upload"}" />
		</div>
		{if $currentJournal->getSetting('showEnsuringLink')}<br/><br/><a class="action info_general" href="javascript:openHelp('{get_help_id key="editorial.sectionEditorsRole.review.blindPeerReview" url="true"}')">{translate key="reviewer.article.ensuringBlindReview"}</a>{/if}

<div class="separator"><hr/></div>

<p style="text-align:right;"><input type="button" value="{translate key="common.cancel"}" class="btn btn-danger btn-small" onclick="confirmAction('{url page="author"}', '{translate|escape:"jsparam" key="author.submit.cancelSubmission"}')" /> <input type="submit" onclick="return confirmForgottenUpload()" value="{translate key="common.saveAndContinue"}" class="btn btn-small" /></p>

</form>

{include file="common/footer.tpl"}
{* MODIFICADO OJS V.2.4.2 / 04-2013*}
