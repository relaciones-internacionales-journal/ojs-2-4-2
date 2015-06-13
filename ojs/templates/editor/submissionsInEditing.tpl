{**
 * templates/editor/submissionsInEditing.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Show editor's submissions in editing.
 *
 *}
<div id="editor_submissions_inreview">
	<div class="editor_article_list_head">
		{*<td width="5%">{sort_search key="common.id" sort="id"}</td>*}
		<div class="date">{*<span class="disabled">{translate key="submission.date.mmdd"}</span><br />*}{sort_search key="submissions.submitted" sort="submitDate"}</div>
		<div class="section">{sort_search key="submissions.sec" sort="section"}</div>
		<div class="author">{sort_search key="article.authors" sort="authors"}</div>
		<div class="title">{sort_search key="article.title" sort="title"}</div>
		<div class="correccion">{sort_search key="submission.copyedit" sort="subCopyedit"}</div>
		<div class="maquetacion">{sort_search key="submission.layout" sort="subLayout"}</div>
		<div class="prueba">{sort_search key="submissions.proof" sort="subProof"}</div>
		<div class="editor_selected">{translate key="article.sectionEditor"}</div>
	</div>
	
	{iterate from=submissions item=submission}
	{assign var="layoutSignoff" value=$submission->getSignoff('SIGNOFF_LAYOUT')}
	{assign var="layoutEditorProofSignoff" value=$submission->getSignoff('SIGNOFF_PROOFREADING_LAYOUT')}
	{assign var="copyeditorFinalSignoff" value=$submission->getSignoff('SIGNOFF_COPYEDITING_FINAL')}
	{assign var="highlightClass" value=$submission->getHighlightClass()}
	{assign var="fastTracked" value=$submission->getFastTracked()}
	<div class="editor_article_list"{*{if $highlightClass || $fastTracked} class="{$highlightClass|escape} {if $fastTracked}fastTracked{/if}"{/if}*}>
		{*<td>{$submission->getId()}</td>*}
		<div class="date">{$submission->getDateSubmitted()|date_format:$dateFormatShort}</div>
		<div class="section">{$submission->getSectionAbbrev()|escape}</div>
		<div class="author">{$submission->getAuthorString(true)|truncate:40:"..."|escape}</div>
		<div class="title"><a href="{url op="submissionEditing" path=$submission->getId()}" class="action">{$submission->getLocalizedTitle()|strip_tags|truncate:40:"..."}</a></div>
		<div class="correccion">{if $copyeditorFinalSignoff->getDateCompleted()}{$copyeditorFinalSignoff->getDateCompleted()|date_format:$dateFormatTrunc}{else}&mdash;{/if}</div>
		<div class="maquetacion">{if $layoutSignoff->getDateCompleted()}{$layoutSignoff->getDateCompleted()|date_format:$dateFormatTrunc}{else}&mdash;{/if}</div>
		<div class="prueba">{if $layoutEditorProofSignoff->getDateCompleted()}{$layoutEditorProofSignoff->getDateCompleted()|date_format:$dateFormatTrunc}{else}&mdash;{/if}</div>
		<div class="editor_selected">
			{assign var="editAssignments" value=$submission->getEditAssignments()}
			{foreach from=$editAssignments item=editAssignment}{$editAssignment->getEditorFirstName()|escape} {/foreach}
		</div>
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
