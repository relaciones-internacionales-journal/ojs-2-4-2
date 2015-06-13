{**
 * templates/sectionEditor/reviewerRecommendation.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Form to set the due date for a review.
 *
 *}
{strip}
{assign var="pageTitle" value="submission.recommendation"}
{include file="common/header.tpl"}
{/strip}
<div id="reviewerRecommendation">
<h3>{translate key="editor.article.enterReviewerRecommendation"}</h3>

<br />

<form method="post" action="{url op="enterReviewerRecommendation"}">
<input type="hidden" name="articleId" value="{$articleId|escape}" />
<input type="hidden" name="reviewId" value="{$reviewId|escape}" />
<p><strong>{translate key="editor.article.recommendation"}</strong><br/>
	<select name="recommendation" size="1" class="selectMenu">
		{html_options_translate options=$reviewerRecommendationOptions}
	</select>
</p>
<hr/>
<p><input type="button" value="{translate key="common.cancel"}" class="btn btn-danger" onclick="document.location.href='{url op="submissionReview" path=$articleId escape=false}';"/> <input type="submit" value="{translate key="common.save"}" class="btn" /></p>
</form>
</div>
{include file="common/footer.tpl"}
{* MODIFICADO OJS V.2.4.2 / 04-2013*}
