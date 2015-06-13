{**
 * templates/author/submit/step1.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Step 1 of author article submission.
 *
 *}
{assign var="pageTitle" value="author.submit.step1"}
{include file="author/submit/submitHeader.tpl"}

{if $journalSettings.supportPhone}
	{assign var="howToKeyName" value="author.submit.howToSubmit"}
{else}
	{assign var="howToKeyName" value="author.submit.howToSubmitNoPhone"}
{/if}

<p>{translate key=$howToKeyName supportName=$journalSettings.supportName supportEmail=$journalSettings.supportEmail supportPhone=$journalSettings.supportPhone}</p>

<form id="submit" method="post" action="{url op="saveSubmit" path=$submitStep}" onsubmit="return checkSubmissionChecklist()">
{include file="common/formErrors.tpl"}
{if $articleId}<input type="hidden" name="articleId" value="{$articleId|escape}" />{/if}

{if count($sectionOptions) <= 1}
	<p>{translate key="author.submit.notAccepting"}</p>
{else}

{if count($sectionOptions) == 2}
	{* If there's only one section, force it and skip the section parts
	   of the interface. *}
	{foreach from=$sectionOptions item=val key=key}
		<input type="hidden" name="sectionId" value="{$key|escape}" />
	{/foreach}
{else}{* if count($sectionOptions) == 2 *}

<div id="author_submit_section">
<h3>{translate key="author.submit.journalSection"}</h3>

{url|assign:"url" page="about"}
<p>{translate key="author.submit.journalSectionDescription" aboutUrl=$url}</p>

<input type="hidden" name="submissionChecklist" value="1" />

<table class="data" width="100%">
	<tr valign="top">
		<td width="20%" class="label">{fieldLabel name="sectionId" required="true" key="section.section"}</td>
		<td width="80%" class="value"><select name="sectionId" id="sectionId" size="1" class="selectMenu">{html_options options=$sectionOptions selected=$sectionId}</select></td>
	</tr>
</table>

</div>{* section *}

{/if}{* if count($sectionOptions) == 2 *}

{if count($supportedSubmissionLocaleNames) == 1}
	{* There is only one supported submission locale; choose it invisibly *}
	{foreach from=$supportedSubmissionLocaleNames item=localeName key=locale}
		<input type="hidden" name="locale" value="{$locale|escape}" />
	{/foreach}
{else}
	{* There are several submission locales available; allow choice *}
	<div id="submissionLocale">

	<h3>{translate key="author.submit.submissionLocale"}</h3>
	<p>{translate key="author.submit.submissionLocaleDescription"}</p>

	<table class="data" width="100%">
		<tr valign="top">
			<td width="20%" class="label">{fieldLabel name="locale" required="true" key="article.language"}</td>
			<td width="80%" class="value"><select name="locale" id="locale" size="1" class="selectMenu">{html_options options=$supportedSubmissionLocaleNames selected=$locale}</select></td>
		</tr>
	</table>

	</div>{* submissionLocale *}
{/if}{* count($supportedSubmissionLocaleNames) == 1 *}

<script type="text/javascript">
{literal}
<!--
function checkSubmissionChecklist() {
	var elements = document.getElementById('submit').elements;
	for (var i=0; i < elements.length; i++) {
		if (elements[i].type == 'checkbox' && !elements[i].checked) {
			if (elements[i].name.match('^checklist')) {
				alert({/literal}'{translate|escape:"jsparam" key="author.submit.verifyChecklist"}'{literal});
				return false;
			} else if (elements[i].name == 'copyrightNoticeAgree') {
				alert({/literal}'{translate|escape:"jsparam" key="author.submit.copyrightNoticeAgreeRequired"}'{literal});
				return false;
			}
		}
	}
	return true;
}
// -->
{/literal}
</script>

{if $authorFees}
	{include file="author/submit/authorFees.tpl" showPayLinks=0}
	<div class="separator"></div>
{/if}

{if $currentJournal->getLocalizedSetting('submissionChecklist')}
{foreach name=checklist from=$currentJournal->getLocalizedSetting('submissionChecklist') key=checklistId item=checklistItem}
	{if $checklistItem.content}
		{if !$notFirstChecklistItem}
			{assign var=notFirstChecklistItem value=1}
			<div id="author_checklist">
			<h3>{translate key="author.submit.submissionChecklist"}</h3>
			<p>{translate key="author.submit.submissionChecklistDescription"}</p>			
		{/if}
		<label class="checkbox" for="checklist-{$smarty.foreach.checklist.iteration}"><input type="checkbox" id="checklist-{$smarty.foreach.checklist.iteration}" name="checklist[]" value="{$checklistId|escape}"{if $articleId || $submissionChecklist} checked="checked"{/if} />
			{$checklistItem.content|nl2br}</label><br/>
	{/if}
{/foreach}
{if $notFirstChecklistItem}
	</div>{* checklist *}
{/if}

{/if}{* if count($sectionOptions) <= 1 *}

{if $currentJournal->getLocalizedSetting('copyrightNotice') != ''}
<div id="author_copyrightNotice">
<h3>{translate key="about.copyrightNotice"}</h3>

<p>{$currentJournal->getLocalizedSetting('copyrightNotice')|nl2br}</p>

{if $journalSettings.copyrightNoticeAgree}
<label class="checkbox"for="copyrightNoticeAgree"><input type="checkbox" name="copyrightNoticeAgree" id="copyrightNoticeAgree" value="1"{if $articleId || $copyrightNoticeAgree} checked="checked"{/if} />
		{translate key="author.submit.copyrightNoticeAgree"}</label>
{/if}{* $journalSettings.copyrightNoticeAgree *}
</div>{* copyrightNotice *}

<div class="separator"></div>

{/if}{* $currentJournal->getLocalizedSetting('copyrightNotice') != '' *}

<div id="author_privacyStatement">
<h3>{translate key="author.submit.privacyStatement"}</h3>
<br />
{$currentJournal->getLocalizedSetting('privacyStatement')|nl2br}
</div>

<div class="separator"></div>

<div id="author_commentsForEditor">
<h3>{translate key="author.submit.commentsForEditor"}</h3>

{fieldLabel name="commentsToEditor" key="author.submit.comments"}<br/>
<textarea name="commentsToEditor" id="commentsToEditor" rows="3" cols="40" class="textArea">{$commentsToEditor|escape}</textarea>
</div>{* commentsForEditor *}

<div class="separator"><hr/></div>

<p style="float:right;text-align:right;"><input type="button" value="{translate key="common.cancel"}" class="btn btn-danger btn-small" onclick="{if $articleId}confirmAction('{url page="author"}', '{translate|escape:"jsparam" key="author.submit.cancelSubmission"}'){else}document.location.href='{url page="author" escape=false}'{/if}" /> <input type="submit" value="{translate key="common.saveAndContinue"}" class="btn btn-small" /> </p>

<p style="float:left;clear:both">{translate key="common.requiredField"}</p>

</form>

{/if}{* If not accepting submissions *}

{include file="common/footer.tpl"}

{* MODIFICADO OJS V.2.4.2 / 04-2013*}