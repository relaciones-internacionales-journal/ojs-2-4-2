{**
 * templates/author/submit/complete.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * The submission process has been completed; notify the author.
 *
 *}
{strip}
{assign var="pageTitle" value="author.track"}
{include file="common/header.tpl"}
{/strip}

<div id="author_submissionComplete">
<p class="big">{translate key="author.submit.submissionComplete" journalTitle=$journal->getLocalizedTitle()}</p>

{if $canExpedite}
	{url|assign:"expediteUrl" op="expediteSubmission" articleId=$articleId}
	{translate key="author.submit.expedite" expediteUrl=$expediteUrl}
{/if}
{if $paymentButtonsTemplate }
	{include file=$paymentButtonsTemplate orientation="vertical"}
{/if}
<div class="separator"><hr/></div>
<p><a href="{url op="index"}" class="buscar_general">{translate key="author.track"}</a></p>
</div>

{include file="common/footer.tpl"}

{* MODIFICADO OJS V.2.4.2 / 04-2013*}