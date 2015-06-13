{**
 * breadcrumbs.tpl
 *
 * Copyright (c) 2000-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Breadcrumbs
 *
 *}
<div id="breadcrumb">
	<a href="{$baseUrl}/index.html">{translate key="navigation.home"}</a> <span class="divider">/</span>
	{foreach from=$pageHierarchy item=hierarchyLink}
		<a href="{$hierarchyLink[0]|escape}" class="hierarchyLink">{if not $hierarchyLink[2]}{translate key=$hierarchyLink[1]}{else}{$hierarchyLink[1]|escape}{/if}</a> <span class="divider">/</span>
	{/foreach}
	{* Disable linking to the current page if the request is a post (form) request. Otherwise following the link will lead to a form submission error. *}
	{if $requiresFormRequest}<span class="current">{else}<a href="{$currentUrl|escape}" class="current">{/if}{$pageCrumbTitleTranslated}{if $requiresFormRequest}</span>{else}</a>{/if}
	{* MODIFICADO OJS V.2.3.7 / 04-2012*}
</div>

