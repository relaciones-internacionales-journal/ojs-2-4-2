{**
 * announcementTypes.tpl
 *
 * Copyright (c) 2000-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Display list of announcement types in management.
 *
 *}
{strip}
{assign var="pageTitle" value="manager.announcementTypes"}
{assign var="pageId" value="manager.announcementTypes"}
{include file="common/header.tpl"}
{/strip}

<div id="editor_top_menu">
	<ul class="nav nav-pills">
		<li><a href="{url op="announcements"}">{translate key="manager.announcements"}</a></li>
		<li class="active"><a href="{url op="announcementTypes"}">{translate key="manager.announcementTypes"}</a></li>
	</ul>
</div>
<br />

<div id="announcementTypes">
<table width="100%" class="listing">
	<tr>
		<td colspan="2" class="headseparator">&nbsp;</td>
	</tr>
	<tr class="heading" valign="bottom">
		<td width="85%">{translate key="manager.announcementTypes.typeName"}</td>
		<td width="15%">{translate key="common.action"}</td>
	</tr>
	<tr>
		<td colspan="2" class="headseparator">&nbsp;</td>
	</tr>
{iterate from=announcementTypes item=announcementType}
	<tr valign="top">
		<td>{$announcementType->getLocalizedTypeName()|escape}</td>
		<td><a href="{url op="editAnnouncementType" path=$announcementType->getId()}" class="action editar_general">{translate key="common.edit"}</a>&nbsp;|&nbsp;<a href="{url op="deleteAnnouncementType" path=$announcementType->getId()}" onclick="return confirm('{translate|escape:"jsparam" key="manager.announcementTypes.confirmDelete"}')" class="action delete">{translate key="common.delete"}</a></td>
	</tr>
	<tr>
		<td colspan="2" class="{if $announcementTypes->eof()}end{/if}separator">&nbsp;</td>
	</tr>
{/iterate}
{if $announcementTypes->wasEmpty()}
	<tr>
		<td colspan="2" class="nodata">{translate key="manager.announcementTypes.noneCreated"}</td>
	</tr>
	<tr>
		<td colspan="2" class="endseparator">&nbsp;</td>
	</tr>
{else}
	<tr>
		<td align="left" class="table_results_pagination">{page_info iterator=$announcementTypes}</td>
		<td align="right" class="table_results_pagination_pages">{page_links anchor="announcementTypes" name="announcementTypes" iterator=$announcementTypes}</td>
	</tr>
{/if}
</table>

<a href="{url op="createAnnouncementType"}" class="action crear_general">{translate key="manager.announcementTypes.create"}</a>
</div>

{include file="common/footer.tpl"}
{* MODIFICADO OJS V.2.4.2 / 04-2013*}
