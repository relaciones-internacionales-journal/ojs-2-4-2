{**
 * templates/search/search.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * A unified search interface.
 *}
{strip}
{assign var="pageTitle" value="navigation.search"}
{include file="common/header.tpl"}
{/strip}

<div id="advanced_search">
<p>{translate key="search.infoAboutResults"}</p>
	<script type="text/javascript">
		$(function() {ldelim}
			// Attach the form handler.
			$('#searchForm').pkpHandler('$.pkp.pages.search.SearchFormHandler');
		{rdelim});
	</script>
	<form method="post" id="searchForm" action="{url op="search"}" class="form-horizontal">
		
		<div class="control-group" style="display:none;">
			<label class="control-label" for="query">{translate key="search.searchAllCategories"}</label>
			<div class="controls">
				{capture assign="queryFilter"}{call_hook name="Templates::Search::SearchResults::FilterInput" filterName="query" filterValue=$query}{/capture}
				{if empty($queryFilter)}
					<input class="input-xlarge" type="text" id="query" name="query" size="40" maxlength="255" value="{$query|escape}" class="textField" />
				{else}
					{$queryFilter}
				{/if}
					&nbsp;
					<input type="submit" value="{translate key="common.search"}" class="btn" />
			</div>
		</div>
		
		{if $siteSearch}
		<div class="control-group">
			<label class="control-label" for="searchJournal">{translate key="search.withinJournal"}</label>
			<div class="controls"><select name="searchJournal" id="searchJournal" class="selectMenu">{html_options options=$journalOptions selected=$searchJournal}</select>
			</div>
		</div>
		{/if}
		
		{if $hasActiveFilters}
		<div class="search_filters">
			<div class="arrow_down_box">
				<h4>{translate key="search.activeFilters"}</h4>
			</div>
		</div>
			{include file="search/searchFilter.tpl" displayIf="activeFilter" filterName="authors" filterValue=$authors key="search.author"}
			{include file="search/searchFilter.tpl" displayIf="activeFilter" filterName="title" filterValue=$title key="article.title"}
			{include file="search/searchFilter.tpl" displayIf="activeFilter" filterName="abstract" filterValue=$abstract key="search.abstract"}
			{include file="search/searchFilter.tpl" displayIf="activeFilter" filterName="galleyFullText" filterValue=$galleyFullText key="search.fullText"}
			{include file="search/searchFilter.tpl" displayIf="activeFilter" filterName="suppFiles" filterValue=$suppFiles key="article.suppFiles"}
			{include file="search/searchFilter.tpl" displayIf="activeFilter" filterType="date" filterName="dateFrom" filterValue=$dateFrom startYear=$startYear endYear=$endYear key="search.dateFrom"}
			{include file="search/searchFilter.tpl" displayIf="activeFilter" filterType="date" filterName="dateTo" filterValue=$dateTo startYear=$startYear endYear=$endYear key="search.dateTo"}
			{include file="search/searchFilter.tpl" displayIf="activeFilter" filterName="discipline" filterValue=$discipline key="search.discipline"}
			{include file="search/searchFilter.tpl" displayIf="activeFilter" filterName="subject" filterValue=$subject key="search.subject"}
			{include file="search/searchFilter.tpl" displayIf="activeFilter" filterName="type" filterValue=$type key="search.typeMethodApproach"}
			{include file="search/searchFilter.tpl" displayIf="activeFilter" filterName="coverage" filterValue=$coverage key="search.coverage"}
			{include file="search/searchFilter.tpl" displayIf="activeFilter" filterName="indexTerms" filterValue=$indexTerms key="search.indexTermsLong"}
			{/if}
		<br/>
		{if $hasEmptyFilters}
			{capture assign="emptyFilters"}				
					{if empty($authors) || empty($title) || empty($abstract) || empty($galleyFullText) || empty($suppFiles)}
					<div class="col-1" >
						<div class="search_filters">
							<div class="arrow_down_box">
							<h4>{translate key="search.searchCategories"}</h4>
							</div>
						</div>
						{include file="search/searchFilter.tpl" displayIf="emptyFilter" filterName="authors" filterValue=$authors key="search.author"}
						{include file="search/searchFilter.tpl" displayIf="emptyFilter" filterName="title" filterValue=$title key="article.title"}
						{include file="search/searchFilter.tpl" displayIf="emptyFilter" filterName="abstract" filterValue=$abstract key="search.abstract"}
						{include file="search/searchFilter.tpl" displayIf="emptyFilter" filterName="galleyFullText" filterValue=$galleyFullText key="search.fullText"}
						{include file="search/searchFilter.tpl" displayIf="emptyFilter" filterName="suppFiles" filterValue=$suppFiles key="article.suppFiles"}						
					</div>
					{/if}
					{if empty($discipline) || empty($subject) || empty($type) || empty($coverage)}
					<div class="col-2">
						<div class="search_filters">
							<div class="arrow_down_box"><h4>{translate key="search.indexTerms"}</h4>
							</div>
						</div>
						{include file="search/searchFilter.tpl" displayIf="emptyFilter" filterName="discipline" filterValue=$discipline key="search.discipline"}
						{include file="search/searchFilter.tpl" displayIf="emptyFilter" filterName="subject" filterValue=$subject key="search.subject"}
						{include file="search/searchFilter.tpl" displayIf="emptyFilter" filterName="type" filterValue=$type key="search.typeMethodApproach"}
						{include file="search/searchFilter.tpl" displayIf="emptyFilter" filterName="coverage" filterValue=$coverage key="search.coverage"}
						{include file="search/searchFilter.tpl" displayIf="emptyFilter" filterName="indexTerms" filterValue=$indexTerms key="search.indexTermsLong"}						
						
					</div>
					{/if}				
				</div>
				{if $dateFrom == '--' || $dateTo == '--'}
				<div class="date_search">
					<div class="search_filters">
						<div class="arrow_down_box"><h4>{translate key="search.date"}</h4>
						</div>
					</div>
					{include file="search/searchFilter.tpl" displayIf="emptyFilter" filterType="date" filterName="dateFrom" filterValue=$dateFrom startYear=$startYear endYear=$endYear key="search.dateFrom"}
					{include file="search/searchFilter.tpl" displayIf="emptyFilter" filterType="date" filterName="dateTo" filterValue=$dateTo startYear=$startYear endYear=$endYear key="search.dateTo"}
				</div>
				{/if}

				<div style="float:left;width:100%; clear:both;"><p style="margin-top:20px;"><input type="submit" value="{translate key="common.search"}" class="btn btn-small" /></p></div>
			{/capture}
			{include file="controllers/extrasOnDemand.tpl" id="emptyFilters" moreDetailsText="search.advancedSearchMore" lessDetailsText="search.advancedSearchLess" extraContent=$emptyFilters}
		{/if}
	</form>
</div>
<br />

{call_hook name="Templates::Search::SearchResults::PreResults"}

{if $currentJournal}
	{assign var=numCols value=3}
{else}
	{assign var=numCols value=4}
{/if}
<div id="advanced_search_results">
	<div class="search_filters">
		<div class="arrow_down_box"><h4>{translate key="search.infoSearchResults"}</h4>
			</div>
		</div>
	<table width="100%" class="listing" style="font-size:12px;">
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
			{assign var=section value=$result.section}
			<tr valign="top">
				{if !$currentJournal}
					<td><a href="{url journal=$journal->getPath()}">{$journal->getLocalizedTitle()|escape}</a></td>
				{/if}
				<td width="80%" style="font-weight: bold;">{$article->getLocalizedTitle()|strip_unsafe_html}</td>
				<td width="20%">
					{foreach from=$article->getAuthors() item=authorItem name=authorList}
						<p style="font-style: italic;">{$authorItem->getFullName()|escape}{if !$smarty.foreach.authorList.last},{/if}</p>
					{/foreach}
					<p class="TitleIssue"><a href="{url journal=$journal->getPath() page="issue" op="view" path=$issue->getBestIssueId($journal)}">{$issue->getNumber()|strip_unsafe_html|nl2br} <span class="divider">/</span> {$issue->getYear()|strip_unsafe_html|nl2br}</a></p>
					{if $publishedArticle->getAccessStatus() == $smarty.const.ARTICLE_ACCESS_OPEN|| $issueAvailable}
						{assign var=hasAccess value=1}
					{else}
						{assign var=hasAccess value=0}
					{/if}
					{if $publishedArticle->getLocalizedAbstract() != ""}
						{assign var=hasAbstract value=1}
					{else}
						{assign var=hasAbstract value=0}
					{/if}
					{if !$hasAccess || $hasAbstract}
						<p class="TitleAbstract"><a href="{url journal=$journal->getPath() page="article" op="view" path=$publishedArticle->getBestArticleId($journal)}" class="file">
							{if !$hasAbstract}
								{translate key="article.details"}
							{else}
								{translate key="article.abstract"}
							{/if}
						</a></p>
					{/if}
					{if $hasAccess}
						{foreach from=$publishedArticle->getLocalizedGalleys() item=galley name=galleyList}
							<p class="TitleGalley""><a href="{url journal=$journal->getPath() page="article" op="view" path=$publishedArticle->getBestArticleId($journal)|to_array:$galley->getBestGalleyId($journal)}" class="file">{$galley->getGalleyLabel()|escape}</a></p>
					
						{/foreach}
					{/if}
					{call_hook name="Templates::Search::SearchResults::AdditionalArticleLinks" articleId=$publishedArticle->getId()}
				</td>
			</tr>

			{call_hook name="Templates::Search::SearchResults::AdditionalArticleInfo" articleId=$publishedArticle->getId() numCols=$numCols|escape}
			<tr><td colspan="{$numCols|escape}" class="{if $results->eof()}end{/if}separator">&nbsp;</td></tr>
		{/iterate}
		{if $results->wasEmpty()}
			<tr>
				<td colspan="{$numCols|escape}" class="nodata">
					{if $error}
						{$error|escape}
					{else}
						{translate key="search.noResults"}
					{/if}
				</td>
			</tr>
			<tr><td colspan="{$numCols|escape}" class="endseparator">&nbsp;</td></tr>
		{else}
			<tr>
				<td class="table_results_pagination"{if !$currentJournal}colspan="2" {/if}align="left">{page_info iterator=$results}</td>
				<td class="table_results_pagination_pages" colspan="2" align="right">{page_links anchor="results" iterator=$results name="search" query=$query searchJournal=$searchJournal authors=$authors title=$title abstract=$abstract galleyFullText=$galleyFullText suppFiles=$suppFiles discipline=$discipline subject=$subject type=$type coverage=$coverage indexTerms=$indexTerms dateFromMonth=$dateFromMonth dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateToMonth=$dateToMonth dateToDay=$dateToDay dateToYear=$dateToYear orderBy=$orderBy orderDir=$orderDir}</td>
			</tr>
		{/if}
	</table>
</div>

	{capture assign="syntaxInstructions"}{call_hook name="Templates::Search::SearchResults::SyntaxInstructions"}{/capture}
	<div style="float:left;width:100%; margin-top:30px;"><p>
		{if empty($syntaxInstructions)}
			{translate key="search.syntaxInstructions"}
		{else}
			{* Must be properly escaped in the controller as we potentially get HTML here! *}
			{$syntaxInstructions}
		{/if}
	</p>

{include file="common/footer.tpl"}
{* MODIFICADO OJS V.2.4.2 / 04-2013*}
