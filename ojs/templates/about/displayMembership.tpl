{**
 * templates/about/displayMembership.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Display group membership information.
 *
 *}
{strip}
{assign var="pageTitle" value="about.people"}
{include file="common/header.tpl"}
{/strip}

<div id="displayMembership">
<div class="arrow_down_box"><h3>{$group->getLocalizedTitle()}</h3></div>
{assign var=groupId value=$group->getId()}

{foreach from=$memberships item=member}
	{assign var=user value=$member->getUser()}
	<div class="board_member">
	<p><strong>{$user->getFullName()|escape}</strong><br>
	{if $user->getLocalizedAffiliation()}{$user->getLocalizedAffiliation()|escape}{/if}{if $user->getCountry()}{assign var=countryCode value=$user->getCountry()}{assign var=country value=$countries.$countryCode}, {$country|escape}{/if}</div>
	</p>
{/foreach}
</div>

{include file="common/footer.tpl"}

