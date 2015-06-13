{**
 * templates/editor/notifyUsers.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Editor's "Notify Users" email template form
 *
 *}
{strip}
{assign var="pageTitle" value="email.compose"}
{assign var="pageCrumbTitle" value="email.email"}
{include file="common/header.tpl"}
{/strip}

<div id="notifyUsers">
<form method="post" action="{$formActionUrl}">
<input type="hidden" name="continued" value="1"/>
{if $hiddenFormParams}
	{foreach from=$hiddenFormParams item=hiddenFormParam key=key}
		<input type="hidden" name="{$key|escape}" value="{$hiddenFormParam|escape}" />
	{/foreach}
{/if}

{include file="common/formErrors.tpl"}

{foreach from=$errorMessages item=message}
	{if !$notFirstMessage}
		{assign var=notFirstMessage value=1}
		<h4>{translate key="form.errorsOccurred"}</h4>
		<ul class="plain">
	{/if}
	{if $message.type == MAIL_ERROR_INVALID_EMAIL}
		{translate|assign:"message" key="email.invalid" email=$message.address}
		<li>{$message|escape}</li>
	{/if}
{/foreach}

{if $notFirstMessage}
	</ul>
	<br/>
{/if}

<div id="recipients">
<div class="arrow_down_box">
<h3>{translate key="email.recipients"}</h3>
</div>

<label class="radio" for="allUsers"><input type="radio" id="allUsers" name="whichUsers" value="allUsers"/>
	{translate key="editor.notifyUsers.allUsers" count=$allUsersCount|default:0}
</label>

<label class="radio"for="allReaders"><input type="radio" id="allReaders" name="whichUsers" value="allReaders"/>
	{translate key="editor.notifyUsers.allReaders" count=$allReadersCount|default:0}
</label>

<label class="radio" for="allAuthors"><input type="radio" id="allAuthors" name="whichUsers" value="allAuthors"/>
	{translate key="editor.notifyUsers.allAuthors" count=$allAuthorsCount|default:0}
</label>

{if $currentJournal->getSetting('publishingMode') == $smarty.const.PUBLISHING_MODE_SUBSCRIPTION}
<label class="checkbox" for="allIndividualSubscribers"><input type="radio" id="allIndividualSubscribers" name="whichUsers" value="allIndividualSubscribers"/>
	{translate key="editor.notifyUsers.allIndividualSubscribers" count=$allIndividualSubscribersCount|default:0}
</label>

<label class="checkbox" for="allInstitutionalSubscribers"><input type="radio" id="allInstitutionalSubscribers" name="whichUsers" value="allInstitutionalSubscribers"/>
	{translate key="editor.notifyUsers.allInstitutionalSubscribers" count=$allInstitutionalSubscribersCount|default:0}
</label>

{/if}{* publishingMode is PUBLISHING_MODE_SUBSCRIPTION *}
{if $senderEmail}
<label class="checkbox"> <input type="checkbox" name="ccSelf" />
			{translate key="email.bccSender" address=$senderEmail|escape}
</label>
{/if}

</div>{* recipients *}

<div id="issue">
<div class="arrow_down_box">
<h3>{translate key="issue.issue"}</h3>
</div>

<label class="checkbox"><input type="checkbox" name="includeToc" id="includeToc" value="1"/>
		{translate key="editor.notifyUsers.includeToc"}
</label>
<br/>
<select name="issue" id="issue" >
	{iterate from=issues item=issue}
		<option {if $issue->getCurrent()}checked {/if}value="{$issue->getId()}">{$issue->getIssueIdentification()|strip_tags|truncate:40:"..."|escape}</option>
	{/iterate}
</select>

</div>

<div id="email" style="float:left;">
<div class="arrow_down_box">
<h3>{translate key="email.email"}</h3>
</div>
<table id="email" class="data_alt" width="100%">
<tr valign="top">
	<td class="label">{translate key="email.from"}</td>
	<td class="value"><input type="text" id="subject" name="subject" value="{$from|escape}" size="60" maxlength="120" class="textField input-xxlarge" /></td>
</tr>
<tr valign="top">
	<td width="20%" class="label">{fieldLabel name="subject" key="email.subject"}</td>
	<td width="80%" class="value"><input type="text" id="subject" name="subject" value="{$subject|escape}" size="60" maxlength="120" class="textField input-xxlarge" /></td>
</tr>
<tr valign="top">
	<td class="label">{fieldLabel name="body" key="email.body"}</td>
	<td class="value"><textarea name="body" cols="60" rows="15" class="textArea input-xxlarge">{$body|escape}</textarea></td>
</tr>
</table>
<div id="separator" style="clear:both; margin-top:20px;"><hr/></div>
<p style="float:right;"><input type="button" value="{translate key="common.cancel"}" class="btn btn-danger btn-small" onclick="history.go(-1)" /> <input name="send" type="submit" value="{translate key="email.send"}" class="btn btn-small" /></p>
</div>
</form>
</div>
{include file="common/footer.tpl"}
{* MODIFICADO OJS V.2.4.2 / 04-2013*}
