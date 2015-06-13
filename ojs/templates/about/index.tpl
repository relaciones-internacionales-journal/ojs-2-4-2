{**
 * templates/about/index.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * About the Journal index.
 *
 *}
{strip}
{assign var="pageTitle" value="about.aboutTheJournal"}
{include file="common/header.tpl"}
{/strip}
<div id="column_one">
<div id="aboutPeople">
<div class="about_block_title"><h3>{translate key="about.people"}</h3></div>
<ul class="plain">
	<li><a href="{$baseUrl}/about/editorialTeam.html">{translate key="about.editorialTeam"}</a></li>
	{iterate from=peopleGroups item=peopleGroup}
		<li><a href="{$baseUrl}/about/displayMembership/{$peopleGroup->getId()}.html">{$peopleGroup->getLocalizedTitle()|escape}</a></li>
	{/iterate}
	{call_hook name="Templates::About::Index::People"}
</ul>
</div>
<div id="aboutPolicies">
<div class="about_block_title"><h3>{translate key="about.info"}</h3></div>
<ul class="plain">
	{if not (empty($journalSettings.mailingAddress) && empty($journalSettings.contactName) && empty($journalSettings.contactAffiliation) && empty($journalSettings.contactMailingAddress) && empty($journalSettings.contactPhone) && empty($journalSettings.contactFax) && empty($journalSettings.contactEmail) && empty($journalSettings.supportName) && empty($journalSettings.supportPhone) && empty($journalSettings.supportEmail))}
		<li><a href="{$baseUrl}/about/contact.html">{translate key="about.contact"}</a></li>
	{/if}
	{if $currentJournal->getLocalizedSetting('focusScopeDesc') != ''}<li><a href="{$baseUrl}/about/editorialPolicies.html#focusAndScope">{translate key="about.focusAndScope"}</a></li>{/if}	
	{if $currentJournal->getLocalizedSetting('pubFreqPolicy') != ''}<li><a href="{$baseUrl}/about/editorialPolicies.html#publicationFrequency"}">{translate key="about.publicationFrequency"}</a></li>{/if}
	{if $currentJournal->getSetting('publishingMode') == $smarty.const.PUBLISHING_MODE_OPEN && $currentJournal->getLocalizedSetting('openAccessPolicy') != ''}<li><a href="{$baseUrl}/about/editorialPolicies.html#openAccessPolicy"}">{translate key="about.openAccessPolicy"}</a></li>{/if}
	{if $journalSettings.enableLockss && $currentJournal->getLocalizedSetting('lockssLicense') != ''}<li><a href="{$baseUrl}/about/editorialPolicies.html#archiving">{translate key="about.archiving"}</a></li>{/if}
	{if $paymentConfigured && $journalSettings.journalPaymentsEnabled && $journalSettings.membershipFeeEnabled && $journalSettings.membershipFee > 0}<li><a href="{url op="memberships"}">{translate key="about.memberships"}</a></li>{/if}
	{if $currentJournal->getSetting('publishingMode') == $smarty.const.PUBLISHING_MODE_SUBSCRIPTION}
		<li><a href="{url op="subscriptions"}">{translate key="about.subscriptions"}</a></li>
		{if !empty($journalSettings.enableAuthorSelfArchive)}<li><a href="{url op="editorialPolicies" anchor="authorSelfArchivePolicy"}">{translate key="about.authorSelfArchive"}</a></li>{/if}
		{if !empty($journalSettings.enableDelayedOpenAccess)}<li><a href="{url op="editorialPolicies" anchor="delayedOpenAccessPolicy"}">{translate key="about.delayedOpenAccess"}</a></li>{/if}
	{/if}{* $currentJournal->getSetting('publishingMode') == $smarty.const.PUBLISHING_MODE_SUBSCRIPTION *}
	{foreach key=key from=$customAboutItems item=customAboutItem}
		{if $customAboutItem.title!=''}<li><a href="{$baseUrl}/about/editorialPolicies.html#custom-{$key}">{$customAboutItem.title|escape}</a></li>{/if}
	{/foreach}
	{call_hook name="Templates::About::Index::Policies"}
</ul>
</div>
</div>

<div id="column_two">
<div id="aboutSubmissions">
<div class="about_block_title"><h3>{translate key="about.submissions"}</h3></div>
<ul class="plain">
	<li><a href="{$baseUrl}/about/submissions.html#sectionPolicies"">{translate key="about.sectionPolicies"}</a></li>
	{if $currentJournal->getLocalizedSetting('reviewPolicy') != ''}<li><a href="{$baseUrl}/about/submissions.html#peerReviewProcess">{translate key="about.authorGuidelines"} {translate key="frontpage.CoordinatorsAnd"} {translate key="about.peerReviewProcess"}</a></li>{/if}
	{*{if $currentJournal->getLocalizedSetting('authorGuidelines') != ''}<li><a href="{$baseUrl}/about/submissions.html#authorGuidelines">{translate key="about.authorGuidelines"}</a></li>{/if}*}
	<li><a href="{$baseUrl}/about/submissions.html#onlineSubmissions"}">{translate key="about.onlineSubmissions"}</a></li>	
	{if $currentJournal->getLocalizedSetting('copyrightNotice') != ''}<li><a href="{$baseUrl}/about/submissions.html#copyrightNotice">{translate key="about.copyrightNotice"}</a></li>{/if}
	{if $currentJournal->getLocalizedSetting('privacyStatement') != ''}<li><a href="{$baseUrl}/about/submissions.html#privacyStatement">{translate key="about.privacyStatement"}</a></li>{/if}
	{if $currentJournal->getSetting('journalPaymentsEnabled') && ($currentJournal->getSetting('submissionFeeEnabled') || $currentJournal->getSetting('fastTrackFeeEnabled') || $currentJournal->getSetting('publicationFeeEnabled'))}<li><a href="{url op="submissions" anchor="authorFees"}">{translate key="about.authorFees"}</a></li>{/if}
	{call_hook name="Templates::About::Index::Submissions"}
</ul>
</div>
<div id="aboutOther">
<div class="about_block_title"><h3>{translate key="about.other"}</h3></div>
<ul class="plain">
	{if not ($currentJournal->getSetting('publisherInstitution') == '' && $currentJournal->getLocalizedSetting('publisherNote') == '' && $currentJournal->getLocalizedSetting('contributorNote') == '' && empty($journalSettings.contributors) && $currentJournal->getLocalizedSetting('sponsorNote') == '' && empty($journalSettings.sponsors))}<li><a href="{$baseUrl}/about/journalSponsorship.html">{translate key="about.journalSponsorship"}</a></li>{/if}
	{if $currentJournal->getLocalizedSetting('history') != ''}<li><a href="{url op="history"}">{translate key="about.history"}</a></li>{/if}
	<li><a href="{$baseUrl}/about/siteMap.html">{translate key="about.siteMap"}</a></li>
	<li><a href="{$baseUrl}/about/aboutThisPublishingSystem.html">{translate key="about.aboutThisPublishingSystem"}</a></li>
	{if $publicStatisticsEnabled}<li><a href="{url op="statistics"}">{translate key="about.statistics"}</a></li>{/if}
	{call_hook name="Templates::About::Index::Other"}
</ul>
</div>
</div>

{include file="common/footer.tpl"}
{* MODIFICADO OJS V.2.4.2 / 04-2013*}
