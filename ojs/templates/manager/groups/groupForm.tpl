{**
 * templates/manager/groups/groupForm.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Group form under journal management.
 *
 *}
{strip}
{assign var="pageId" value="manager.groups.groupForm"}
{assign var="pageCrumbTitle" value=$pageTitle}
{include file="common/header.tpl"}
{/strip}
<div id="groupFormDiv">
{if $group}
	<div id="editor_top_menu">
		<ul class="nav nav-pills">
			<li class="active"><a href="{url op="editGroup" path=$group->getId()}">{translate key="manager.groups.editTitle"}</a></li>
			<li><a href="{url op="groupMembership" path=$group->getId()}">{translate key="manager.groups.membership}</a></li>
		</ul>
	</div>
{/if}

<br/>

<form id="groupForm" method="post" action="{url op="updateGroup"}">
{if $group}
	<input type="hidden" name="groupId" value="{$group->getId()}"/>
{/if}

{include file="common/formErrors.tpl"}
<table class="data" width="100%">
{if count($formLocales) > 1}
	<tr valign="top">
		<td width="20%" class="label">{fieldLabel name="formLocale" key="form.formLanguage"}</td>
		<td width="80%" class="value">
			{if $group}{url|assign:"groupFormUrl" op="editGroup" path=$group->getId() escape=false}
			{else}{url|assign:"groupFormUrl" op="createGroup" escape=false}
			{/if}
			{form_language_chooser form="groupForm" url=$groupFormUrl}
			<span class="instruct">{translate key="form.formLanguage.description"}</span>
		</td>
	</tr>
{/if}
<tr valign="top">
	<td width="20%" class="label">{fieldLabel name="title" required="true" key="manager.groups.title"}</td>
	<td width="80%" class="value"><input type="text" name="title[{$formLocale|escape}]" value="{$title[$formLocale]|escape}" size="35" maxlength="80" id="title" class="textField" /></td>
</tr>

<tr valign="top">
	<td width="20%" class="label">&nbsp;</td>
	<td width="80%" class="value">
		<label class="checkbox"><input type="checkbox" name="publishEmail" value="1" {if $publishEmail}checked="checked" {/if} id="publishEmail" />
		{fieldLabel name="publishEmail" key="manager.groups.publishEmails"}</label>
	</td>
</tr>
<tr valign="top">
	<td width="20%" class="label">{translate key="common.type"}</td>
	<td width="80%" class="value">
		{foreach from=$groupContextOptions item=groupContextOptionKey key=groupContextOptionValue}
			<label class="checkbox"><input type="radio" name="context" value="{$groupContextOptionValue|escape}" {if $context == $groupContextOptionValue}checked="checked" {/if} id="context-{$groupContextOptionValue|escape}" />
			{fieldLabel name="context-"|concat:$groupContextOptionValue key=$groupContextOptionKey}</label><br/>
		{/foreach}
	</td>
</tr>
</table>

<p style="text-align:right;">
<input type="button" value="{translate key="common.cancel"}" class="btn btn-danger btn-small" onclick="document.location.href='{url op="groups" escape=false}'" /> 
<input type="submit" value="{translate key="common.save"}" class="btn btn-small" /></p>
</form>

<p><span class="formRequired">{translate key="common.requiredField"}</span></p>
</div>
{include file="common/footer.tpl"}
{* MODIFICADO OJS V.2.4.2 / 04-2013*}
