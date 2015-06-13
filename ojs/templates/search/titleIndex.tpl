{**
 * templates/search/titleIndex.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Display published articles by title
 *
 *}
{strip}
{assign var=pageTitle value="search.titleIndex"}
{include file="common/header.tpl"}
{/strip}

<br />

{if $currentJournal}
	{assign var=numCols value=3}
{else}
	{assign var=numCols value=4}
{/if}

<div id="title_results">
<table width="100%" class="listing"  style="font-size:12px;">
<tr><td colspan="{$numCols|escape}" class="headseparator">&nbsp;</td></tr>
<tr class="heading" valign="bottom">
	{if !$currentJournal}<td width="80%">{translate key="issue.issue"}</td>{/if}
	<td width="80%" class="long_result">{translate key="article.title"}</td>
	<td width="20%" class="short_result">{translate key="article.details"}</td>
</tr>
<tr><td colspan="{$numCols|escape}" class="headseparator">&nbsp;</td></tr>

{iterate from=results item=result}
{assign var=publishedArticle value=$result.publishedArticle}
{assign var=article value=$result.article}
{assign var=issue value=$result.issue}
{assign var=issueAvailable value=$result.issueAvailable}
{assign var=journal value=$result.journal}
<tr valign="top">
	{if !$currentJournal}<td><a href="{url journal=$journal->getPath()}">{$journal->getLocalizedTitle()|escape}</a></td>{/if}
	<td width="80%" style="font-weight: bold;">{$article->getLocalizedTitle()|strip_unsafe_html}</td>
	<td width="20%">
		{foreach from=$article->getAuthors() item=author name=authorList}
		<p style="font-style: italic;">{$author->getFullName()|escape}{if !$smarty.foreach.authorList.last},{/if}</p>
		{/foreach}
		<p class="TitleIssue">{if $issueAvailable}<a href="{url journal=$journal->getPath() page="issue" op="view" path=$issue->getBestIssueId($journal)}">{/if}{$issue->getNumber()|strip_unsafe_html|nl2br} <span class="divider">/</span> {$issue->getYear()|strip_unsafe_html|nl2br}{if $issueAvailable}</a>{/if}</p>
		<p class="TitleAbstract"><a href="{url journal=$journal->getPath() page="article" op="view" path=$publishedArticle->getBestArticleId($journal)}" class="file">{if $article->getLocalizedAbstract()}{translate key="article.abstract"}{else}{translate key="article.details"}{/if}</a></p>
		{if $issueAvailable}
		{foreach from=$publishedArticle->getGalleys() item=galley name=galleyList}	
		<p class="TitleGalley""><a href="{url journal=$journal->getPath() page="article" op="view" path=$publishedArticle->getBestArticleId($journal)|to_array:$galley->getBestGalleyId($journal)}" class="file">{$galley->getGalleyLabel()|escape}</a></p>
		{/foreach}
		{/if}
	</td>
</tr>

<tr><td colspan="{$numCols|escape}" class="{if $results->eof()}end{/if}separator">&nbsp;</td></tr>
{/iterate}
{if $results->wasEmpty()}
<tr>
<td colspan="{$numCols|escape}" class="nodata">{translate key="search.noResults"}</td>
</tr>
<tr><td colspan="{$numCols|escape}" class="endseparator">&nbsp;</td></tr>
{else}
	<tr>
		<td class="table_results_pagination" {if !$currentJournal}colspan="2" {/if}align="left">{page_info iterator=$results}</td>
		<td class="table_results_pagination_pages" colspan="2" align="right">{page_links anchor="results" iterator=$results name="search"}</td>
	</tr>
{/if}
</table>
</div>
{include file="common/footer.tpl"}
{* MODIFICADO OJS V.2.4.2 / 04-2013*}
