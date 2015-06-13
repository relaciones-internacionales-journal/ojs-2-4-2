{**
 * templates/editor/issues/issueToc.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Display the issue's table of contents
 *}
{strip}
{if not $noIssue}
	{assign var="pageTitleTranslated" value=$issue->getIssueIdentification()|escape}
	{assign var="pageCrumbTitleTranslated" value=$issue->getIssueIdentification(false,true)|escape}
{else}
	{assign var="pageTitle" value="editor.issues.noLiveIssues"}
	{assign var="pageCrumbTitle" value="editor.issues.noLiveIssues"}
{/if}
{include file="common/header.tpl"}
{/strip}

<script type="text/javascript">
{literal}
$(document).ready(function() {
	{/literal}{foreach from=$sections key=sectionKey item=section}{literal}
	setupTableDND("#issueToc-{/literal}{$sectionKey|escape}{literal}", "{/literal}{url|escape:"jsparam" op=moveArticleToc escape=false}{literal}");
	{/literal}{/foreach}{literal}
});
{/literal}
</script>

{if !$isLayoutEditor}{* Layout Editors can also access this page. *}
	<div id="editor_top_menu">
		<ul class="nav nav-pills">
		<li><a href="{url op="createIssue"}">{translate key="editor.navigation.createIssue"}</a></li>
		<li{if $unpublished} class="active"{/if}><a href="{url op="futureIssues"}">{translate key="editor.navigation.futureIssues"}</a></li>
		<li{if !$unpublished} class="active"{/if}><a href="{url op="backIssues"}">{translate key="editor.navigation.issueArchive"}</a></li>
		</ul>
	</div>
{/if}

{if not $noIssue}
<br />

<form action="#" style="text-align:right;">
{translate key="issue.issue"}: <select name="issue" class="selectMenu" onchange="if(this.options[this.selectedIndex].value > 0) location.href='{url|escape:"javascript" op="issueToc" path="ISSUE_ID" escape=false}'.replace('ISSUE_ID', this.options[this.selectedIndex].value)" size="1">{html_options options=$issueOptions|truncate:40:"..." selected=$issueId}</select>
</form>

<br />

<div id="editor_top_menu">
	<ul class="nav nav-pills">
		<li class="active"><a href="{url op="issueToc" path=$issueId}">{translate key="issue.toc"}</a></li>
		<li><a href="{url op="issueData" path=$issueId}">{translate key="editor.issues.issueData"}</a></li>
		<li><a href="{url op="issueGalleys" path=$issueId}">{translate key="editor.issues.galleys"}</a></li>
		{if $unpublished}<li><a href="{url page="issue" op="view" path=$issue->getBestIssueId()}">{translate key="editor.issues.previewIssue"}</a></li>{/if}
		{call_hook name="Templates::Editor::Issues::IssueToc::IssuePages"}
	</ul>
</div>

<h3>{translate key="issue.toc"}</h3>
{url|assign:"url" op="resetSectionOrder" path=$issueId}
{if $customSectionOrderingExists}{translate key="editor.issues.resetSectionOrder" url=$url}<br/>{/if}
<form method="post" action="{url op="updateIssueToc" path=$issueId}" onsubmit="return confirm('{translate|escape:"jsparam" key="editor.issues.saveChanges"}')">

{assign var=numCols value=5}
{if $issueAccess == $smarty.const.ISSUE_ACCESS_SUBSCRIPTION && $currentJournal->getSetting('publishingMode') == $smarty.const.PUBLISHING_MODE_SUBSCRIPTION}{assign var=numCols value=$numCols+1}{/if}
{if $enablePublicArticleId}{assign var=numCols value=$numCols+1}{/if}
{if $enablePageNumber}{assign var=numCols value=$numCols+1}{/if}

{foreach from=$sections key=sectionKey item=section}
<div class="editor_toc_sections">
	<h4>{$section[1]}{if $section[4]} <a href="{url op="moveSectionToc" path=$issueId d=u newPos=$section[4] sectionId=$section[0]}">&uarr;</a>{else}&uarr;{/if} {if $section[5]} <a href="{url op="moveSectionToc" path=$issueId d=d newPos=$section[5] sectionId=$section[0]}">&darr;</a>{else}&darr;{/if}</h4>
</div>

<div class="editor_toc_table" id="issueToc-{$sectionKey|escape}">

	<div class="editor_toc_table_head">
		<div class="order">{translate key="common.order"}</div>
		<div class="author">{translate key="article.authors"}</div>
		<div class="title">{translate key="article.title"}</div>
		{if $issueAccess == $smarty.const.ISSUE_ACCESS_SUBSCRIPTION && $currentJournal->getSetting('publishingMode') == $smarty.const.PUBLISHING_MODE_SUBSCRIPTION}<td width="10%">{translate key="editor.issues.access"}</td>{/if}
		{if $enablePublicArticleId}<div class="id">{translate key="editor.issues.publicId"}</div>{/if}
		{if $enablePageNumber}<div class="pages">{translate key="editor.issues.pages"}</div>{/if}
		<div class="remove">{translate key="common.remove"}</div>
		<div class="revised">{translate key="editor.issues.proofed"}</div>
	</div>

	{assign var="articleSeq" value=0}
	{foreach from=$section[2] item=article name="currSection"}

	{assign var="articleSeq" value=$articleSeq+1}
	{assign var="articleId" value=$article->getId()}
	<div id="article-{$article->getPublishedArticleId()|escape}" class="editor_toc_table_list">
		<div class="order"><a href="{url op="moveArticleToc" d=u id=$article->getPublishedArticleId()}" class="plain">&uarr;</a>&nbsp;<a href="{url op="moveArticleToc" d=d id=$article->getPublishedArticleId()}" class="plain">&darr;</a></div>
		<div class="author">
			{foreach from=$article->getAuthors() item=author name=authorList}
				{$author->getLastName()|escape}{if !$smarty.foreach.authorList.last},{/if}
			{/foreach}
		</div>
		<div class="title">{if !$isLayoutEditor}<a href="{url op="submission" path=$articleId}" class="action">{/if}{$article->getLocalizedTitle()|strip_tags|truncate:60:"..."}{if !$isLayoutEditor}</a>{/if}</div>
		{if $issueAccess == $smarty.const.ISSUE_ACCESS_SUBSCRIPTION && $currentJournal->getSetting('publishingMode') == $smarty.const.PUBLISHING_MODE_SUBSCRIPTION}
		<td><select name="accessStatus[{$article->getPublishedArticleId()}]" size="1" class="selectMenu">{html_options options=$accessOptions selected=$article->getAccessStatus()}</select></td>
		{/if}
		{if $enablePublicArticleId}
		<div class="id"><input class="input-mini" type="text" name="publishedArticles[{$article->getId()}]" value="{$article->getPubId('publisher-id')|escape}" size="7" maxlength="255" class="textField" /></div>
		{/if}
		{if $enablePageNumber}<td><input type="text" name="pages[{$article->getId()}]" value="{$article->getPages()|escape}" size="7" maxlength="255" class="textField" /></div>{/if}
		<div class="remove"><input type="checkbox" name="remove[{$article->getId()}]" value="{$article->getPublishedArticleId()}" /></div>
		<div class="revised">
			{if in_array($article->getId(), $proofedArticleIds)}
				{icon name="checked"}
			{else}
				{icon name="unchecked"}
			{/if}
		</div>
	</div>
	{/foreach}
</div>
{foreachelse}
<p><em>{translate key="editor.issues.noArticles"}</em></p>

<div class="separator"></div>
{/foreach}

<p style="float:right; margin-top:20px;">
{if $unpublished && !$isLayoutEditor}
	{* Unpublished; give the option to publish it. *}
	<input type="button" value="{translate key="editor.issues.publishIssue"}" onclick="confirmAction('{url op="publishIssue" path=$issueId}', '{translate|escape:"jsparam" key="editor.issues.confirmPublish"}')" class="btn btn-small" />
{elseif !$isLayoutEditor}
	{* Published; give the option to unpublish it. *}
	<input type="button" value="{translate key="editor.issues.unpublishIssue"}" onclick="confirmAction('{url op="unpublishIssue" path=$issueId}', '{translate|escape:"jsparam" key="editor.issues.confirmUnpublish"}')" class="btn btn-danger btn-small" />
{/if}
<input type="submit" value="{translate key="common.save"}" class="btn btn-small" /></p>
</form>

{/if}

{include file="common/footer.tpl"}
{* MODIFICADO OJS V.2.4.2 / 04-2013*}
