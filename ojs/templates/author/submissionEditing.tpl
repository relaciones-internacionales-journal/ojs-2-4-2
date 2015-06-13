{**
 * templates/author/submissionEditing.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Author's submission editing.
 *
 *}
{strip}
{translate|assign:"pageTitleTranslated" key="submission.page.editing" id=$submission->getId()}
{assign var="pageCrumbTitle" value="submission.editing"}
{include file="common/header.tpl"}
{/strip}

<div id="editor_top_menu">
	<ul class="nav nav-pills">
	<li><a href="{url op="submission" path=$submission->getId()}">{translate key="submission.summary"}</a></li>
	<li><a href="{url op="submissionReview" path=$submission->getId()}">{translate key="submission.review"}</a></li>
	<li class="active"><a href="{url op="submissionEditing" path=$submission->getId()}">{translate key="submission.editing"}</a></li>
</ul>
</div>

{include file="author/submission/summary.tpl"}

<div class="separator"></div>

{include file="author/submission/copyedit.tpl"}

<div class="separator"></div>

{include file="author/submission/layout.tpl"}

<div class="separator"></div>

{include file="author/submission/proofread.tpl"}

{include file="common/footer.tpl"}

{* MODIFICADO OJS V.2.4.2 / 04-2013*}