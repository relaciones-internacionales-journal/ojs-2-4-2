{**
 * plugins/blocks/relatedItems/block.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Keyword cloud block plugin
 *
 *}

{if $journalRt && $journalRt->getEnabled() && $journalRt->getDefineTerms() && $version}

<script type="text/javascript">
	{literal}initRelatedItems();{/literal}
</script>


<div class="block" id="sidebarRTRelatedItems">
	<div class="blockTitleModified">{translate key="plugins.block.relatedItems.title"}</div>
		<table width="100%">
			<tr>
				<td valign="top" style="width:26px;">
					<a href="#" class="rtitems">#</a>
				</td>
				<td valign="top">
					<div id="relatedItems">
						<ul class="plain">
						{foreach from=$version->getContexts() item=context}
							{if !$context->getDefineTerms()}
								<li><a href="javascript:openRTWindowWithToolbar('{url page="rt" op="context" path=$articleId|to_array:$galleyId:$context->getContextId()}');">{$context->getTitle()|escape}</a></li>
							{/if}
						{/foreach}
						</ul>
					</div>
					<div id="toggleRelatedItems">
						<span id="hideRelatedItems" style="display:none;"><strong>X</strong> {translate key="plugins.block.relatedItems.hide"}</span>
						<span id="showRelatedItems">{translate key="plugins.block.relatedItems.show"}</span>
					</div>
				</td>
			</tr>
		</table>
</div>

{/if}{* MODIFICADO OJS V.2.4.2 / 04-2013*}