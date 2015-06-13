{**
 * templates/about/editorialTeamBoard.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * About the Journal index.
 *
 *}
{strip}
{assign var="pageTitle" value="about.editorialTeam"}
{include file="common/header.tpl"}
{/strip}

{call_hook name="Templates::About::EditorialTeam::Information"}

{foreach from=$groups item=group}
<div id="group">
	<div class="arrow_down_box">
	<h4>{$group->getLocalizedTitle()}</h4>
	</div>
	{assign var=groupId value=$group->getId()}
	{assign var=members value=$teamInfo[$groupId]}

	<ol class="editorialTeam">
		{foreach from=$members item=member}
			{assign var=user value=$member->getUser()}
			<div class="member">			
			    <div class="profilePicContent">
					{assign var="profileImage" value=$user->getSetting('profileImage')}
					{if $profileImage}
						<img height="{$profileImage.height|escape}" width="{$profileImage.width|escape}" alt="{translate key="user.profile.profileImage"}" src="{$sitePublicFilesDir}/{$profileImage.uploadName}" />
					{/if}
				</div>
				<div class="mainContentBio">       
					<div class="contentBio">
						<p><span class="staff_name">{$user->getFullName()|escape}</span>
								{assign_mailto var=address address=$user->getEmail()|escape}
								<a href="mailto:{$user->getEmail()|escape:"quotes"}"><img src="http://www.relacionesinternacionales.info/ojs/templates/images/style_dark/mail_12x9.png" alt="{translate key="user.email}" width="12" height="9" class="staff_email" align="bottom"/></a>
								{*{icon name="mail" url=$address}*}
							</p>
							<p>
							{if $user->getUrl()}<a href="{$user->getUrl()|escape:"quotes"}" target="_new">{$user->getUrl()|escape}</a><br/>{/if}
							{if $user->getLocalizedAffiliation()}{$user->getLocalizedAffiliation()|escape}{assign var=needsComma value=1}<br />{/if}
							{if $country}{if $needsComma}, {/if}{$country|escape}{/if}
							{$user->getLocalizedBiography()|nl2br|strip_unsafe_html}</p>
					</div>
				</div>
			</div>
		{/foreach}{* $members *}
	</ol>
</div>
{/foreach}{* $groups *}

{include file="common/footer.tpl"}
{* MODIFICADO OJS V.2.4.2 / 04-2013*}
