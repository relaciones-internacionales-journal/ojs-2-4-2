{**
 * templates/editor/submissionsArchives.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Show listing of submission archives.
 *
 *}
<div id="editor_submissions">
	<div class="editor_article_list_head">		
		<div class="date">{*<span class="disabled"></span><br />*}{sort_search key="submissions.submitted" sort="submitDate"}</div>
		<div class="section">{sort_search key="submissions.sec" sort="section"}</div>
		<div class="author">{sort_search key="article.authors" sort="authors"}</div>
		<div class="title_shorter">{sort_search key="article.title" sort="title"}</div>
		<div class="status">{sort_search key="common.status" sort="status"}</div>
		<div class="id">{sort_search key="common.id" sort="id"}</div>
	</div>
	
	{iterate from=submissions item=submission}
	{assign var="articleId" value=$submission->getId()}

	<div class="editor_article_list" {if $submission->getFastTracked()} class="fastTracked"{/if}>		
		<div class="date">{$submission->getDateSubmitted()|date_format:$dateFormatShort}</div>
		<div class="section">{$submission->getSectionAbbrev()|escape}</div>
		<div class="author">{$submission->getAuthorString(true)|truncate:40:"..."|escape}</div>
		<div class="title_shorter"><a href="{url op="submissionEditing" path=$articleId}" class="action">{$submission->getLocalizedTitle()|strip_tags|truncate:60:"..."}</a></div>
		<div class="status">
			{assign var="status" value=$submission->getStatus()}
			{if $status == STATUS_ARCHIVED}
				{translate key="submissions.archived"}<br/><a href="{url op="deleteSubmission" path=$articleId}" onclick="return confirm('{translate|escape:"jsparam" key="editor.submissionArchive.confirmDelete"}')" class="action delete">{translate key="common.delete"}</a>
			{elseif $status == STATUS_PUBLISHED}
				{print_issue_id articleId="$articleId"}	
			{elseif $status == STATUS_DECLINED}
				{translate key="submissions.declined"}&nbsp;&nbsp;<a href="{url op="deleteSubmission" path=$articleId}" onclick="return confirm('{translate|escape:"jsparam" key="editor.submissionArchive.confirmDelete"}')" class="action delete">{translate key="common.delete"}</a>
			{/if}
		</div>
		<div class="id">{$articleId|escape}</div>
	</div>

{/iterate}
{if $submissions->wasEmpty()}
	<div><p>{translate key="submissions.noSubmissions"}</p></div>
{else}
	<div class="submissions_pagination">
		<p class="submissions_pagination_text">{page_info iterator=$submissions}</p>
		<p class="submissions_pagination_text">{page_links anchor="submissions" name="submissions" iterator=$submissions searchField=$searchField searchMatch=$searchMatch search=$search dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateFromMonth=$dateFromMonth dateToDay=$dateToDay dateToYear=$dateToYear dateToMonth=$dateToMonth dateSearchField=$dateSearchField section=$section sort=$sort sortDirection=$sortDirection}</p>
	</div>
{/if}
</div>
{* MODIFICADO OJS V.2.4.2 / 04-2013*}
