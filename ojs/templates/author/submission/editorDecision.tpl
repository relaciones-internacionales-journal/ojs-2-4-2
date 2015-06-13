{**
 * templates/author/submission/editorDecision.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the author's editor decision table.
 *
 *}
<div id="editorDecision">
<h3>{translate key="submission.editorDecision"}</h3>

{assign var=authorFiles value=$submission->getAuthorFileRevisions($submission->getCurrentRound())}
{assign var=editorFiles value=$submission->getEditorFileRevisions($submission->getCurrentRound())}

<p><strong>{translate key="editor.article.decision"}: </strong>	
			{if $lastEditorDecision}
				{assign var="decision" value=$lastEditorDecision.decision}
				{translate key=$editorDecisionOptions.$decision}{if $lastEditorDecision.dateDecided != 0} {$lastEditorDecision.dateDecided|date_format:$dateFormatShort}{/if}
			{else}
				&mdash;
			{/if}
</p>
<p><strong>{translate key="submission.notifyEditor"}: </strong>	
			{url|assign:"notifyAuthorUrl" op="emailEditorDecisionComment" articleId=$submission->getId()}
			{icon name="mail" url=$notifyAuthorUrl}
			&nbsp;&nbsp;&nbsp;&nbsp;
			{translate key="submission.editorAuthorRecord"}
			{if $submission->getMostRecentEditorDecisionComment()}
				{assign var="comment" value=$submission->getMostRecentEditorDecisionComment()}
				<a href="javascript:openComments('{url op="viewEditorDecisionComments" path=$submission->getId() anchor=$comment->getId()}');" class="icon">{icon name="comment"}</a> {$comment->getDatePosted()|date_format:$dateFormatShort}
			{else}
				<a href="javascript:openComments('{url op="viewEditorDecisionComments" path=$submission->getId()}');" class="icon">{icon name="comment"}</a>{translate key="common.noComments"}
			{/if}
</p>
<p><strong>{translate key="submission.editorVersion"}: </strong>
			{foreach from=$editorFiles item=editorFile key=key}
				<a href="{url op="downloadFile" path=$submission->getId()|to_array:$editorFile->getFileId():$editorFile->getRevision()}" class="file descargar_general">{$editorFile->getFileName()|escape}</a>&nbsp;&nbsp;{$editorFile->getDateModified()|date_format:$dateFormatShort}<br />
			{foreachelse}
				{translate key="common.none"}
			{/foreach}
</p>
<p><strong>{translate key="submission.authorVersion"}: </strong>
			{foreach from=$authorFiles item=authorFile key=key}
				<a href="{url op="downloadFile" path=$submission->getId()|to_array:$authorFile->getFileId():$authorFile->getRevision()}" class="file descargar_general">{$authorFile->getFileName()|escape}</a>&nbsp;&nbsp;{$authorFile->getDateModified()|date_format:$dateFormatShort}&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="{url op="deleteArticleFile" path=$submission->getId()|to_array:$authorFile->getFileId():$authorFile->getRevision()}" class="action delete">{translate key="common.delete"}</a><br />
			{foreachelse}
				{translate key="common.none"}
			{/foreach}
</p>
<p><strong>{translate key="author.article.uploadAuthorVersion"}: </strong><br/>
			<form method="post" action="{url op="uploadRevisedVersion"}" enctype="multipart/form-data">
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
			</form>
</p>
</div>
{* MODIFICADO OJS V.2.4.2 / 04-2013*}