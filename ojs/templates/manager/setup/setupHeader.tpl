{**
 * templates/manager/setup/setupHeader.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Header for journal setup pages.
 *
 *}
{strip}
{assign var="pageCrumbTitle" value="manager.setup.journalSetup"}
{url|assign:"currentUrl" op="setup"}
{include file="common/header.tpl"}
{/strip}

<div id="editor_top_menu">
	<ul class="nav nav-pills">
		<li id="step1" {if $setupStep == 1} class="active"{/if}><a href="{url op="setup" path="1"}">1. {translate key="manager.setup.details"}</a></li>
		<li id="step2" {if $setupStep == 2} class="active"{/if}><a href="{url op="setup" path="2"}">2. {translate key="manager.setup.policies"}</a></li>
		<li id="step3" {if $setupStep == 3} class="active"{/if}><a href="{url op="setup" path="3"}">3. {translate key="manager.setup.submissions"}</a></li>
		<li id="step4" {if $setupStep == 4} class="active"{/if}><a href="{url op="setup" path="4"}">4. {translate key="manager.setup.management"}</a></li>
		<li id="step5" {if $setupStep == 5} class="active"{/if}><a href="{url op="setup" path="5"}">5. {translate key="manager.setup.look"}</a></li>
	</ul>
</div>

{* MODIFICADO OJS V.2.4.2 / 04-2013*}