{**
 * templates/sectionEditor/createReviewerForm.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Form for editors to create reviewers.
 *
 *}
{strip}
{assign var="pageTitle" value="sectionEditor.review.createReviewer"}
{include file="common/header.tpl"}
{/strip}

<div class="register_form">
<form method="post" id="reviewerForm" action="{url op="createReviewer" path=$articleId|to_array:"create"}" class="form-horizontal">

{include file="common/formErrors.tpl"}

<script type="text/javascript">
{literal}
// <!--

	function generateUsername() {
		var req = makeAsyncRequest();

		if (document.getElementById('reviewerForm').lastName.value == "") {
			alert("{/literal}{translate key="manager.people.mustProvideName"}{literal}");
			return;
		}

		req.onreadystatechange = function() {
			if (req.readyState == 4) {
				document.getElementById('reviewerForm').username.value = req.responseText;
			}
		}
		sendAsyncRequest(req, '{/literal}{url op="suggestUsername" firstName="REPLACE1" lastName="REPLACE2" escape=false}{literal}'.replace('REPLACE1', escape(document.getElementById('reviewerForm').firstName.value)).replace('REPLACE2', escape(document.getElementById('reviewerForm').lastName.value)), null, 'get');
	}


// -->
{/literal}
</script>

{if count($formLocales) > 1}
	<div class="control-group">
		<label class="control-label">{fieldLabel name="formLocale" key="form.formLanguage"}</label>
		<div class="controls">
			{url|assign:"createReviewerUrl" op="createReviewer" path=$articleId escape=false}
			{form_language_chooser form="reviewerForm" url=$createReviewerUrl}
			<span class="instruct">{translate key="form.formLanguage.description"}</span>
		</div>
	</div>
{/if}
	<div class="control-group" style="display:none;">
		<label class="control-label">{fieldLabel name="salutation" key="user.salutation"}</label>
		<div class="controls"><input type="text" name="salutation" id="salutation" value="{$salutation|escape}" size="20" maxlength="40" class="textField input-xlarge" />
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">{fieldLabel name="firstName" required="true" key="user.firstName"}</label>
		<div class="controls"><input type="text" name="firstName" id="firstName" value="{$firstName|escape}" size="20" maxlength="40" class="textField input-xlarge" />
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">{fieldLabel name="middleName" key="user.middleName"}</label>
		<div class="controls"><input type="text" name="middleName" id="middleName" value="{$middleName|escape}" size="20" maxlength="40" class="textField input-xlarge" />
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">{fieldLabel name="lastName" required="true" key="user.lastName"}</label>
		<div class="controls"><input type="text" name="lastName" id="lastName" value="{$lastName|escape}" size="20" maxlength="90" class="textField input-xlarge" />
		</div>
	</div>
	<div class="control-group" style="display:none;">
		<label class="control-label">{fieldLabel name="initials" key="user.initials"}</label>
		<div class="controls"><input type="text" name="initials" id="initials" value="{$initials|escape}" size="5" maxlength="5" class="textField" />&nbsp;&nbsp;{translate key="user.initialsExample"}</td>
		</div>
	</div>
	<div class="control-group" style="display:none;">
		<label class="control-label">{fieldLabel name="gender" key="user.gender"}</label>
		<div class="controls">
			<select name="gender" id="gender" size="1" class="selectMenu">
				{html_options_translate options=$genderOptions selected=$gender}
			</select>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">{fieldLabel name="username" required="true" key="user.username"}</label>
		<div class="controls">
			<input type="text" name="username" id="username" value="{$username|escape}" size="20" maxlength="32" class="textField  input-xlarge" />&nbsp;&nbsp;<input type="button" class="btn btn-small" value="{translate key="common.suggest"}" onclick="generateUsername()" />
			<br />
			<span class="instruct">{translate key="user.register.usernameRestriction"}</span>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">{translate key="manager.people.createUserSendNotify"}</label>
		<div class="controls">
		<label class="checkbox">
		<input type="checkbox" name="sendNotify" id="sendNotify" value="1"{if $sendNotify} checked="checked"{/if} /></label>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">{fieldLabel name="affiliation" key="user.affiliation"}</label>
		<div class="controls">
			<textarea name="affiliation[{$formLocale|escape}]" id="affiliation" rows="5" cols="40" class="textArea input-xlarge">{$affiliation[$formLocale]|escape}</textarea><br/>
			<span class="instruct">{translate key="user.affiliation.description"}</span>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">{fieldLabel name="email" required="true" key="user.email"}</label>
		<div class="controls"><input type="text" name="email" id="email" value="{$email|escape}" size="30" maxlength="90" class="textField input-xlarge" />
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">{fieldLabel name="userUrl" key="user.url"}</label>
		<div class="controls"><input type="text" name="userUrl" id="userUrl" value="{$userUrl|escape}" size="30" maxlength="255" class="textField input-xlarge" />
		</div>
	</div>
	<div class="control-group" style="display:none;">
		<label class="control-label">{fieldLabel name="phone" key="user.phone"}</label>
		<div class="controls"><input type="text" name="phone" id="phone" value="{$phone|escape}" size="15" maxlength="24" class="textField" />
		</div>
	</div>
	<div class="control-group" style="display:none;">
		<label class="control-label">{fieldLabel name="fax" key="user.fax"}</label>
		<div class="controls"><input type="text" name="fax" id="fax" value="{$fax|escape}" size="15" maxlength="24" class="textField" />
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">{fieldLabel for="interests" key="user.interests"}</label>
		<div class="controls">
			{include file="form/interestsInput.tpl" FBV_interestsKeywords=$interestsKeywords FBV_interestsTextOnly=$interestsTextOnly}
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">{fieldLabel name="gossip" key="user.gossip"}</label>
		<div class="controls"><textarea name="gossip[{$formLocale|escape}]" id="gossip" rows="3" cols="40" class="textArea input-xlarge">{$gossip[$formLocale]|escape}</textarea>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">{fieldLabel name="mailingAddress" key="common.mailingAddress"}</label>
		<div class="controls"><textarea name="mailingAddress" id="mailingAddress" rows="3" cols="40" class="textArea input-xlarge">{$mailingAddress|escape}</textarea>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">{fieldLabel name="country" key="common.country"}</label>
		<div class="controls">
			<select name="country" id="country" class="selectMenu input-xlarge">
				<option value=""></option>
				{html_options options=$countries selected=$country}
			</select>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">{fieldLabel name="biography" key="user.biography"}<br />{translate key="user.biography.description"}</label>
		<div class="controls"><textarea name="biography[{$formLocale|escape}]" id="biography" rows="5" cols="40" class="textArea input-xlarge">{$biography[$formLocale]|escape}</textarea>
		</div>
	</div>
	{if count($availableLocales) > 1}
	<div class="control-group">
		<label class="control-label">{translate key="user.workingLanguages"}</label>
		<div class="controls">{foreach from=$availableLocales key=localeKey item=localeName}
			<label class="checkbox" for="userLocales-{$localeKey|escape}"><input type="checkbox" name="userLocales[]" id="userLocales-{$localeKey|escape}" value="{$localeKey|escape}"{if $userLocales && in_array($localeKey, $userLocales)} checked="checked"{/if} /> {$localeName|escape}</label><br />
		{/foreach}
		</div>
	</div>
	{/if}
<div class="separator"><hr/></div>
<p style="text-align:right;"><input type="button" value="{translate key="common.cancel"}" class="btn btn-danger btn-small" onclick="document.location.href='{url op="selectReviewer" path=$articleId escape=false}'" /> <input type="submit" value="{translate key="common.save"}" class="btn btn-small" /></p>

<p><span class="formRequired">{translate key="common.requiredField"}</span></p>

</form>
</div>
{include file="common/footer.tpl"}
{* MODIFICADO OJS V.2.4.2 / 04-2013*}
