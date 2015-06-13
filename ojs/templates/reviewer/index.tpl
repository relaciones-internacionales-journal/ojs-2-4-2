{**
 * templates/reviewer/index.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Reviewer index.
 *
 *}
{strip}
{assign var="pageTitle" value="common.queue.long.$pageToDisplay"}
{include file="common/header.tpl"}
{/strip}

<div id="editor_top_menu">
	<ul class="nav nav-pills">
	<li{if ($pageToDisplay == "active")} class="active"{/if}><a href="{url path="active"}">{translate key="common.queue.short.active"}</a></li>
	<li{if ($pageToDisplay == "completed")} class="active"{/if}><a href="{url path="completed"}">{translate key="common.queue.short.completed"}</a></li>
</ul>
</div>
<br />

{include file="reviewer/$pageToDisplay.tpl"}

{include file="common/footer.tpl"}
{* MODIFICADO OJS V.2.4.2 / 04-2013*}
