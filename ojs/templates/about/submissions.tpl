{**
 * templates/about/submissions.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * About the Journal / Submissions.
 *
 *}
{strip}
{assign var="pageTitle" value="about.submissions"}
{include file="common/header.tpl"}
{/strip}

{if $currentJournal->getSetting('journalPaymentsEnabled') && 
		($currentJournal->getSetting('submissionFeeEnabled') || $currentJournal->getSetting('fastTrackFeeEnabled') || $currentJournal->getSetting('publicationFeeEnabled')) }
	{assign var="authorFees" value=1}
{/if}

<ul class="plain">
	<li><a href="{$baseUrl}/about/submissions.html#sectionPolicies">{translate key="about.sectionPolicies"}</a></li>
	{if $currentJournal->getLocalizedSetting('reviewPolicy') != ''}<li><a href="{$baseUrl}/about/submissions.html#peerReviewProcess">{translate key="about.authorGuidelines"} {translate key="frontpage.CoordinatorsAnd"} {translate key="about.peerReviewProcess"}</a></li>{/if}
	<li><a href="{$baseUrl}/about/submissions.html#onlineSubmissions">{translate key="about.onlineSubmissions"}</a></li>
	{*{if $currentJournal->getLocalizedSetting('authorGuidelines') != ''}<li><a href="{$baseUrl}/about/submissions.html#authorGuidelines">{translate key="about.authorGuidelines"}</a></li>{/if}*}
	{if $currentJournal->getLocalizedSetting('copyrightNotice') != ''}<li><a href="{$baseUrl}/about/submissions.html#copyrightNotice">{translate key="about.copyrightNotice"}</a></li>{/if}
	{if $currentJournal->getLocalizedSetting('privacyStatement') != ''}<li><a href="{$baseUrl}/about/submissions.html#privacyStatement">{translate key="about.privacyStatement"}</a></li>{/if}
	{if $authorFees}<li><a href="{url page="about" op="submissions" anchor="authorFees"}">{translate key="about.authorFees"}</a></li>{/if}	
</ul>

<div id="sectionPolicies"><div class="arrow_down_box"><h3>{translate key="about.sectionPolicies"}</h3></div>
{foreach from=$sections item=section}{if !$section->getHideAbout()}
	<h4>{$section->getLocalizedTitle()}</h4>
	{if strlen($section->getLocalizedPolicy()) > 0}
		<p>{$section->getLocalizedPolicy()|nl2br}</p>
	{/if}

	{assign var="hasEditors" value=0}
	{foreach from=$sectionEditorEntriesBySection item=sectionEditorEntries key=key}
		{if $key == $section->getId()}
			{foreach from=$sectionEditorEntries item=sectionEditorEntry}
				{assign var=sectionEditor value=$sectionEditorEntry.user}
				{if 0 == $hasEditors++}
				{translate key="user.role.editors"}
				<ul class="plain">
				{/if}
				<li>{$sectionEditor->getFirstName()|escape} {$sectionEditor->getLastName()|escape}{if $sectionEditor->getLocalizedAffiliation()}, {$sectionEditor->getLocalizedAffiliation()|escape}{/if}</li>
			{/foreach}
		{/if}
	{/foreach}
	{if $hasEditors}</ul>{/if}

	<table class="plain" width="60%">
		<tr>
			<td>{if !$section->getEditorRestricted()}<p class="icon_checked">{translate key="manager.sections.open"}</p>{else}<p class="icon_unchecked">{translate key="manager.sections.open"}</p>{/if} </td>
			<td>{if $section->getMetaIndexed()}<p class="icon_checked">{translate key="manager.sections.indexed"}</p>{else}<p class="icon_unchecked">{translate key="manager.sections.indexed"}{/if}</td>
			<td>{if $section->getMetaReviewed()}<p class="icon_checked">{translate key="manager.sections.reviewed"}</p>{else}<p class="icon_unchecked">{translate key="manager.sections.reviewed"}{/if}</td>
		</tr>
	</table>
{/if}{/foreach}
</div>

<div class="separator">&nbsp;</div>

{if $currentJournal->getLocalizedSetting('reviewPolicy') != ''}<div id="peerReviewProcess"><div class="arrow_down_box"><h3>{translate key="about.authorGuidelines"} {translate key="frontpage.CoordinatorsAnd"} {translate key="about.peerReviewProcess"}</h3></div>
<p>{$currentJournal->getLocalizedSetting('reviewPolicy')|nl2br}</p>

<div class="separator">&nbsp;</div>
</div>
{/if}

<div id="onlineSubmissions"><div class="arrow_down_box"><h3>{translate key="about.onlineSubmissions"}</h3></div>
<p>{translate key="about.OnlineSubmissionsInfo"}</p>
<p>{translate key="about.onlineSubmissions.registrationRequired"}</p>
<p>{translate key="about.onlineSubmissions.haveAccount" journalTitle=$siteTitle|escape}	<a href="{$baseUrl}/login.html">{translate key="about.onlineSubmissions.login"}</a>
</p>
<p>{translate key="about.onlineSubmissions.needAccount"} <a href="{$baseUrl}/user/register.html">{translate key="about.onlineSubmissions.registration"}</a>
</p>

<div class="separator">&nbsp;</div>
</div>

{*{if $currentJournal->getLocalizedSetting('authorGuidelines') != ''}
<div id="authorGuidelines"><div class="arrow_down_box"><h3>{translate key="about.authorGuidelines"}</h3></div>
<p>{$currentJournal->getLocalizedSetting('authorGuidelines')|nl2br}</p>

<div class="separator">&nbsp;</div>
</div>
{/if}*}

{if $submissionChecklist}
	<div id="submissionPreparationChecklist"><div class="arrow_down_box"><h3>{translate key="about.submissionPreparationChecklist"}</h3></div>
	<p>{translate key="about.submissionPreparationChecklist.description"}</p>
	<ol>
		{foreach from=$submissionChecklist item=checklistItem}
			<li>{$checklistItem.content|nl2br}</li>	
		{/foreach}
	</ol>
	<div class="separator">&nbsp;</div>
	</div>
{/if}{* $submissionChecklist *}

{if $currentJournal->getLocalizedSetting('copyrightNotice') != ''}
<div id="copyrightNotice"><div class="arrow_down_box"><h3>{translate key="about.copyrightNotice"}</h3></div>
<p>{$currentJournal->getLocalizedSetting('copyrightNotice')|nl2br}</p>

<div class="separator">&nbsp;</div>
</div>
{/if}

{if $currentJournal->getLocalizedSetting('privacyStatement') != ''}<div id="privacyStatement"><div class="arrow_down_box"><h3>{translate key="about.privacyStatement"}</h3></div>
<p>{$currentJournal->getLocalizedSetting('privacyStatement')|nl2br}</p>

<div class="separator">&nbsp;</div>
</div>
{/if}

{if $authorFees}

<div id="authorFees"><h3>{translate key="manager.payment.authorFees"}</h3>
	<p>{translate key="about.authorFeesMessage"}</p>
	{if $currentJournal->getSetting('submissionFeeEnabled')}
		<p>{$currentJournal->getLocalizedSetting('submissionFeeName')|escape}: {$currentJournal->getSetting('submissionFee')|string_format:"%.2f"} ({$currentJournal->getSetting('currency')})<br />
		{$currentJournal->getLocalizedSetting('submissionFeeDescription')|nl2br}<p>
	{/if}
	{if $currentJournal->getSetting('fastTrackFeeEnabled')}
		<p>{$currentJournal->getLocalizedSetting('fastTrackFeeName')|escape}: {$currentJournal->getSetting('fastTrackFee')|string_format:"%.2f"} ({$currentJournal->getSetting('currency')})<br />
		{$currentJournal->getLocalizedSetting('fastTrackFeeDescription')|nl2br}<p>	
	{/if}
	{if $currentJournal->getSetting('publicationFeeEnabled')}
		<p>{$currentJournal->getLocalizedSetting('publicationFeeName')|escape}: {$currentJournal->getSetting('publicationFee')|string_format:"%.2f"} ({$currentJournal->getSetting('currency')})<br />
		{$currentJournal->getLocalizedSetting('publicationFeeDescription')|nl2br}<p>	
	{/if}
	{if $currentJournal->getLocalizedSetting('waiverPolicy') != ''}
		<p>{$currentJournal->getLocalizedSetting('waiverPolicy')|nl2br}</p>
	{/if}
</div>
{/if}
{include file="common/footer.tpl"}
{* MODIFICADO OJS V.2.4.2 / 04-2013*}
