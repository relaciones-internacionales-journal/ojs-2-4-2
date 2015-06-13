{**
 * templates/author/submit/suppFile.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Add/edit a supplementary file.
 *
 *}
{assign var="pageTitle" value="author.submit.step4a"}
{include file="author/submit/submitHeader.tpl"}

<p class="author_submit_backtopage"><a href="{url op="submit" path=4 articleId=$articleId}">&lt;&lt; {translate key="author.submit.backToSupplementaryFiles"}</a></p>

<form id="submit" method="post" action="{url op="saveSubmitSuppFile" path=$suppFileId}" enctype="multipart/form-data">
<input type="hidden" name="articleId" value="{$articleId|escape}" />
{include file="common/formErrors.tpl"}

{if count($formLocales) > 1}
<div id="locale">
<table width="100%" class="data">
	<tr valign="top">
		<td width="20%" class="label">{fieldLabel name="formLocale" key="form.formLanguage"}</td>
		<td width="80%" class="value">
			{url|assign:"submitFormUrl" path=$suppFileId articleId=$articleId escape=false}
			{form_language_chooser form="submit" url=$submitFormUrl}
			<span class="instruct">{translate key="form.formLanguage.description"}</span>
		</td>
	</tr>
</table>
</div>
{/if}
<div id="author_submit_supplementaryFileData">
<h3>{translate key="author.submit.supplementaryFileData"}</h3>

<p>{translate key="author.submit.supplementaryFileDataDescription"}</p>

<table class="data_alt" width="100%">
<tr valign="top">
	<td width="20%" class="label">{fieldLabel required="true" name="title" key="common.title"}</td>
	<td width="80%" class="value"><input type="text" class="textField input-xlarge" name="title[{$formLocale|escape}]" id="title" value="{$title[$formLocale]|escape}" size="60" maxlength="255" /></td>
</tr>
<tr valign="top">
	<td width="20%" class="label">{fieldLabel name="creator" key="author.submit.suppFile.createrOrOwner"}</td>
	<td width="80%" class="value"><input type="text" name="creator[{$formLocale|escape}]" class="textField input-xlarge" id="creator" value="{$creator[$formLocale]|escape}" size="60" maxlength="255" /></td>
</tr>
<tr valign="top">
	<td width="20%" class="label">{fieldLabel name="subject" key="common.keywords"}</td>
	<td width="80%" class="value"><input type="text" name="subject[{$formLocale|escape}]" class="textField input-xlarge" id="subject" value="{$subject[$formLocale]|escape}" size="60" maxlength="255" /></td>
</tr>
<tr valign="top">
	<td width="20%" class="label">{fieldLabel name="type" key="common.type"}</td>
	<td width="80%" class="value"><select name="type" class="selectMenu" id="type" size="1">{html_options_translate output=$typeOptionsOutput values=$typeOptionsValues translateValues="true" selected=$type}</select><br /><label for="typeOther">{translate key="author.submit.suppFile.specifyOtherType"}</label> <input type="text" name="typeOther[{$formLocale|escape}]" id="typeOther" class="textField" value="{$typeOther[$formLocale]|escape}" size="45" maxlength="255" /></td>
</tr>
<tr valign="top">
	<td width="20%" class="label">{fieldLabel name="description" key="author.submit.suppFile.briefDescription"}</td>
	<td width="80%" class="value"><textarea name="description[{$formLocale|escape}]" class="textArea" id="description" rows="5" cols="60">{$description[$formLocale]|escape}</textarea></td>
</tr>
<tr valign="top">
	<td width="20%" class="label">{fieldLabel name="publisher" key="common.publisher"}</td>
	<td width="80%" class="value"><input type="text" name="publisher[{$formLocale|escape}]" class="textField input-xlarge" id="publisher" value="{$publisher[$formLocale]|escape}" size="60" maxlength="255" />
<br/><span class="instruct">{translate key="author.submit.suppFile.publisherDescription"}</span><br/><br/></td>
</tr>
<tr valign="top">
	<td width="20%" class="label">{fieldLabel name="sponsor" key="author.submit.suppFile.contributorOrSponsor"}</td>
	<td width="80%" class="value"><input type="text" name="sponsor[{$formLocale|escape}]" class="textField input-xlarge" id="sponsor" value="{$sponsor[$formLocale]|escape}" size="60" maxlength="255" /></td>
</tr>
<tr valign="top">
	<td width="20%" class="label">{fieldLabel name="dateCreated" key="common.date"}</td>
	<td width="80%" class="value"><input type="text" name="dateCreated" class="textField input-xlarge" id="dateCreated" value="{$dateCreated|escape}" size="11" maxlength="10" /> <br/>{translate key="submission.date.yyyymmdd"}</td>
</tr>
<tr valign="top">
	<td>&nbsp;</td>
	<td><span class="instruct">{translate key="author.submit.suppFile.dateDescription"}</span><br/><br/></td>
</tr>
<tr valign="top">
	<td width="20%" class="label">{fieldLabel name="source" key="common.source"}</td>
	<td width="80%" class="value"><input type="text" name="source[{$formLocale|escape}]" class="textField input-xlarge" id="source" value="{$source[$formLocale]|escape}" size="60" maxlength="255" /></td>
</tr>
<tr valign="top">
	<td>&nbsp;</td>
	<td><span class="instruct">{translate key="author.submit.suppFile.sourceDescription"}</span><br/><br/></td>
</tr>
<tr valign="top">
	<td width="20%" class="label">{fieldLabel name="language" key="common.language"}</td>
	<td width="80%" class="value"><input type="text" name="language" class="textField input-xlarge" id="language" value="{$language|escape}" size="5" maxlength="10" /></td>
</tr>
<tr valign="top">
	<td>&nbsp;</td>
	<td><span class="instruct">{translate key="author.submit.languageInstructions"}</span><br/><br/></td>
</tr>
</table>
</div>
<div class="separator"></div>

{call_hook name="Templates::Author::Submit::SuppFile::AdditionalMetadata"}

<div id="author_submit_supplementaryFileUpload">
	<h3>{translate key="author.submit.supplementaryFileUpload"}</h3>

	{if $suppFile && $suppFile->getFileId()}
		<p><strong>{translate key="common.fileName"}: </strong>
			<a href="{url op="download" path=$articleId|to_array:$suppFile->getFileId()}">{$suppFile->getFileName()|escape}</a>
		</p>
		<p><strong>{translate key="common.originalFileName"}: </strong>
			{$suppFile->getOriginalFileName()|escape}
		</p>
		<p><strong>{translate key="common.fileSize"}: </strong>
			{$suppFile->getNiceFileSize()}
		</p>
		<p><strong>{translate key="common.dateUploaded"}: </strong>
			{$suppFile->getDateUploaded()|date_format:$datetimeFormatShort}
		</p>
		<label class="checkbox" for="showReviewers"><input type="checkbox" name="showReviewers" id="showReviewers" value="1"{if $showReviewers==1} checked="checked"{/if} />
			{translate key="author.submit.suppFile.availableToPeers"}</label>
		{else}
		<p><strong>{translate key="author.submit.suppFile.noFile"}
		</p>
	{/if}
	
</div>

<div class="separator"></div>

{if $suppFile && $suppFile->getFileId()}
	<p><strong>{fieldLabel name="uploadSuppFile" key="common.replaceFile"}</strong></p>
{else}
	<p><strong>{fieldLabel name="uploadSuppFile" key="common.upload"}</strong></p>
{/if}

	<div class="fileupload fileupload-new" data-provides="fileupload">
		<span class="btn btn-file btn-small">
			<span class="fileupload-new">{translate key="plugins.block.navigation.journalContent"}</span>
			<span class="fileupload-exists">{translate key="submission.changeSection"}</span>
			<input type="file" name="uploadSuppFile" id="uploadSuppFile" class="uploadField" />
		</span>
		<span class="fileupload-preview"></span>
		<a href="#" class="close fileupload-exists" data-dismiss="fileupload" style="float: none">X</a><br/><br/>
	</div>

{translate key="form.saveToUpload"}
{if not ($suppFile && $suppFile->getFileId())}
    <label class="checkbox" for="showReviewers"><input type="checkbox" name="showReviewers" id="showReviewers" value="1"{if $showReviewers==1} checked="checked"{/if} />&nbsp;
	{translate key="author.submit.suppFile.availableToPeers"}</label>
{/if}

<div class="separator"><hr/></div>

<p style="text-align:right;"><input type="button" value="{translate key="common.cancel"}" class="btn btn-danger btn-small" onclick="document.location.href='{url op="submit" path="4" articleId=$articleId escape=false}'" /> <input type="submit" value="{translate key="common.saveAndContinue"}" class="btn btn-small" /> </p>

<p>{translate key="common.requiredField"}</p>

</form>

{include file="common/footer.tpl"}
{* MODIFICADO OJS V.2.4.2 / 04-2013*}
