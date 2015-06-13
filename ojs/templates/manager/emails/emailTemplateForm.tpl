{**
 * templates/manager/emails/emailTemplateForm.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Basic journal settings under site administration.
 *
 *}
{strip}
{if !$isNewTemplate}
	{assign var="pageTitle" value="manager.emails.editEmail"}
{else}
	{assign var="pageTitle" value="manager.emails.createEmail"}
{/if}
{include file="common/header.tpl"}
{/strip}
<div id="emailTemplateForm">
<form method="post" action="{url op="updateEmail"}">
<input type="hidden" name="emailId" value="{$emailId|escape}" />
<input type="hidden" name="journalId" value="{$journalId|escape}" />
{if !$isNewTemplate}
	<input type="hidden" name="emailKey" value="{$emailKey|escape}" />
{/if}

{if $description}
	<p>{$description|escape}</p>
{/if}

<br/>

{include file="common/formErrors.tpl"}

<table class="data" width="100%">

{if $isNewTemplate}
	<tr valign="top">
		<td width="20%" class="label">{fieldLabel name="emailKey" key="manager.emails.emailKey"}</td>
		<td width="80%" class="value"><input type="text" name="emailKey" value="{$emailKey|escape}" id="emailKey" size="20" maxlength="120" class="textField" /><br/>&nbsp;</td>
	</tr>
{/if}

{foreach from=$supportedLocales item=localeName key=localeKey}
	<tr valign="top"><td colspan="2">
		<h3>{translate key="manager.emails.emailTemplate"} ({$localeName|escape})</h3>
	</td></tr>

	<tr valign="top">
		<td width="20%" class="label">{fieldLabel name="subject-$localeKey" key="email.subject"}</td>
		<td width="80%" class="value"><input type="text" name="subject[{$localeKey|escape}]" id="subject-{$localeKey|escape}" value="{$subject.$localeKey|escape}" size="70" maxlength="120" class="textField input-xxlarge" /></td>
	</tr>
	<tr valign="top">
		<td class="label">{fieldLabel name="body-$localeKey" key="email.body"}</td>
		<td class="value"><textarea name="body[{$localeKey|escape}]" id="body-{$localeKey|escape}" cols="70" rows="20" class="textArea  input-xxlarge">{$body.$localeKey|escape}</textarea></td>
	</tr>
{foreachelse}
<tr valign="top"><td colspan="2">
	<h3>{translate key="manager.emails.emailTemplate"}</h3>
</td></tr>

	<tr valign="top">
		<td width="20%" class="label">{fieldLabel name="subject-$currentLocale" key="email.subject"}</td>
		<td width="80%" class="value"><input type="text" name="subject[{$currentLocale|escape}]" id="subject-{$currentLocale|escape}" value="{$subject.$currentLocale|escape}" size="70" maxlength="120" class="textField " /></td>
	</tr>
	<tr valign="top">
		<td class="label">{fieldLabel name="body-$currentLocale" key="email.body"}</td>
		<td class="value"><textarea name="body[{$currentLocale|escape}]" id="body-{$currentLocale|escape}" cols="70" rows="20" class="textArea">{$body.$currentLocale|escape}</textarea></td>
	</tr>
{/foreach}
</table>

{if $canDisable}
<p><label class="checckbox" for="emailEnabled"><input type="checkbox" name="enabled" id="emailEnabled" value="1"{if $enabled} checked="checked"{/if} /> {translate key="manager.emails.enabled"}</label></p>
{/if}

<p style="text-align:right;"><input type="button" value="{translate key="common.cancel"}" class="btn btn-danger btn-small" onclick="document.location.href='{url op="emails" escape=false}'" /> <input type="reset" class="btn btn-danger btn-small" /> <input type="submit" value="{translate key="common.save"}" class="btn btn-small" /> </p>
</form>
</div>
{include file="common/footer.tpl"}

{* MODIFICADO OJS V.2.4.2 / 04-2013*}