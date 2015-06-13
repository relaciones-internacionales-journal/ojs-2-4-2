{**
 * templates/editor/submissionsInReview.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Show editor's submissions in review.
 *}
<div id="editor_submissions_inreview">
	<div class="editor_article_list_head">
		{*<td width="5%">{sort_search key="common.id" sort="id"}</td>*}
		<div class="date">{*<span class="disabled">{translate key="submission.date.mmdd"}</span><br />*}{sort_search key="submissions.submitted" sort="submitDate"}</div>
		<div class="section">{sort_search key="submissions.sec" sort="section"}</div>
		<div class="author">{sort_search key="article.authors" sort="authors"}</div>
		<div class="title">{sort_search key="article.title" sort="title"}</div>
		<div class="peer_review">
			{translate key="submission.peerReview"}
			<div>				
				<div style="width:30%; float:left;text-align:center;">{translate key="submission.ask"}</div>
				<div style="width:30%; float:left;text-align:center;">{translate key="submission.due"}</div>
				<div style="width:30%; float:left;text-align:center;">{translate key="submission.done"}</div>
			</div>
		</div>
		<div class="editor_decision">{translate key="submissions.ruling"}</div>
		<div class="editor_selected">{translate key="article.sectionEditor"}</div>
	</div>
	
	{iterate from=submissions item=submission}
	{assign var="highlightClass" value=$submission->getHighlightClass()}
	{assign var="fastTracked" value=$submission->getFastTracked()}
	<div class="editor_article_list">
	{*<tr valign="top"{if $highlightClass || $fastTracked} class="{$highlightClass|escape} {if $fastTracked}fastTracked{/if}"{/if}>*}
		{*<td>{$submission->getId()}</td>*}
		<div class="date">{$submission->getDateSubmitted()|date_format:$dateFormatShort}</div>
		<div class="section">{$submission->getSectionAbbrev()|escape}</div>
		<div class="author">{$submission->getAuthorString(true)|truncate:40:"..."|escape}</div>
		<div class="title"><a href="{url op="submissionReview" path=$submission->getId()}" class="action">{$submission->getLocalizedTitle()|strip_tags|truncate:40:"..."}</a></div>
		<div class="peer_review">
			{foreach from=$submission->getReviewAssignments() item=reviewAssignments}
				{foreach from=$reviewAssignments item=assignment name=assignmentList}
					{if not $assignment->getCancelled() and not $assignment->getDeclined()}
					<div>
						<div style="width:30%; float:left;text-align:center;">{if $assignment->getDateNotified()}{$assignment->getDateNotified()|date_format:$dateFormatTrunc}{else}&mdash;{/if}</div>
						<div style="width:30%; float:left;text-align:center;">{if $assignment->getDateCompleted() || !$assignment->getDateConfirmed()}&mdash;{else}{$assignment->getWeeksDue()|default:"&mdash;"}{/if}</div>
						<div style="width:30%; float:left;text-align:center;">{if $assignment->getDateCompleted()}{$assignment->getDateCompleted()|date_format:$dateFormatTrunc}{else}&mdash;{/if}</div>
					</div>
					{/if}
				{foreachelse}
				<div>
					<div style="width:30%; float:left;text-align:center;">&mdash;</div>
					<div style="width:30%; float:left;text-align:center;">&mdash;</div>
					<div style="width:30%; float:left;text-align:center;">&mdash;</div>
				</div>
				{/foreach}
			{foreachelse}
				<div>
					<div style="width:30%; float:left;text-align:center;">&mdash;</div>
					<div style="width:30%; float:left;text-align:center;">&mdash;</div>
					<div style="width:30%; float:left;text-align:center;">&mdash;</div>
				</div>
			{/foreach}
		</div>
		<div class="editor_decision" style="text-align:center;">
			{foreach from=$submission->getDecisions() item=decisions}
				{foreach from=$decisions item=decision name=decisionList}
					{if $smarty.foreach.decisionList.last}
							{$decision.dateDecided|date_format:$dateFormatTrunc}				
					{/if}
				{foreachelse}
					&mdash;
				{/foreach}
			{foreachelse}
				&mdash;
			{/foreach}
		</div>
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
