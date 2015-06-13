{**
 * lib/pkp/templates/announcement/index.tpl
 *
 * Copyright (c) 2000-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Display list of announcements.
 *
 *}
{strip}
{assign var="pageTitle" value="announcement.announcements"}
{assign var="pageId" value="announcement.announcements"}
{include file="common/header.tpl"}
{/strip}

<div id="announcementList">
	<div class="news_list">
	{if $announcementsIntroduction != null}
		<div class="intro">
			<{$announcementsIntroduction|nl2br}
		</div>
	{/if}
	{iterate from=announcements item=announcement}
		{if $announcement->getTypeId()}
			<h4>{$announcement->getAnnouncementTypeName()|escape}: {$announcement->getLocalizedTitle()|escape}</h4>
		{else}
			<h4>{$announcement->getLocalizedTitle()|escape}</h4>
		{/if}
		
		<div class="news_details">
			{translate key="announcement.posted"}: {$announcement->getDatePosted()}		
		</div>
		<div class="news_description">
			{$announcement->getLocalizedDescriptionShort()|nl2br}
			{if $announcement->getLocalizedDescription() != null}
				<div class="news_more"><a href="{$baseUrl}/announcement/view/{$announcement->getId()}.html">{translate key="frontpage.ReadMore"}</a></div>
			{/if}
		</div>
		<div class="separator"><hr/></div>
		{*<tr>
			<td colspan="2" class="{if $announcements->eof()}end{/if}separator">&nbsp;</td>
		</tr>*}
	{/iterate}
	{if $announcements->wasEmpty()}
		<div class="nodata">{translate key="announcement.noneExist"}</div>
		<div class="endseparator">&nbsp;</div>
	{else}
		<div class="news_pagination">
			<p class="news_pagination_text">{page_info iterator=$announcements}{page_links anchor="announcements" name="announcements" iterator=$announcements}</p>
		</div>
	{/if}

	</div>
</div>
{include file="common/footer.tpl"}
{* MODIFICADO OJS V.2.4.2 / 04-2013*}