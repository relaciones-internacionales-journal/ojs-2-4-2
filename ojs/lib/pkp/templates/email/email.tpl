{**
 * templates/email/email.tpl
 *
 * Copyright (c) 2000-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Generic email template form
 *
 *}
{strip}
{assign var="pageTitle" value="email.compose"}
{assign var="pageCrumbTitle" value="email.email"}
{include file="common/header.tpl"}
{/strip}

<script type="text/javascript">
{literal}
<!--
function deleteAttachment(fileId) {
	var emailForm = document.getElementById('emailForm');
	emailForm.deleteAttachment.value = fileId;
	emailForm.submit();
}
// -->
{/literal}
</script>
<div class="email_form">
<form method="post" id="emailForm" action="{$formActionUrl}"{if $attachmentsEnabled} enctype="multipart/form-data"{/if}>
<input type="hidden" name="continued" value="1"/>
{if $hiddenFormParams}
	{foreach from=$hiddenFormParams item=hiddenFormParam key=key}
		<input type="hidden" name="{$key|escape}" value="{$hiddenFormParam|escape}" />
	{/foreach}
{/if}

{if $attachmentsEnabled}
	<input type="hidden" name="deleteAttachment" value="" />
	{foreach from=$persistAttachments item=temporaryFile}
		{if is_object($temporaryFile)}<input type="hidden" name="persistAttachments[]" value="{$temporaryFile->getId()}" />{/if}
	{/foreach}
{/if}

{include file="common/formErrors.tpl"}

{foreach from=$errorMessages item=message}
	{if !$notFirstMessage}
		{assign var=notFirstMessage value=1}
		<h4>{translate key="form.errorsOccurred"}</h4>
		<ul class="plain">
	{/if}
	{if $message.type == MAIL_ERROR_INVALID_EMAIL}
		{translate|assign:"message" key="email.invalid" email=$message.address}
		<li>{$message|escape}</li>
	{/if}
{/foreach}

{if $notFirstMessage}
	</ul>
	<br/>
{/if}

<div class="control-group">
	<label class="control-label">{fieldLabel name="to" key="email.to"}</label>
	<div class="controls">
		{foreach from=$to item=toAddress}
			<input type="text" name="to[]" id="to" value="{if $toAddress.name != ''}{$toAddress.name|escape} &lt;{$toAddress.email|escape}&gt;{else}{$toAddress.email|escape}{/if}" {if !$addressFieldsEnabled}disabled="disabled" {/if}size="40" maxlength="120" class="textField input-xxlarge" /><br/>
		{foreachelse}
			<input type="text" name="to[]" id="to" size="40" maxlength="120" class="textField input-xxlarge" {if !$addressFieldsEnabled}disabled="disabled" {/if}/>
		{/foreach}

		{if $blankTo}
			<input type="text" name="to[]" id="to" size="40" maxlength="120" class="textField input-xxlarge" {if !$addressFieldsEnabled}disabled="disabled" {/if}/>
		{/if}
	</div>
</div>
<div class="control-group">
	<label class="control-label">{fieldLabel name="cc" key="email.cc"}</label>
	<div class="controls">
		{foreach from=$cc item=ccAddress}
			<input type="text" name="cc[]" id="cc" value="{if $ccAddress.name != ''}{$ccAddress.name|escape} &lt;{$ccAddress.email|escape}&gt;{else}{$ccAddress.email|escape}{/if}" size="40" maxlength="120" class="textField input-xxlarge" {if !$addressFieldsEnabled}disabled="disabled" {/if}/><br/>
		{foreachelse}
			<input type="text" name="cc[]" id="cc" size="40" maxlength="120" class="textField input-xxlarge" {if !$addressFieldsEnabled}disabled="disabled" {/if}/>
		{/foreach}

		{if $blankCc}
			<input type="text" name="cc[]" id="cc" size="40" maxlength="120" class="textField input-xxlarge" {if !$addressFieldsEnabled}disabled="disabled" {/if}/>
		{/if}
	</div>
</div>
<div class="control-group">
	<label class="control-label">{fieldLabel name="bcc" key="email.bcc"}</label>
	<div class="controls">
		{foreach from=$bcc item=bccAddress}
			<input type="text" name="bcc[]" id="bcc" value="{if $bccAddress.name != ''}{$bccAddress.name|escape} &lt;{$bccAddress.email|escape}&gt;{else}{$bccAddress.email|escape}{/if}" size="40" maxlength="120" class="textField input-xxlarge" {if !$addressFieldsEnabled}disabled="disabled" {/if}/><br/>
		{foreachelse}
			<inputtype="text" name="bcc[]" id="bcc" size="40" maxlength="120" class="textField input-xxlarge" {if !$addressFieldsEnabled}disabled="disabled" {/if}/>
		{/foreach}

		{if $blankBcc}
			<inputtype="text" name="bcc[]" id="bcc" size="40" maxlength="120" class="textField input-xxlarge" {if !$addressFieldsEnabled}disabled="disabled" {/if}/>
		{/if}
	</div>
</div>
{if $addressFieldsEnabled}
<div>
		<input type="submit" name="blankTo" class="btn btn-small" value="{translate key="email.addToRecipient"}"/>
		<input type="submit" name="blankCc" class="btn btn-small" value="{translate key="email.addCcRecipient"}"/>
		<input type="submit" name="blankBcc" class="btn btn-small" value="{translate key="email.addBccRecipient"}"/>
		{if $senderEmail}
			<br/><br/>
			<label class="checkbox" for="bccSender"><input type="checkbox" name="bccSender" id="bccSender" value="1"{if $bccSender} checked{/if} /> {translate key="email.bccSender" address=$senderEmail|escape}</label>
		{/if}
</div>
{/if}{* $addressFieldsEnabled *}
<hr/>
{if $attachmentsEnabled}
<div class="control-group">
	<label class="control-label">{translate key="email.attachments"}</label>
	<div class="controls">
		{assign var=attachmentNum value=1}
		{foreach from=$persistAttachments item=temporaryFile}
			{if is_object($temporaryFile)}
				{$attachmentNum|escape}.&nbsp;{$temporaryFile->getOriginalFileName()|escape}&nbsp;
				({$temporaryFile->getNiceFileSize()})&nbsp;
				<a href="javascript:deleteAttachment({$temporaryFile->getId()})" class="action delete">{translate key="common.delete"}</a>
				<br/>
				{assign var=attachmentNum value=$attachmentNum+1}
			{/if}
		{/foreach}

		{if $attachmentNum != 1}<br/>{/if}
			<div class="fileupload fileupload-new" data-provides="fileupload">
				<span class="btn btn-file btn-small">
					<span class="fileupload-new">{translate key="plugins.block.navigation.journalContent"}</span>
					<span class="fileupload-exists">{translate key="submission.changeSection"}</span>
					<input type="file" name="newAttachment" class="pkp_form_uploadField" />{*{translate key="plugins.block.navigation.journalContent"}*}
				</span>
				<span class="fileupload-preview"></span>
				<a href="#" class="close fileupload-exists" data-dismiss="fileupload" style="float: none">X</a><br/><br/>
				<input name="addAttachment" type="submit" class="btn btn-small" value="{translate key="common.upload"}" />
			</div>		
	</div>
</div>
<hr/>
{/if}
<div class="control-group">
	<label class="control-label">{translate key="email.from"}</label>
	<div class="controls"><input type="text" id="from" name="from" value="{$from|escape}" size="60" maxlength="120" class="textField input-xxlarge" />
	</div>
</div>
<div class="control-group">
	<label class="control-label">{fieldLabel name="subject" key="email.subject"}</label>
	<div class="controls"><input type="text" id="subject" name="subject" value="{$subject|escape}" size="60" maxlength="120" class="textField input-xxlarge" /></td>
	</div>
</div>
<div class="control-group">
	<label class="control-label">{fieldLabel name="body" key="email.body"}</label>
	<div class="controls"><textarea class="input-xxlarge" name="body" cols="60" rows="15" class="textArea">{$body|escape}</textarea></td>
	</div>
</div>
<div class="separator"><hr/></div>

<p style="text-align:right"><input type="button" value="{translate key="common.cancel"}" class="btn btn-danger btn-small" onclick="history.go(-1)" />{if !$disableSkipButton} <input name="send[skip]" type="submit" value="{translate key="email.skip"}" class="btn btn-danger btn-small" />{/if} <input name="send" type="submit" value="{translate key="email.send"}" class="btn btn-small" /></p>
</form>
</div>
{include file="common/footer.tpl"}
{* MODIFICADO OJS V.2.4.2 / 04-2013*}