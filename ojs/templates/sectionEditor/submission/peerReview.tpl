{**
 * templates/sectionEditor/submission/peerReview.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the peer review table.
 *
 *}
<div id="submission_management_review">
	<div class="submission_management_reviewdetails">
	<h3>{translate key="article.submission"}</h3>
	<p><strong>{translate key="article.authors"}</strong><br/>
		{url|assign:"url" page="user" op="email" redirectUrl=$currentUrl to=$submission->getAuthorEmails() subject=$submission->getLocalizedTitle() articleId=$submission->getId()}
		{$submission->getAuthorString()|escape} {icon name="mail" url=$url}		
	</p>
	
	<p><strong>{translate key="article.title"}</strong><br/>
		{$submission->getLocalizedTitle()|strip_unsafe_html}
	</p>
	
	<p><strong>{translate key="section.section"}</strong><br/>
		{$submission->getSectionTitle()|escape}
	</p>
	<p><strong>{translate key="user.role.editor"}</strong><br/>		
			{assign var=editAssignments value=$submission->getEditAssignments()}
			{foreach from=$editAssignments item=editAssignment}
				{assign var=emailString value=$editAssignment->getEditorFullName()|concat:" <":$editAssignment->getEditorEmail():">"}
				{url|assign:"url" page="user" op="email" redirectUrl=$currentUrl to=$emailString|to_array subject=$submission->getLocalizedTitle|strip_tags articleId=$submission->getId()}
				{$editAssignment->getEditorFullName()|escape} {icon name="mail" url=$url}
				{if !$editAssignment->getCanEdit() || !$editAssignment->getCanReview()}
					{if $editAssignment->getCanEdit()}
						({translate key="submission.editing"})
					{else}
						({translate key="submission.review"})
					{/if}
				{/if}
				<br/>
			{foreachelse}
				{translate key="common.noneAssigned"}
			{/foreach}
	</p
	<p><strong>{translate key="submission.reviewVersion"}</strong><br/>	
		{if $reviewFile}
			<a href="{url op="downloadFile" path=$submission->getId()|to_array:$reviewFile->getFileId():$reviewFile->getRevision()}" class="file descargar_general">{$reviewFile->getFileName()|escape}</a>
			{$reviewFile->getDateModified()|date_format:$dateFormatShort}<br/>{if $currentJournal->getSetting('showEnsuringLink')}<a class="action info_general" href="javascript:openHelp('{get_help_id key="editorial.sectionEditorsRole.review.blindPeerReview" url="true"}')">{translate key="reviewer.article.ensuringBlindReview"}</a>{/if}	
		{else}
			{translate key="common.none"}
		{/if}
	</p>
	<hr/>
	<p><strong>
			<form method="post" action="{url op="uploadReviewVersion"}" enctype="multipart/form-data">
				{translate key="editor.article.uploadReviewVersion"}</strong><br/><br/>
				<input type="hidden" name="articleId" value="{$submission->getId()}" />
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
				{*<span class="btn btn-file><input type="file" name="upload" class="uploadField" />{translate key="plugins.block.navigation.journalContent"}</span>
				<input type="submit" name="submit" value="{translate key="common.upload"}" class="btn btn-medium" />*}
			</form>
	</p>
	<hr/>
	{foreach from=$suppFiles item=suppFile}
			{if !$notFirstSuppFile}
				<p><strong>{translate key="article.suppFilesAbbrev"}</strong><br/>
				{assign var=notFirstSuppFile value=1}
				</p>
			{/if}			
				<form method="post" action="{url op="setSuppFileVisibility"}">
				<input type="hidden" name="articleId" value="{$submission->getId()}" />
				<input type="hidden" name="fileId" value="{$suppFile->getId()}" />
				<a href="{url op="downloadFile" path=$submission->getId()|to_array:$suppFile->getFileId():$suppFile->getRevision()}" class="file descargar_general">{$suppFile->getFileName()|escape}</a>&nbsp;&nbsp;
				{$suppFile->getDateModified()|date_format:$dateFormatShort}<br/>
				<label class="checkbox" for="show"><input type="checkbox" name="show" id="show" value="1"{if $suppFile->getShowReviewers()==1} checked="checked"{/if}/>
				{translate key="editor.article.showSuppFile"}</label>
				<br/><input type="submit" name="submit" value="{translate key="common.record"}" class="btn btn-small" />
				</form>		
		{foreachelse}
		<p><strong>{translate key="article.suppFilesAbbrev"}</strong><br/>
		{translate key="common.none"}
		</p>
	{/foreach}
	</div>
</div>

<div id="peerReview">
	<h3>{translate key="submission.peerReview"}</h3>
	<table class="data_alt" width="100%">
		<tr id="reviewersHeader" valign="middle">
			<td width="14%" colspan="2"><h4>{translate key="submission.round" round=$round}</h4></td>
			<td width="64%" class="nowrap">
				<a href="{url op="selectReviewer" path=$submission->getId()}" class="action">{translate key="editor.article.selectReviewer"}</a>&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="{url op="submissionRegrets" path=$submission->getId()}" class="action">{translate|escape key="sectionEditor.regrets.link"}</a>
			</td>
		</tr>
	</table>

{assign var="start" value="A"|ord}
{foreach from=$reviewAssignments item=reviewAssignment key=reviewKey}
{assign var="reviewId" value=$reviewAssignment->getId()}
{if not $reviewAssignment->getCancelled() and not $reviewAssignment->getDeclined()}
	{assign var="reviewIndex" value=$reviewIndexes[$reviewId]}
	<hr/><h4>{translate key="user.role.reviewer"} {$reviewIndex+$start|chr}:
		{$reviewAssignment->getReviewerFullName()|escape}
				{if not $reviewAssignment->getDateNotified()}
					&nbsp;&nbsp;<a href="{url op="clearReview" path=$submission->getId()|to_array:$reviewAssignment->getId()}" class="action delete">{translate key="editor.article.clearReview"}</a>
				{elseif $reviewAssignment->getDeclined() or not $reviewAssignment->getDateCompleted()}
					&nbsp;&nbsp;<a href="{url op="cancelReview" articleId=$submission->getId() reviewId=$reviewAssignment->getId()}" class="action delete">{translate key="editor.article.cancelReview"}</a>
				{/if}
		</h4>

	<br/><p><strong>{translate key="submission.reviewForm"}: </strong><br/>
		{if $reviewAssignment->getReviewFormId()}
			{assign var="reviewFormId" value=$reviewAssignment->getReviewFormId()}
			{$reviewFormTitles[$reviewFormId]}
		{else}
			{translate key="manager.reviewForms.noneChosen"}
		{/if}
		{if !$reviewAssignment->getDateCompleted()}
			<br/><a class="action buscar_general" href="{url op="selectReviewForm" path=$submission->getId()|to_array:$reviewAssignment->getId()}"{if $reviewFormResponses[$reviewId]} onclick="return confirm('{translate|escape:"jsparam" key="editor.article.confirmChangeReviewForm"}')"{/if}>{translate key="editor.article.selectReviewForm"}</a>{if $reviewAssignment->getReviewFormId()}
			<br/><a class="action delete" href="{url op="clearReviewForm" path=$submission->getId()|to_array:$reviewAssignment->getId()}"{if $reviewFormResponses[$reviewId]} onclick="return confirm('{translate|escape:"jsparam" key="editor.article.confirmChangeReviewForm"}')"{/if}>{translate key="editor.article.clearReviewForm"}</a>{/if}
		{/if}
	</p>	
	<ul class="plain" style="margin-top:5px;">
		<li><strong>{translate key="submission.request"}: </strong>
			{url|assign:"reviewUrl" op="notifyReviewer" reviewId=$reviewAssignment->getId() articleId=$submission->getId()}
			{if $reviewAssignment->getDateNotified()}
				{$reviewAssignment->getDateNotified()|date_format:$dateFormatShort}
				{if !$reviewAssignment->getDateCompleted()}
					{icon name="mail" url=$reviewUrl}
				{/if}
			{elseif $reviewAssignment->getReviewFileId()}
				{icon name="mail" url=$reviewUrl}
			{else}
				{icon name="mail" disabled="disabled" url=$reviewUrl}
				{assign var=needsReviewFileNote value=1}
			{/if}
		</li>
		<li><strong>{translate key="submission.underway"}: </strong>
			{$reviewAssignment->getDateConfirmed()|date_format:$dateFormatShort|default:"&mdash;"}
		</li>
		<li><strong>{translate key="submission.due"}: </strong>
			{if $reviewAssignment->getDeclined()}
				{translate key="sectionEditor.regrets"}
			{else}
				<a href="{url op="setDueDate" path=$reviewAssignment->getSubmissionId()|to_array:$reviewAssignment->getId()}">{if $reviewAssignment->getDateDue()}{$reviewAssignment->getDateDue()|date_format:$dateFormatShort}{else}&mdash;{/if}</a>
			{/if}
		</li>
		<li><strong>{translate key="submission.acknowledge"}: </strong>
			{url|assign:"thankUrl" op="thankReviewer" reviewId=$reviewAssignment->getId() articleId=$submission->getId()}
			{if $reviewAssignment->getDateAcknowledged()}
				{$reviewAssignment->getDateAcknowledged()|date_format:$dateFormatShort}
			{elseif $reviewAssignment->getDateCompleted()}
				{icon name="mail" url=$thankUrl}
			{else}
				{icon name="mail" disabled="disabled" url=$thankUrl}
			{/if}
		</li>
	</ul>

	{if $reviewAssignment->getDateConfirmed() && !$reviewAssignment->getDeclined()}
		<p><strong>{translate key="reviewer.article.recommendation"}: </strong><br/>
			{if $reviewAssignment->getRecommendation() !== null && $reviewAssignment->getRecommendation() !== ''}
				{assign var="recommendation" value=$reviewAssignment->getRecommendation()}
				{translate key=$reviewerRecommendationOptions.$recommendation}
				&nbsp;&nbsp;{$reviewAssignment->getDateCompleted()|date_format:$dateFormatShort}
			{else}
				{translate key="common.none"}&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="{url op="remindReviewer" articleId=$submission->getId() reviewId=$reviewAssignment->getId()}" class="action">{translate key="reviewer.article.sendReminder"}</a>
				{if $reviewAssignment->getDateReminded()}
					&nbsp;&nbsp;{$reviewAssignment->getDateReminded()|date_format:$dateFormatShort}
					{if $reviewAssignment->getReminderWasAutomatic()}
						&nbsp;&nbsp;{translate key="reviewer.article.automatic"}
					{/if}
				{/if}
			{/if}
		</p>
		{if $currentJournal->getSetting('requireReviewerCompetingInterests')}
			<p><strong>{translate key="reviewer.competingInterests"}: </strong><br/>
				{$reviewAssignment->getCompetingInterests()|strip_unsafe_html|nl2br|default:"&mdash;"}
			</p>
		{/if}{* requireReviewerCompetingInterests *}
		{if $reviewFormResponses[$reviewId]}
			<p><strong>{translate key="submission.reviewFormResponse"}: </strong><br/>
				<a href="javascript:openComments('{url op="viewReviewFormResponse" path=$submission->getId()|to_array:$reviewAssignment->getId()}');" class="icon documento"></a>
			</p>
		{/if}
		{if !$reviewAssignment->getReviewFormId() || $reviewAssignment->getMostRecentPeerReviewComment()}{* Only display comments link if a comment is entered or this is a non-review form review *}
			<p><strong>{translate key="submission.review"}: </strong><br/>
				{if $reviewAssignment->getMostRecentPeerReviewComment()}
					{assign var="comment" value=$reviewAssignment->getMostRecentPeerReviewComment()}
					<a href="javascript:openComments('{url op="viewPeerReviewComments" path=$submission->getId()|to_array:$reviewAssignment->getId() anchor=$comment->getId()}');" class="icon">{icon name="comment"}</a>&nbsp;&nbsp;{$comment->getDatePosted()|date_format:$dateFormatShort}
				{else}
					<a href="javascript:openComments('{url op="viewPeerReviewComments" path=$submission->getId()|to_array:$reviewAssignment->getId()}');" class="icon">{icon name="comment"}</a>&nbsp;&nbsp;{translate key="submission.comments.noComments"}
				{/if}
			</p>
		{/if}
		<p><strong>{translate key="reviewer.article.uploadedFile"}: </strong><br/>
			{foreach from=$reviewAssignment->getReviewerFileRevisions() item=reviewerFile key=key}
					<form id="authorView{$reviewAssignment->getId()}" method="post" action="{url op="makeReviewerFileViewable"}">
						<a href="{url op="downloadFile" path=$submission->getId()|to_array:$reviewerFile->getFileId():$reviewerFile->getRevision()}" class="file">{$reviewerFile->getFileName()|escape}</a>&nbsp;&nbsp;{$reviewerFile->getDateModified()|date_format:$dateFormatShort}
						<input type="hidden" name="reviewId" value="{$reviewAssignment->getId()}" />
						<input type="hidden" name="articleId" value="{$submission->getId()}" />
						<input type="hidden" name="fileId" value="{$reviewerFile->getFileId()}" />
						<input type="hidden" name="revision" value="{$reviewerFile->getRevision()}" />
						<br/>
						<label class="checkbox"><input type="checkbox" name="viewable" value="1"{if $reviewerFile->getViewable()} checked="checked"{/if} />{translate key="editor.article.showAuthor"}</label><br/>
						<input type="submit" value="{translate key="common.record"}" class="btn btn-small" />
					</form>
			{foreachelse}			
				{translate key="common.none"}
			{/foreach}
		</p>
	{/if}

	{if (($reviewAssignment->getRecommendation() === null || $reviewAssignment->getRecommendation() === '') || !$reviewAssignment->getDateConfirmed()) && $reviewAssignment->getDateNotified() && !$reviewAssignment->getDeclined()}
		<p><strong>{translate key="reviewer.article.editorToEnter"}: </strong><br/>
				{if !$reviewAssignment->getDateConfirmed()}
					<a href="{url op="confirmReviewForReviewer" path=$submission->getId()|to_array:$reviewAssignment->getId() accept=1}" class="action acceptar">{translate key="reviewer.article.canDoReview"}</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="{url op="confirmReviewForReviewer" path=$submission->getId()|to_array:$reviewAssignment->getId() accept=0}" class="action delete">{translate key="reviewer.article.cannotDoReview"}</a><br />
				{/if}
				<form method="post" action="{url op="uploadReviewForReviewer"}" enctype="multipart/form-data">
					{translate key="editor.article.uploadReviewForReviewer"}<br/><br/>
					<input type="hidden" name="articleId" value="{$submission->getId()}" />
					<input type="hidden" name="reviewId" value="{$reviewAssignment->getId()}"/>
					
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

				</form>
				{if $reviewAssignment->getDateConfirmed() && !$reviewAssignment->getDeclined()}
					<br/><a class="action crear_general" href="{url op="enterReviewerRecommendation" articleId=$submission->getId() reviewId=$reviewAssignment->getId()}">{translate key="editor.article.recommendation"}</a>
				{/if}
		</p>
	{/if}

	{if $reviewAssignment->getDateNotified() && !$reviewAssignment->getDeclined() && $rateReviewerOnQuality}
		<p><strong>{translate key="editor.article.rateReviewer"}</strong><br/>
			<form method="post" action="{url op="rateReviewer"}">
				<input type="hidden" name="reviewId" value="{$reviewAssignment->getId()}" />
				<input type="hidden" name="articleId" value="{$submission->getId()}" />
				<select name="quality" size="1" class="selectMenu">
					{html_options_translate options=$reviewerRatingOptions selected=$reviewAssignment->getQuality()}
				</select> <br/>
				<input type="submit" value="{translate key="common.record"}" class="btn btn-small" />
				{if $reviewAssignment->getDateRated()}
					&nbsp;&nbsp;{$reviewAssignment->getDateRated()|date_format:$dateFormatShort}
				{/if}
			</form>
		</p>
	{/if}
	{if $needsReviewFileNote}
		<p><strong>{translate key="submission.review.mustUploadFileForReview"}</strong>
		</p>
	{/if}
{/if}
{/foreach}
</div>
{* MODIFICADO OJS V.2.4.2 / 04-2013*}
