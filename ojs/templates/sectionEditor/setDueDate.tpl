{**
 * templates/sectionEditor/setDueDate.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Form to set the due date for a review.
 *
 *}
{strip}
{assign var="pageTitle" value="submission.dueDate"}
{include file="common/header.tpl"}
{/strip}
<div id="setDueDate">
	<h3>{translate key="editor.article.designateDueDate"}</h3>

	<p>{translate key="editor.article.designateDueDateDescription"}</p>

	<form method="post" action="{url op=$actionHandler path=$articleId|to_array:$reviewId}">
		<p><strong>{translate key="editor.article.todaysDate"}: </strong>{$todaysDate|escape}
		</p>
		
		<p><strong>{translate key="editor.article.requestedByDate"}: </strong><br/>
			<input type="text" size="11" maxlength="10" name="dueDate" value="{if $dueDate}{$dueDate|date_format:"%Y-%m-%d"}{/if}" class="textField" onfocus="this.form.numWeeks.value=''" />
			<br/><span class="instruct">{translate key="editor.article.dueDateFormat"}</span>
		</p>
		
		<p><strong>{translate key="editor.article.numberOfWeeks"}: </strong><br/>
				<input type="text" name="numWeeks" value="{if not $dueDate}{$numWeeksPerReview|escape}{/if}" size="3" maxlength="2" class="textField" onfocus="this.form.dueDate.value=''" />		
		</p>
		
		<hr/>
		<p style="text-align:right;"><input type="button" class="btn btn-danger" onclick="history.go(-1)" value="{translate key="common.cancel"}" /> <input type="submit" value="{translate key="common.continue"}" class="btn" /></p>
	</form>
</div>
{include file="common/footer.tpl"}
{* MODIFICADO OJS V.2.4.2 / 04-2013*}
