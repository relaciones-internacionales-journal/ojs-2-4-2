{**
 * templates/sectionEditor/submission/editorDecision.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the editor decision table.
 *
 *}
<div id="editorDecision">
<h3>{translate key="submission.editorDecision"}</h3>

<p><strong>{translate key="editor.article.selectDecision"}</strong>
		<form method="post" action="{url op="recordDecision"}">
			<input type="hidden" name="articleId" value="{$submission->getId()}" />
			<select name="decision" size="1" class="selectMenu"{if not $allowRecommendation} disabled="disabled"{/if}>
				{html_options_translate options=$editorDecisionOptions selected=$lastDecision}
			</select><br/>
			<input type="submit" onclick="return confirm('{translate|escape:"jsparam" key="editor.submissionReview.confirmDecision"}')" name="submit" value="{translate key="editor.article.recordDecision"}" {if not $allowRecommendation}disabled="disabled"{/if} class="btn btn-small" />
			{if not $allowRecommendation}&nbsp;&nbsp;{translate key="editor.article.cannotRecord"}{/if}
		</form>
</p>
<br/>
<p><strong>{translate key="editor.article.decision"}: </strong>
		{foreach from=$submission->getDecisions($round) item=editorDecision key=decisionKey}
			{if $decisionKey neq 0} | {/if}
			{assign var="decision" value=$editorDecision.decision}
			{translate key=$editorDecisionOptions.$decision}&nbsp;&nbsp;{if $editorDecision.dateDecided != 0}{$editorDecision.dateDecided|date_format:$dateFormatShort}<br/>{/if}
		{foreachelse}
			{translate key="common.none"}
		{/foreach}
</p>
<p><strong>{translate key="submission.notifyAuthor"}: </strong>
		{url|assign:"notifyAuthorUrl" op="emailEditorDecisionComment" articleId=$submission->getId()}

		{if $decision == SUBMISSION_EDITOR_DECISION_DECLINE}
			{* The last decision was a decline; notify the user that sending this message will archive the submission. *}
			{translate|escape:"quotes"|assign:"confirmString" key="editor.submissionReview.emailWillArchive"}
			{icon name="mail" url=$notifyAuthorUrl onclick="return confirm('$confirmString')"}
		{else}
			{icon name="mail" url=$notifyAuthorUrl}
		{/if}

		&nbsp;&nbsp;&nbsp;&nbsp;
		{translate key="submission.editorAuthorRecord"}
		{if $submission->getMostRecentEditorDecisionComment()}
			{assign var="comment" value=$submission->getMostRecentEditorDecisionComment()}
			<a href="javascript:openComments('{url op="viewEditorDecisionComments" path=$submission->getId() anchor=$comment->getId()}');" class="icon">{icon name="comment"}</a>&nbsp;&nbsp;{$comment->getDatePosted()|date_format:$dateFormatShort}
		{else}
			<a href="javascript:openComments('{url op="viewEditorDecisionComments" path=$submission->getId()}');" class="icon">{icon name="comment"}</a>{translate key="common.noComments"}
		{/if}	
</p>


<form method="post" action="{url op="editorReview"}" enctype="multipart/form-data">
<input type="hidden" name="articleId" value="{$submission->getId()}" />
{assign var=authorFiles value=$submission->getAuthorFileRevisions($round)}
{assign var=editorFiles value=$submission->getEditorFileRevisions($round)}

{assign var="authorRevisionExists" value=false}
{foreach from=$authorFiles item=authorFile}
	{assign var="authorRevisionExists" value=true}
{/foreach}

{assign var="editorRevisionExists" value=false}
{foreach from=$editorFiles item=editorFile}
	{assign var="editorRevisionExists" value=true}
{/foreach}
{if $reviewFile}
	{assign var="reviewVersionExists" value=1}
{/if}

	{if $lastDecision == SUBMISSION_EDITOR_DECISION_RESUBMIT}
		<p><strong>{translate key="editor.article.resubmitFileForPeerReview"}</strong><br/>
			<input type="submit" name="resubmit" {if !($editorRevisionExists or $authorRevisionExists or $reviewVersionExists)}disabled="disabled" {/if}value="{translate key="form.resubmit"}" class="button" />
		</p>
	{elseif $lastDecision == SUBMISSION_EDITOR_DECISION_ACCEPT}
			{if !($editorRevisionExists or $authorRevisionExists or $reviewVersionExists) or !$submission->getMostRecentEditorDecisionComment()}{assign var=copyeditingUnavailable value=1}{else}{assign var=copyeditingUnavailable value=0}{/if}
			<br/><input type="submit" {if $copyeditingUnavailable}disabled="disabled" {/if}name="setCopyeditFile" value="{translate key="editor.submissionReview.sendToCopyediting"}" class="btn btn-small" />
			{if $copyeditingUnavailable}
				<br/>
				<span class="help-block">{translate key="editor.submissionReview.cannotSendToCopyediting"}</span>
				{/if}
	{/if}

	{if $reviewFile}
		<p><strong>{translate key="submission.reviewVersion"}:</strong>
				{if $lastDecision == SUBMISSION_EDITOR_DECISION_ACCEPT || $lastDecision == SUBMISSION_EDITOR_DECISION_RESUBMIT}
					<label class="checkbox"><input type="radio" name="editorDecisionFile" value="{$reviewFile->getFileId()},{$reviewFile->getRevision()}" /></label>
				{/if}
				<a href="{url op="downloadFile" path=$submission->getId()|to_array:$reviewFile->getFileId():$reviewFile->getRevision()}" class="file descargar_general">{$reviewFile->getFileName()|escape}</a>&nbsp;&nbsp;
				{$reviewFile->getDateModified()|date_format:$dateFormatShort}
				{if $copyeditFile && $copyeditFile->getSourceFileId() == $reviewFile->getFileId()}
					&nbsp;&nbsp;&nbsp;&nbsp;{translate key="submission.sent"}&nbsp;&nbsp;{$copyeditFile->getDateUploaded()|date_format:$dateFormatShort}
				{/if}
		</p>
	{/if}
	{assign var="firstItem" value=true}
	{foreach from=$authorFiles item=authorFile key=key}
			{if $firstItem}
				{assign var="firstItem" value=false}
				<p><strong>{translate key="submission.authorVersion"}: </strong>
			{/if}
				{if $lastDecision == SUBMISSION_EDITOR_DECISION_ACCEPT || $lastDecision == SUBMISSION_EDITOR_DECISION_RESUBMIT}
				<label class="checkbox" style="display:inline;"><input type="radio" name="editorDecisionFile" value="{$authorFile->getFileId()},{$authorFile->getRevision()}" /></label> {/if}
				<a href="{url op="downloadFile" path=$submission->getId()|to_array:$authorFile->getFileId():$authorFile->getRevision()}" class="file descargar_general">{$authorFile->getFileName()|escape}</a>&nbsp;&nbsp;
				{$authorFile->getDateModified()|date_format:$dateFormatShort}
				{if $copyeditFile && $copyeditFile->getSourceFileId() == $authorFile->getFileId()}
					&nbsp;&nbsp;&nbsp;&nbsp;{translate key="submission.sent"}&nbsp;&nbsp;{$copyeditFile->getDateUploaded()|date_format:$dateFormatShort}
				{/if}
			</p>
	{foreachelse}
		<p><strong>{translate key="submission.authorVersion"}: </strong>
			{translate key="common.none"}</td>
		</p>
	{/foreach}
	{assign var="firstItem" value=true}
	{foreach from=$editorFiles item=editorFile key=key}
			{if $firstItem}
				{assign var="firstItem" value=false}
				<p><strong>{translate key="submission.editorVersion"}: </strong>
			{/if}
				{if $lastDecision == SUBMISSION_EDITOR_DECISION_ACCEPT || $lastDecision == SUBMISSION_EDITOR_DECISION_RESUBMIT}
				<input type="radio" name="editorDecisionFile" value="{$editorFile->getFileId()},{$editorFile->getRevision()}" />{/if}
				<a href="{url op="downloadFile" path=$submission->getId()|to_array:$editorFile->getFileId():$editorFile->getRevision()}" class="file descargar_general">{$editorFile->getFileName()|escape}</a>&nbsp;&nbsp;
				{$editorFile->getDateModified()|date_format:$dateFormatShort}&nbsp;&nbsp;&nbsp;&nbsp;
				{if $copyeditFile && $copyeditFile->getSourceFileId() == $editorFile->getFileId()}
					{translate key="submission.sent"}&nbsp;&nbsp;{$copyeditFile->getDateUploaded()|date_format:$dateFormatShort}&nbsp;&nbsp;&nbsp;&nbsp;
				{/if}
				<a href="{url op="deleteArticleFile" path=$submission->getId()|to_array:$editorFile->getFileId():$editorFile->getRevision()}" class="action delete">{translate key="common.delete"}</a>
			</p>
	{foreachelse}
		<p><strong>{translate key="submission.editorVersion"}: </strong>
			{translate key="common.none"}
		</p>
	{/foreach}
	<p>
		<div class="fileupload fileupload-new" data-provides="fileupload">
			<span class="btn btn-file btn-small">
				<span class="fileupload-new">{translate key="plugins.block.navigation.journalContent"}</span>
				<span class="fileupload-exists">{translate key="submission.changeSection"}</span>
				<input type="file" name="upload" class="uploadField" />
			</span>
			<span class="fileupload-preview"></span>
			<a href="#" class="close fileupload-exists" data-dismiss="fileupload" style="float: none">X</a><br/><br/>
			<input type="submit" name="submit" value="{translate key="common.upload"}" class="btn btn-small" />
		</div>		
	</p>
</form>
</div>
{* MODIFICADO OJS V.2.4.2 / 04-2013*}
