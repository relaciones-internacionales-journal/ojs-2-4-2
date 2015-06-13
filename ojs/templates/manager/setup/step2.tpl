{**
 * templates/manager/setup/step2.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Step 2 of journal setup.
 *
 *}
{assign var="pageTitle" value="manager.setup.journalPolicies"}
{include file="manager/setup/setupHeader.tpl"}

<form id="setupForm" method="post" action="{url op="saveSetup" path="2"}">
{include file="common/formErrors.tpl"}

{if count($formLocales) > 1}
<br/>
<div id="locales">
<table width="100%" class="data_alt">
	<tr valign="top">
		<td width="20%" class="label">{fieldLabel name="formLocale" key="form.formLanguage"}</td>
		<td width="80%" class="value">
			{url|assign:"setupFormUrl" op="setup" path="2" escape=false}
			{form_language_chooser form="setupForm" url=$setupFormUrl}
			<span class="instruct">{translate key="form.formLanguage.description"}</span>
		</td>
	</tr>
</table>
</div>
{/if}
<div id="manager_focusAndScopeDescription">
<h3>2.1 {translate key="manager.setup.focusAndScopeOfJournal"}</h3>
<p>{translate key="manager.setup.focusAndScopeDescription"}</p>
<p>
	<textarea name="focusScopeDesc[{$formLocale|escape}]" id="focusScopeDesc" rows="12" cols="60" class="textArea input-xxlarge">{$focusScopeDesc[$formLocale]|escape}</textarea>
</p>
</div>

<hr/>

<div id="manager_peerReviewPolicy">
<h3>2.2 {translate key="manager.setup.peerReviewPolicy"}</h3>
	<div id="peerReviewDescription">
		<p>{translate key="manager.setup.peerReviewDescription"}</p>

		<h4><strong>{translate key="manager.setup.reviewPolicy"}</strong></h4>

		<p><textarea name="reviewPolicy[{$formLocale|escape}]" id="reviewPolicy" rows="12" cols="60" class="textArea input-xxlarge">{$reviewPolicy[$formLocale]|escape}</textarea></p>
	</div>
	<div id="reviewGuidelinesInfo">

		<h4><strong>{translate key="manager.setup.reviewGuidelines"}</strong></h4>

		{url|assign:"reviewFormsUrl" op="reviewForms"}
		<p>{translate key="manager.setup.reviewGuidelinesDescription" reviewFormsUrl=$reviewFormsUrl}</p>

		<p><textarea name="reviewGuidelines[{$formLocale|escape}]" id="reviewGuidelines" rows="12" cols="60" class="textArea input-xxlarge">{$reviewGuidelines[$formLocale]|escape}</textarea></p>
	</div>
	<div id="reviewProcess">
		<h4><strong>{translate key="manager.setup.reviewProcess"}</strong></h4>

		<p>{translate key="manager.setup.reviewProcessDescription"}</p>

		<table width="100%" class="data_alt">
			<tr valign="top">
				<td width="5%" class="label" align="right">
					<label class="checkbox"><input type="radio" name="mailSubmissionsToReviewers" id="mailSubmissionsToReviewers-0" value="0"{if not $mailSubmissionsToReviewers} checked="checked"{/if} /></label>
				</td>
				<td width="95%" class="value">
					<label for="mailSubmissionsToReviewers-0"><strong>{translate key="manager.setup.reviewProcessStandard"}</strong></label>
					<br />
					<span class="instruct">{translate key="manager.setup.reviewProcessStandardDescription"}</span>
				</td>
			</tr>
			<tr>
				<td colspan="2" class="separator">&nbsp;</td>
			</tr>
			<tr valign="top">
				<td width="5%" class="label" align="right">
					<label class="checkbox"><input type="radio" name="mailSubmissionsToReviewers" id="mailSubmissionsToReviewers-1" value="1"{if $mailSubmissionsToReviewers} checked="checked"{/if} /></label>
				</td>
				<td width="95%" class="value">
					<label for="mailSubmissionsToReviewers-1"><strong>{translate key="manager.setup.reviewProcessEmail"}</strong></label>
					<br />
					<span class="instruct">{translate key="manager.setup.reviewProcessEmailDescription"}</span>
				</td>
			</tr>
		</table>
	</div>
	<div id="reviewOptions">
		<h4><strong>{translate key="manager.setup.reviewOptions"}</strong></h4>

			<script type="text/javascript">
				{literal}
				<!--
					function toggleAllowSetInviteReminder(form) {
						form.numDaysBeforeInviteReminder.disabled = !form.numDaysBeforeInviteReminder.disabled;
					}
					function toggleAllowSetSubmitReminder(form) {
						form.numDaysBeforeSubmitReminder.disabled = !form.numDaysBeforeSubmitReminder.disabled;
					}
				// -->
				{/literal}
			</script>

		<p>
			<strong>{translate key="manager.setup.reviewOptions.reviewTime"}</strong><br/>
			{translate key="manager.setup.reviewOptions.numWeeksPerReview"}: <br/><input type="text" name="numWeeksPerReview" id="numWeeksPerReview" value="{$numWeeksPerReview|escape}" size="2" maxlength="8" class="textField" /> {translate key="common.weeks"}<br/>
			{translate key="common.note"}: {translate key="manager.setup.reviewOptions.noteOnModification"}
		</p>

		<p>
			<strong>{translate key="manager.setup.reviewOptions.reviewerReminders"}</strong><br/>
			{translate key="manager.setup.reviewOptions.automatedReminders"}:<br/>
			<label class="checkbox" for="remindForInvite"><input type="checkbox" name="remindForInvite" id="remindForInvite" value="1" onclick="toggleAllowSetInviteReminder(this.form)"{if !$scheduledTasksEnabled} disabled="disabled" {elseif $remindForInvite} checked="checked"{/if} />
			{translate key="manager.setup.reviewOptions.remindForInvite1"}</label>
			<select name="numDaysBeforeInviteReminder" size="1" class="selectMenu"{if not $remindForInvite || !$scheduledTasksEnabled} disabled="disabled"{/if}>
				{section name="inviteDayOptions" start=3 loop=11}
				<option value="{$smarty.section.inviteDayOptions.index}"{if $numDaysBeforeInviteReminder eq $smarty.section.inviteDayOptions.index or ($smarty.section.inviteDayOptions.index eq 5 and not $remindForInvite)} selected="selected"{/if}>{$smarty.section.inviteDayOptions.index}</option>
				{/section}
			</select>
			{translate key="manager.setup.reviewOptions.remindForInvite2"}
			<br/>

			<label class="checkbox" for="remindForSubmit"><input type="checkbox" name="remindForSubmit" id="remindForSubmit" value="1" onclick="toggleAllowSetSubmitReminder(this.form)"{if !$scheduledTasksEnabled} disabled="disabled"{elseif $remindForSubmit} checked="checked"{/if} />&nbsp;
			{translate key="manager.setup.reviewOptions.remindForSubmit1"}</label>
			<select name="numDaysBeforeSubmitReminder" size="1" class="selectMenu"{if not $remindForSubmit || !$scheduledTasksEnabled} disabled="disabled"{/if}>
				{section name="submitDayOptions" start=0 loop=11}
					<option value="{$smarty.section.submitDayOptions.index}"{if $numDaysBeforeSubmitReminder eq $smarty.section.submitDayOptions.index} selected="selected"{/if}>{$smarty.section.submitDayOptions.index}</option>
			{/section}
			</select>
			{translate key="manager.setup.reviewOptions.remindForSubmit2"}
			{if !$scheduledTasksEnabled}
			<br/>
			{translate key="manager.setup.reviewOptions.automatedRemindersDisabled"}
			{/if}
		</p>

		<p>
			<strong>{translate key="manager.setup.reviewOptions.reviewerRatings"}</strong><br/>
			<label class="checkbox" for="rateReviewerOnQuality"><input type="checkbox" name="rateReviewerOnQuality" id="rateReviewerOnQuality" value="1"{if $rateReviewerOnQuality} checked="checked"{/if} />&nbsp;
			{translate key="manager.setup.reviewOptions.onQuality"}</label>
		</p>

		<p>
			<strong>{translate key="manager.setup.reviewOptions.reviewerAccess"}</strong><br/>
			<label class="checkbox" for="reviewerAccessKeysEnabled"><input type="checkbox" name="reviewerAccessKeysEnabled" id="reviewerAccessKeysEnabled" value="1"{if $reviewerAccessKeysEnabled} checked="checked"{/if} />&nbsp;
			{translate key="manager.setup.reviewOptions.reviewerAccessKeysEnabled"}</label><br/>
			<span class="instruct">{translate key="manager.setup.reviewOptions.reviewerAccessKeysEnabled.description"}</span><br/>
			<label class="checkbox"><input type="checkbox" name="restrictReviewerFileAccess" id="restrictReviewerFileAccess" value="1"{if $restrictReviewerFileAccess} checked="checked"{/if} />&nbsp;
			{translate key="manager.setup.reviewOptions.restrictReviewerFileAccess"}</label>
		</p>

		<p>
			<strong>{translate key="manager.setup.reviewOptions.blindReview"}</strong><br/>
			<label class="checkbox" for="showEnsuringLink"><input type="checkbox" name="showEnsuringLink" id="showEnsuringLink" value="1"{if $showEnsuringLink} checked="checked"{/if} />&nbsp;
			{get_help_id|assign:"blindReviewHelpId" key="editorial.sectionEditorsRole.review.blindPeerReview" url="true"}
			{translate key="manager.setup.reviewOptions.showEnsuringLink" blindReviewHelpId=$blindReviewHelpId}</label><br/>
		</p>
	</div>
</div>

<hr/>
<div id="manager_privacyStatementInfo">
<h3>2.3 {translate key="manager.setup.privacyStatement"}</h3>
<p style="float:left;"><textarea name="privacyStatement[{$formLocale|escape}]" id="privacyStatement" rows="12" cols="60" class="textArea input-xxlarge">{$privacyStatement[$formLocale]|escape}</textarea></p>
</div>

<hr/>
<div id="manager_editorDecision">
<h3>2.4 {translate key="manager.setup.editorDecision"}</h3>

<p style="float:left;"><label class="checkbox" for="notifyAllAuthorsOnDecision"><input type="checkbox" name="notifyAllAuthorsOnDecision" id="notifyAllAuthorsOnDecision" value="1"{if $notifyAllAuthorsOnDecision} checked="checked"{/if} /> 
{translate key="manager.setup.notifyAllAuthorsOnDecision"}</label></p>
</div>

<div class="separator"></div>

<div id="manager_addItemtoAboutJournal">
<h3>2.5 {translate key="manager.setup.addItemtoAboutJournal"}</h3>

<table width="100%" class="data_alt">
{foreach name=customAboutItems from=$customAboutItems[$formLocale] key=aboutId item=aboutItem}
	<tr valign="top">
		<td width="5%" class="label">{fieldLabel name="customAboutItems-$aboutId-title" key="common.title"}</td>
		<td width="95%" class="value"><input type="text" name="customAboutItems[{$formLocale|escape}][{$aboutId|escape}][title]" id="customAboutItems-{$aboutId|escape}-title" value="{$aboutItem.title|escape}" size="40" maxlength="255" class="textField input-xxlarge" />{if $smarty.foreach.customAboutItems.total > 1} <br/><input type="submit" name="delCustomAboutItem[{$aboutId|escape}]" value="{translate key="common.delete"}" class="btn btn-small" /><br />{/if}<br /></td>
	</tr>
	<tr valign="top">
		<td width="20%" class="label">{fieldLabel name="customAboutItems-$aboutId-content" key="manager.setup.aboutItemContent"}</td>
		<td width="80%" class="value"><textarea name="customAboutItems[{$formLocale|escape}][{$aboutId|escape}][content]" id="customAboutItems-{$aboutId|escape}-content" rows="12" cols="40" class="textArea input-xxlarge">{$aboutItem.content|escape}</textarea></td>
	</tr>
	{if !$smarty.foreach.customAboutItems.last}
	<tr valign="top">
		<td colspan="2" class="separator">&nbsp;</td>
	</tr>
	{/if}
{foreachelse}
	<tr valign="top">
		<td width="20%" class="label">{fieldLabel name="customAboutItems-0-title" key="common.title"}</td>
		<td width="80%" class="value"><input type="text" name="customAboutItems[{$formLocale|escape}][0][title]" id="customAboutItems-0-title" value="" size="40" maxlength="255" class="textField input-xxlarge" /></td>
	</tr>
	<tr valign="top">
		<td width="20%" class="label">{fieldLabel name="customAboutItems-0-content" key="manager.setup.aboutItemContent"}</td>
		<td width="80%" class="value"><textarea name="customAboutItems[{$formLocale|escape}][0][content]" id="customAboutItems-0-content" rows="12" cols="40" class="textArea input-xxlarge"></textarea></td>
	</tr>
{/foreach}
</table>
<br />
<p><input type="submit" name="addCustomAboutItem" value="{translate key="manager.setup.addAboutItem"}" class="btn btn-small" /></p>
</div>
<div class="separator"></div>

<div id="manager_journalArchiving">
<h3>2.6 {translate key="manager.setup.journalArchiving"}</h3>

<p>{translate key="manager.setup.lockssDescription"}</p>

{url|assign:"lockssExistingArchiveUrl" page="manager" op="email" template="LOCKSS_EXISTING_ARCHIVE"}
{url|assign:"lockssNewArchiveUrl" page="manager" op="email" template="LOCKSS_NEW_ARCHIVE"}
<p>{translate key="manager.setup.lockssRegister" lockssExistingArchiveUrl=$lockssExistingArchiveUrl lockssNewArchiveUrl=$lockssNewArchiveUrl}</p>

{url|assign:"lockssUrl" page="gateway" op="lockss"}
<p><label class="checkbox" for="enableLockss"><input type="checkbox" name="enableLockss" id="enableLockss" value="1"{if $enableLockss} checked="checked"{/if} />
{translate key="manager.setup.lockssEnable" lockssUrl=$lockssUrl}</label></p>

<p>
	<textarea name="lockssLicense[{$formLocale|escape}]" id="lockssLicense" rows="6" cols="60" class="textArea input-xxlarge">{$lockssLicense[$formLocale]|escape}</textarea>
	<br />
	<span class="instruct">{translate key="manager.setup.lockssLicenses"}</span>
</p>
</div>

<div class="separator"></div>

<div id="manager_reviewerDatabaseLink">
<h3>2.7 {translate key="manager.setup.reviewerDatabaseLink"}</h3>

<p>{translate key="manager.setup.reviewerDatabaseLink.desc"}</p>

<table width="100%" class="data_alt">
{foreach name=reviewerDatabaseLinks from=$reviewerDatabaseLinks key=reviewerDatabaseLinkId item=reviewerDatabaseLink}
	<tr valign="top">
		<td width="5%" class="label">{fieldLabel name="reviewerDatabaseLinks-$reviewerDatabaseLinkId-title" key="common.title"}</td>
		<td width="95%" class="value"><input type="text" name="reviewerDatabaseLinks[{$reviewerDatabaseLinkId|escape}][title]" id="reviewerDatabaseLinks-{$reviewerDatabaseLinkId|escape}-title" value="{$reviewerDatabaseLink.title|escape}" size="40" maxlength="255" class="textField input-xxlarge" />{if $smarty.foreach.reviewerDatabaseLinks.total > 1} <input type="submit" name="delReviewerDatabaseLink[{$reviewerDatabaseLinkId|escape}]" value="{translate key="common.delete"}" class="button" />{/if}</td>
	</tr>
	<tr valign="top">
		<td width="20%" class="label">{fieldLabel name="reviewerDatabaseLinks-$reviewerDatabaseLinkId-url" key="common.url"}</td>
		<td width="80%" class="value"><input type="text" name="reviewerDatabaseLinks[{$reviewerDatabaseLinkId|escape}][url]" id="reviewerDatabaseLinks-{$reviewerDatabaseLinkId|escape}-url" value="{$reviewerDatabaseLink.url|escape}" size="40" maxlength="255" class="textField input-xxlarge" /></td>
	</tr>
	{if !$smarty.foreach.reviewerDatabaseLinks.last}
	<tr valign="top">
		<td colspan="2" class="separator">&nbsp;</td>
	</tr>
	{/if}
{foreachelse}
	<tr valign="top">
		<td width="20%" class="label">{fieldLabel name="reviewerDatabaseLinks-0-title" key="common.title"}</td>
		<td width="80%" class="value"><input type="text" name="reviewerDatabaseLinks[0][title]" id="reviewerDatabaseLinks-0-title" value="" size="40" maxlength="255" class="textField input-xxlarge" /></td>
	</tr>
	<tr valign="top">
		<td width="20%" class="label">{fieldLabel name="reviewerDatabaseLinks-0-url" key="common.url"}</td>
		<td width="80%" class="value"><input type="text" name="reviewerDatabaseLinks[0][url]" id="reviewerDatabaseLinks-0-url" value="" size="40" maxlength="255" class="textField input-xxlarge" /></td>
	</tr>
{/foreach}
</table>

<p><input type="submit" name="addReviewerDatabaseLink" value="{translate key="manager.setup.addReviewerDatabaseLink"}" class="btn btn-small" /></p>
</div>
<div class="separator"><hr/></div>

<p style="text-align:right;"><input type="button" value="{translate key="common.cancel"}" class="btn btn-danger btn-small" onclick="document.location.href='{url op="setup" escape=false}'" /> <input type="submit" value="{translate key="common.saveAndContinue"}" class="btn btn-small" /></p>

<p>{translate key="common.requiredField"}</p>

</form>

{include file="common/footer.tpl"}
{* MODIFICADO OJS V.2.4.2 / 04-2013*}
