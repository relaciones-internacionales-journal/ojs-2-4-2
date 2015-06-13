{**
 * templates/author/submission.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Author's submission summary.
 *
 *}
{strip}
{translate|assign:"pageTitleTranslated" key="submission.page.summary" id=$submission->getId()}
{assign var="pageCrumbTitle" value="submission.summary"}
{include file="common/header.tpl"}
{/strip}

<div id="editor_top_menu">
	<ul class="nav nav-pills">
	<li class="active"><a href="{url op="submission" path=$submission->getId()}">{translate key="submission.summary"}</a></li>
	<li><a href="{url op="submissionReview" path=$submission->getId()}">{translate key="submission.review"}</a></li>
	<li><a href="{url op="submissionEditing" path=$submission->getId()}">{translate key="submission.editing"}</a></li>
</ul>
</div>

{include file="author/submission/management.tpl"}

{if $authorFees}

{include file="author/submission/authorFees.tpl"}
{/if}

{include file="author/submission/status.tpl"}


{include file="submission/metadata/metadata.tpl"}

{include file="common/footer.tpl"}

