{**
 * view.tpl
 *
 * Copyright (c) 2000-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * View full announcement text.
 *
 *}
{strip}
{assign var="pageTitleTranslated" value=$announcementTitle}
{assign var="pageId" value="announcement.view"}
{include file="common/header.tpl"}
{/strip}

{$announcement->getLocalizedDescription()|nl2br}
{* MODIFICADO OJS V.2.4.2 / 04-2013*}
{include file="common/footer.tpl"}

