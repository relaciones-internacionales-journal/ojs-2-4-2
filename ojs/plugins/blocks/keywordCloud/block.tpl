{**
 * plugins/blocks/keywordCloud/block.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Keyword cloud block plugin
 *
 *}
<div class="block" id="sidebarKeywordCloud">
	<div class="blockTitleModified">{translate key="plugins.block.keywordCloud.title"}</div>
	<ul class="sd_bl_keywords">
	{foreach name=cloud from=$cloudKeywords key=keyword item=count}
		<li><a href="{url page="search" subject=$keyword}">{$keyword}</a></li>
	{/foreach}
	</ul>
</div>
{* MODIFICADO OJS V.2.4.2 / 04-2012*}