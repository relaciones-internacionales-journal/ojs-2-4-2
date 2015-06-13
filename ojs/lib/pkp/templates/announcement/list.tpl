{**
 * lib/pkp/templates/announcement/list.tpl
 *
 * Copyright (c) 2000-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Display list of announcements without site header or footer.
 *
 *}
<div class="fp_announcementsHomeEach">

{counter start=1 skip=1 assign="count"}
{iterate from=announcements item=announcement}
	{if !$numAnnouncementsHomepage || $count <= $numAnnouncementsHomepage}	
			<div class="details">
				<p>{$announcement->getDatePosted()}	<span class="divider">/</span>		
			{if $announcement->getTypeId()}
				<span class="details_changecolor">{$announcement->getAnnouncementTypeName()|escape}: {$announcement->getLocalizedTitle()|escape}</span></p>
			{else}
				<span class="details_changecolor">{$announcement->getLocalizedTitle()|escape}</span></p>
			{/if}
			</div>
			<div class="description">
				<p>{$announcement->getLocalizedDescriptionShort()|nl2br}</p>
				{if $announcement->getLocalizedDescription() != null}
					<p class="more"><a href="{url page="announcement" op="view" path=$announcement->getId()}">{translate key="frontpage.ReadMore"}</a></p>
				{/if}
				<hr/>
			</div>
			
	{/if}
	{counter}
{/iterate}
{if $announcements->wasEmpty()}
	<div class="nodata">{translate key="announcement.noneExist"}</div>
	<div class="endseparator">&nbsp;</div>
{/if}
</div>
{* MODIFICADO OJS V.2.4.2 / 04-2013*}