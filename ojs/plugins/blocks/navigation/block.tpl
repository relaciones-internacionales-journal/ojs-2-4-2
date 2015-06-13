{**
 * plugins/blocks/navigation/block.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Common site sidebar menu -- navigation links.
 *
 *}
{if !$currentJournal || $currentJournal->getSetting('publishingMode') != $smarty.const.PUBLISHING_MODE_NONE}
<div class="block" id="sidebarNavigation">
	<div class="blockTitleModified">{translate key="plugins.block.navigation.journalContent"}</div>

	{**<span class="blockSubtitle">{translate key="navigation.search"}</span>
	<form id="simpleSearchForm" method="post" action="{url page="search" op="search"}">
		<table id="simpleSearchInput">
			<tr>
				<td>
				{capture assign="filterInput"}{call_hook name="Templates::Search::SearchResults::FilterInput" filterName="simpleQuery" filterValue="" size=15}{/capture}
				{if empty($filterInput)}
					<input type="text" id="simpleQuery" name="simpleQuery" size="15" maxlength="255" value="" class="textField" />
				{else}
					{$filterInput}
				{/if}
				</td>
			</tr>
			<tr>
				<td><select id="searchField" name="searchField" size="1" class="selectMenu">
					{html_options_translate options=$articleSearchByOptions}
				</select></td>
			</tr>
			<tr>
				<td><input type="submit" value="{translate key="common.search"}" class="button" /></td>
			</tr>
		</table>
	</form>

	<br />
	 *}
	{if $currentJournal}
	<span class="blockSubtitle"></span>
	<ul class="sidebar_block_list_search">
		<li class="sd_bl_search_issue"><a href="{$baseUrl}/issue/archive.html">{translate key="navigation.browseByIssue"}</a></li>
		<li class="sd_bl_search_author"><a href="{$baseUrl}/search/authors.html">{translate key="navigation.browseByAuthor"}</a></li>
		<li class="sd_bl_search_title"><a href="{$baseUrl}/search/titles.html">{translate key="navigation.browseByTitle"}</a></li>
		<li class="sd_bl_search"><a href="{$baseUrl}/search/index.html">{translate key="navigation.advanced.search"}</a></li>
		{call_hook name="Plugins::Blocks::Navigation::BrowseBy"}
		{**{if $hasOtherJournals}
			<li><a href="{url journal="index"}">{translate key="navigation.otherJournals"}</a></li>
			{if $siteCategoriesEnabled}<li><a href="{url journal="index" page="search" op="categories"}">{translate key="navigation.categories"}</a></li>{/if}
		{/if}*}
	</ul>
	{/if}
</div>
{/if}
{* MODIFICADO OJS V.2.4.2 / 04-2012*}