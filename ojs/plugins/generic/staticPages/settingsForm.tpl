{**
 * plugins/generic/staticPages/settingsForm.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Form for Static Pages plugin settings.
 *
 *}
{assign var="pageTitle" value="plugins.generic.staticPages.displayName"}
{include file="common/header.tpl"}

{translate key="plugins.generic.staticPages.settingInstructions"}
<br />
{translate key="plugins.generic.staticPages.viewInstructions" pagesPath=$pagesPath|replace:"REPLACEME":"%PATH%"}

<br />
<br />

<form method="post" action="{plugin_url path="edit"}">

{include file="common/formErrors.tpl"}

<table width="100%" class="data_alt">
	<tr><td colspan="3" class="headseparator">&nbsp;</td></tr>
	<tr class="heading" valign="bottom">
		<td width="20%">{translate key="plugins.generic.staticPages.path"}</td>
		<td width="60%">{translate key="plugins.generic.staticPages.pageTitle"}</td>
		<td width="20%">{translate key="common.action"}</td>
	</tr>
	<tr><td colspan="3" class="headseparator">&nbsp;</td></tr>

{iterate from=staticPages item=staticPage}
	<tr valign="top">
		<td width="20%" class="label">{$staticPage->getPath()|escape}</td>
		<td width="50%" class="value" >{$staticPage->getStaticPageTitle()|strip_tags|truncate:40:"..."}</td>
		<td width="30%"><a href="{url page="pages" op="view" path=$staticPage->getPath()}" class="action">{translate key="common.view"}</a> | <a href="{plugin_url path="edit"|to_array:$staticPage->getId()}" class="action">{translate key="common.edit"}</a> | <a href="{plugin_url path="delete"|to_array:$staticPage->getId()}" class="action">{translate key="common.delete"}</a></td>
	</tr>
	<tr>
		<td colspan="3" class="{if $staticPages->eof()}end{/if}separator">&nbsp;</td>
	</tr>
{/iterate}
{if $staticPages->wasEmpty()}
	<tr>
		<td colspan="3" class="nodata">{translate key="plugins.generic.staticPages.noneExist"}</td>
	</tr>
	<tr>
		<td colspan="3" class="endseparator">&nbsp;</td>
	</tr>
{/if}

</table>
<a class="action crear_general" href={plugin_url path="add"}>{translate key="plugins.generic.staticPages.addNewPage"}</a>
<div id="separator"><hr/></div>
<p style="text-align:right"><input type="button" value="{translate key="common.done"}" class="btn btn-small" onclick="document.location.href='{url page="manager" op="plugins" escape=false}'" /></p>

</form>

<p>{translate key="common.requiredField"}</p>

{include file="common/footer.tpl"}
{* MODIFICADO OJS V.2.4.2 / 04-2013*}