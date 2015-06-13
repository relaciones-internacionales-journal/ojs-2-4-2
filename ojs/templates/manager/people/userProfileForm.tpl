{**
 * templates/manager/people/userProfileForm.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * User profile form under journal management.
 *
 *}
{strip}
{url|assign:"currentUrl" op="people" path="all"}
{assign var="pageTitle" value="manager.people"}
{include file="common/header.tpl"}
{/strip}

{if not $userId}
{assign var="passwordRequired" value="true"}

{literal}
<script type="text/javascript">
<!--
	function setGenerateRandom(value) {
		var userForm = document.getElementById('userForm');
		if (value) {
			userForm.password.value='********';
			userForm.password2.value='********';
			userForm.password.disabled=1;
			userForm.password2.disabled=1;
			userForm.sendNotify.checked=1;
			userForm.sendNotify.disabled=1;
		} else {
			userForm.password.disabled=0;
			userForm.password2.disabled=0;
			userForm.sendNotify.disabled=0;
			userForm.password.value='';
			userForm.password2.value='';
			userForm.password.focus();
		}
	}

	function enablePasswordFields() {
		var userForm = document.getElementById('userForm');
		userForm.password.disabled=0;
		userForm.password2.disabled=0;
	}

	function generateUsername() {
		var userForm = document.getElementById('userForm');
		var req = makeAsyncRequest();

		if (userForm.lastName.value == "") {
			alert("{/literal}{translate key="manager.people.mustProvideName"}{literal}");
			return;
		}

		req.onreadystatechange = function() {
			if (req.readyState == 4) {
				userForm.username.value = req.responseText;
			}
		}
		sendAsyncRequest(req, '{/literal}{url op="suggestUsername" firstName="REPLACE1" lastName="REPLACE2" escape=false}{literal}'.replace('REPLACE1', escape(userForm.firstName.value)).replace('REPLACE2', escape(userForm.lastName.value)), null, 'get');
	}

// -->
</script>
{/literal}
{/if}

{if $userCreated}
<p>{translate key="manager.people.userCreatedSuccessfully"}</p>
{/if}

<h3>{if $userId}{translate key="manager.people.editProfile"}{else}{translate key="manager.people.createUser"}{/if}</h3>

<form id="userForm" method="post" action="{url op="updateUser"}" onsubmit="enablePasswordFields()">
<input type="hidden" name="source" value="{$source|escape}" />
{if $userId}
<input type="hidden" name="userId" value="{$userId|escape}" />
{/if}

{include file="common/formErrors.tpl"}

<table width="100%" class="data_alt">
{if count($formLocales) > 1}
	 <tr valign="top">
	 	<td width="20%" class="label">{fieldLabel name="formLocale" key="form.formLanguage"}</td>
		<td width="80%" class="value">
			{url|assign:"userFormUrl" page="manager" op="editUser" path=$userId escape=false}
			{form_language_chooser form="userForm" url=$userFormUrl}
			<span class="instruct">{translate key="form.formLanguage.description"}</span>
		</td>
	</tr>
{/if}
	<tr valign="top" style="display:none;">
		<td class="label">{fieldLabel name="salutation" key="user.salutation"}</td>
		<td class="value"><input type="text" name="salutation" id="salutation" value="{$salutation|escape}" size="20" maxlength="40" class="textField" /></td>
	</tr>
	<tr valign="top">
		<td class="label">{fieldLabel name="firstName" required="true" key="user.firstName"}</td>
		<td class="value"><input type="text" name="firstName" id="firstName" value="{$firstName|escape}" size="20" maxlength="40" class="textField" /></td>
	</tr>
	<tr valign="top">
		<td class="label">{fieldLabel name="middleName" key="user.middleName"}</td>
		<td class="value"><input type="text" name="middleName" id="middleName" value="{$middleName|escape}" size="20" maxlength="40" class="textField" /></td>
	</tr>
	<tr valign="top">
		<td class="label">{fieldLabel name="lastName" required="true" key="user.lastName"}</td>
		<td class="value"><input type="text" name="lastName" id="lastName" value="{$lastName|escape}" size="20" maxlength="90" class="textField" /></td>
	</tr>
	<tr valign="top" style="display:none;">
		<td class="label">{fieldLabel suppressId="true" name="gender" key="user.gender"}</td>
		<td class="value">
			<select name="gender" id="gender" size="1" class="selectMenu">
				{html_options_translate options=$genderOptions selected=$gender}
			</select>
		</td>
	</tr>
	<tr valign="top" style="display:none;">
		<td class="label">{fieldLabel name="initials" key="user.initials"}</td>
		<td class="value"><input type="text" name="initials" id="initials" value="{$initials|escape}" size="5" maxlength="5" class="textField" />&nbsp;&nbsp;{translate key="user.initialsExample"}</td>
	</tr>
	{if not $userId}
	<tr valign="top">
		<td class="label">{fieldLabel name="enrollAs" key="manager.people.enrollUserAs"}</td>
		<td class="value">
			<select name="enrollAs[]" id="enrollAs" multiple="multiple" size="11" class="selectMenu">
			{html_options_translate options=$roleOptions selected=$enrollAs}
			</select>
			<br />
			<span class="instruct">{translate key="manager.people.enrollUserAsDescription"}</span>
		</td>
	</tr>
	<tr valign="top">
		<td class="label">{fieldLabel name="username" required="true" key="user.username"}</td>
		<td class="value">
			<input type="text" name="username" id="username" value="{$username|escape}" size="20" maxlength="32" class="textField" />&nbsp;&nbsp;<input type="button" class="btn btn-small" value="{translate key="common.suggest"}" onclick="generateUsername()" />
			<br />
			<span class="instruct">{translate key="user.register.usernameRestriction"}</span>
		</td>
	</tr>
	{else}
	<tr valign="top">
		<td class="label">{fieldLabel suppressId="true" name="username" key="user.username"}</td>
		<td class="value"><strong>{$username|escape}</strong></td>
	</tr>
	{/if}
	{if $authSourceOptions}
	<tr valign="top">
		<td class="label">{fieldLabel name="authId" key="manager.people.authSource"}</td>
		<td class="value"><select name="authId" id="authId" size="1" class="selectMenu">
			<option value=""></option>
			{html_options options=$authSourceOptions selected=$authId}
		</select></td>
	</tr>
	{/if}

	{if !$implicitAuth}
		<tr valign="top">
			<td class="label">{fieldLabel name="password" required=$passwordRequired key="user.password"}</td>
			<td class="value">
				<input type="password" name="password" id="password" value="{$password|escape}" size="20" maxlength="32" class="textField" />
				<br />
				<span class="instruct">{translate key="user.register.passwordLengthRestriction" length=$minPasswordLength}</span>
			</td>
		</tr>
		<tr valign="top">
			<td class="label">{fieldLabel name="password2" required=$passwordRequired key="user.repeatPassword"}</td>
			<td class="value"><input type="password" name="password2"  id="password2" value="{$password2|escape}" size="20" maxlength="32" class="textField" /></td>
		</tr>
		{if $userId}
		<tr valign="top">
			<td>&nbsp;</td>
			<td class="value">{translate key="user.register.passwordLengthRestriction" length=$minPasswordLength}<br />{translate key="user.profile.leavePasswordBlank"}</td>
		</tr>
		{else}
		<tr valign="top">
			<td class="label">&nbsp;</td>
			<td class="value"><label class="checkbox" for="generatePassword">
			<input type="checkbox" onclick="setGenerateRandom(this.checked)" name="generatePassword" id="generatePassword" value="1"{if $generatePassword} checked="checked"{/if} />{translate key="manager.people.createUserGeneratePassword"}</label></td>
		</tr>
		<tr valign="top">
			<td class="label">&nbsp;</td>
			<td class="value"><label class="checkbox" for="sendNotify">
			<input type="checkbox" name="sendNotify" id="sendNotify" value="1"{if $sendNotify} checked="checked"{/if} />{translate key="manager.people.createUserSendNotify"}</label></td>
		</tr>
		{/if}
		<tr valign="top">
			<td class="label">&nbsp;</td>
			<td class="value"><label class="checkbox" for="mustChangePassword">
			<input type="checkbox" name="mustChangePassword" id="mustChangePassword" value="1"{if $mustChangePassword} checked="checked"{/if} />{translate key="manager.people.userMustChangePassword"}</label></td>
		</tr>
	{/if}{* !$implicitAuth *}

	<tr valign="top">
		<td class="label">{fieldLabel name="affiliation" key="user.affiliation"}</td>
		<td class="value">
			<textarea name="affiliation[{$formLocale|escape}]" id="affiliation" rows="5" cols="40" class="textArea">{$affiliation[$formLocale]|escape}</textarea><br/>
			<span class="instruct">{translate key="user.affiliation.description"}</span>
		</td>
	</tr>
	<tr valign="top">
		<td class="label">{fieldLabel name="signature" key="user.signature"}</td>
		<td class="value"><textarea name="signature[{$formLocale|escape}]" id="signature" rows="5" cols="40" class="textArea">{$signature[$formLocale]|escape}</textarea></td>
	</tr>
	<tr valign="top">
		<td class="label">{fieldLabel name="email" required="true" key="user.email"}</td>
		<td class="value"><input type="text" name="email" id="email" value="{$email|escape}" size="30" maxlength="90" class="textField" /></td>
	</tr>
	<tr valign="top">
		<td class="label">{fieldLabel name="userUrl" key="user.url"}</td>
		<td class="value"><input type="text" name="userUrl" id="userUrl" value="{$userUrl|escape}" size="30" maxlength="255" class="textField" /></td>
	</tr>
	<tr valign="top" style="display:none;">
		<td class="label">{fieldLabel name="phone" key="user.phone"}</td>
		<td class="value"><input type="text" name="phone" id="phone" value="{$phone|escape}" size="15" maxlength="24" class="textField" /></td>
	</tr>
	<tr valign="top" style="display:none;">
		<td class="label">{fieldLabel name="fax" key="user.fax"}</td>
		<td class="value"><input type="text" name="fax" id="fax" value="{$fax|escape}" size="15" maxlength="24" class="textField" /></td>
	</tr>
	<tr valign="top">
		<td class="label">{fieldLabel for="interests" key="user.interests"}</td>
		<td class="value">
			{include file="form/interestsInput.tpl" FBV_interestsKeywords=$interestsKeywords FBV_interestsTextOnly=$interestsTextOnly}
		</td>
	</tr>
	<tr valign="top">
		<td class="label">{fieldLabel name="gossip" key="user.gossip"}</td>
		<td class="value"><textarea name="gossip[{$formLocale|escape}]" id="gossip" rows="3" cols="40" class="textArea">{$gossip[$formLocale]|escape}</textarea></td>
	</tr>
	<tr valign="top">
		<td class="label">{fieldLabel name="mailingAddress" key="common.mailingAddress"}</td>
		<td class="value"><textarea name="mailingAddress" id="mailingAddress" rows="3" cols="40" class="textArea">{$mailingAddress|escape}</textarea></td>
	</tr>
	<tr valign="top">
		<td class="label">{fieldLabel name="country" key="common.country"}</td>
		<td class="value">
			<select name="country" id="country" class="selectMenu">
				<option value=""></option>
				{html_options options=$countries selected=$country}
			</select>
		</td>
	</tr>
	<tr valign="top">
		<td class="label">{fieldLabel name="biography" key="user.biography"}<br />{translate key="user.biography.description"}</td>
		<td class="value"><textarea name="biography[{$formLocale|escape}]" id="biography" rows="5" cols="40" class="textArea">{$biography[$formLocale]|escape}</textarea></td>
	</tr>
	{if count($availableLocales) > 1}
	<tr valign="top">
		<td class="label">{translate key="user.workingLanguages"}</td>
		<td class="value">{foreach from=$availableLocales key=localeKey item=localeName}
			<label class="checkbox inline" for="userLocales-{$localeKey|escape}"><input type="checkbox" name="userLocales[]" id="userLocales-{$localeKey|escape}" value="{$localeKey|escape}"{if $userLocales && in_array($localeKey, $userLocales)} checked="checked"{/if} />{$localeName|escape}</label><br />
		{/foreach}</td>
	</tr>
	{/if}
</table>
<hr/>
<p style="text-align:right;"><input type="button" value="{translate key="common.cancel"}" class="btn btn-danger btn-small" onclick="{if $source == ''}history.go(-1);{else}document.location='{$source|escape:"jsparam"}';{/if}" /> {if not $userId}<input type="submit" name="createAnother" value="{translate key="manager.people.saveAndCreateAnotherUser"}" class="btn btn-small" /> {/if} <input type="submit" value="{translate key="common.save"}" class="btn btn-small" /></p>

<p>{translate key="common.requiredField"}</p>

</form>

{if $generatePassword}
{literal}
	<script type="text/javascript">
		<!--
		setGenerateRandom(1);
		// -->
	</script>
{/literal}
{/if}

{include file="common/footer.tpl"}

{* MODIFICADO OJS V.2.4.2 / 04-2013*}