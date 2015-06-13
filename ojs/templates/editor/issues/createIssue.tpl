{**
 * templates/editor/issues/createIssue.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Form for creation of an issue
 *
 *}
{strip}
{assign var="pageTitle" value="editor.issues.createIssue"}
{url|assign:"currentUrl" page="editor" op="createIssue"}
{include file="common/header.tpl"}
{/strip}

{include file="common/formErrors.tpl"}

<div id="editor_top_menu">
	<ul class="nav nav-pills">
		<li class="active"><a href="{url op="createIssue"}">{translate key="editor.navigation.createIssue"}</a></li>
		<li><a href="{url op="futureIssues"}">{translate key="editor.navigation.futureIssues"}</a></li>
		<li><a href="{url op="backIssues"}">{translate key="editor.navigation.issueArchive"}</a></li>
	</ul>
</div>
&nbsp;

<form action="#">
{translate key="issue.issue"}: <select name="issue" onchange="if(this.options[this.selectedIndex].value > 0) location.href='{url|escape:"javascript" op="issueToc" path="ISSUE_ID" escape=false}'.replace('ISSUE_ID', this.options[this.selectedIndex].value)" size="1">{html_options options=$issueOptions selected=$issueId}</select>
</form>

<div class="issue_create_form">
<form id="issue" method="post" action="{url op="saveIssue"}" enctype="multipart/form-data">

<div id="issue_identification">
	<div class="arrow_down_box">
		<h3>{translate key="editor.issues.identification"}</h3>
	</div>

{if count($formLocales) > 1}
	<div class="control-group">
		<label class="control-label">{fieldLabel name="formLocale" key="form.formLanguage"}</label>
		<div class="controls">
			{url|assign:"issueUrl" op="createIssue" escape=false}
			{form_language_chooser form="issue" url=$issueUrl}
			<span class="help-block">{translate key="form.formLanguage.description"}</span>
		</div>
	</div>
{/if}
	<div class="control-group">
		<label class="control-label">{fieldLabel name="volume" key="issue.volume"}</label>
		<input type="text" class="input-xlarge" name="volume" id="volume" value="{$volume|escape}" size="5" maxlength="5" class="textField" />
	</div>
	<div class="control-group">
		<label class="control-label">{fieldLabel name="number" key="issue.number"}</label>
		<div class="controls"><input type="text" name="number" id="number" value="{$number|escape}" size="5" maxlength="5" class="textField" /></div>
	</div>
	<div class="control-group">
		<label class="control-label">{fieldLabel name="year" key="issue.year"}</label>
		<div class="controls"><input type="text" name="year" id="year" value="{$year|escape}" size="5" maxlength="4" class="textField" /></div>
	</div>
	<div class="control-group">
		<label class="control-label">{fieldLabel suppressId="true" name="labelFormat" key="editor.issues.issueIdentification"}</label>
		<label class="checkbox"><input type="checkbox" name="showVolume" id="showVolume" value="1"{if $showVolume} checked="checked"{/if} />{translate key="issue.volume"}</label>
		<label class="checkbox"><input type="checkbox" name="showNumber" id="showNumber" value="1"{if $showNumber} checked="checked"{/if} />{translate key="issue.number"}</label>
		<label class="checkbox"><input type="checkbox" name="showYear" id="showYear" value="1"{if $showYear} checked="checked"{/if} />{translate key="issue.year"}</label>
		<label class="checkbox"><input type="checkbox" name="showTitle" id="showTitle" value="1"{if $showTitle} checked="checked"{/if} />{translate key="issue.title"}</label>
	</div>
	{if $enablePublicIssueId}
	<div class="control-group">
		<label class="control-label">{fieldLabel name="publicIssueId" key="editor.issues.publicIssueIdentifier"}</label>
		<div class="controls"><input type="text" name="publicIssueId" id="publicIssueId" value="{$publicIssueId|escape}" size="20" maxlength="255" class="textField" /></div>
	</div>
	{/if}
	<div class="control-group">
		<label class="control-label">{fieldLabel name="title" key="issue.title"}</label>
		<div class="controls"><input type="text" name="title[{$formLocale|escape}]" id="title" value="{$title[$formLocale]|escape}" size="40" maxlength="255" class="textField" /></div>
	</div>
	<div class="control-group">
		<label class="control-label">{fieldLabel name="description" key="editor.issues.description"}</label>
		<div class="controls"><textarea name="description[{$formLocale|escape}]" id="description" cols="40" rows="5" class="textArea">{$description[$formLocale]|escape}</textarea></div>
	</div>

</div>

{if $currentJournal->getSetting('publishingMode') == $smarty.const.PUBLISHING_MODE_SUBSCRIPTION}
<div class="separator"></div>
<div id="issue_access">
	<div class="arrow_down_box">
		<h3>{translate key="editor.issues.access"}</h3>
	</div>
<table width="100%" class="data">
	<tr valign="top">
		<td width="20%" class="label">{fieldLabel name="accessStatus" key="editor.issues.accessStatus"}</td>
		<td width="80%" class="value"><select name="accessStatus" id="accessStatus" class="selectMenu">{html_options options=$accessOptions selected=$accessStatus}</select></td>
	</tr>
	<tr valign="top">
		<td class="label">{fieldLabel name="openAccessDate" key="editor.issues.accessDate"}</td>
		<td class="value">
			<input type="checkbox" id="enableOpenAccessDate" name="enableOpenAccessDate" {if $openAccessDate}checked="checked" {/if}onchange="document.getElementById('issue').openAccessDateMonth.disabled=this.checked?false:true;document.getElementById('issue').openAccessDateDay.disabled=this.checked?false:true;document.getElementById('issue').openAccessDateYear.disabled=this.checked?false:true;" />&nbsp;{fieldLabel name="enableOpenAccessDate" key="editor.issues.enableOpenAccessDate"}<br/>
			{if $openAccessDate}
				{html_select_date prefix=openAccessDate time=$openAccessDate end_year="+20" all_extra="class=\"selectMenu\""}
			{else}
				{html_select_date prefix=openAccessDate time=$openAccessDate end_year="+20" all_extra="class=\"selectMenu\" disabled=\"disabled\""}
			{/if}
		</td>
	</tr>
</table>
</div>
{/if}

<div id="issue_cover">
	<div class="arrow_down_box">
		<h3>{translate key="editor.issues.cover"}</h3>
	</div>
	<div class="control-group">
		<label class="control-label" for="showCoverPage">{translate key="editor.issues.showCoverPage"}</label>
		<div class="controls"><input type="checkbox" name="showCoverPage[{$formLocale|escape}]" id="showCoverPage" value="1" {if $showCoverPage[$formLocale]} checked="checked"{/if} /></div>
	</div>

	<div class="control-group">
		<label class="control-label">{fieldLabel name="coverPage" key="editor.issues.coverPage"}</label>
		<span class="btn btn-file btn-small"><input type="file" name="coverPage" id="coverPage" class="uploadField" />{translate key="plugins.block.navigation.journalContent"}</span><br />{translate key="form.saveToUpload"}<br/>
			{translate key="editor.issues.coverPageInstructions"}
	</div>
	<div class="control-group">
		<label class="control-label">{fieldLabel name="styleFile" key="editor.issues.styleFile"}</label>
		<span class="btn btn-file btn-small"><input type="file" name="styleFile" id="styleFile" class="uploadField" />{translate key="plugins.block.navigation.journalContent"}</span><br />{translate key="form.saveToUpload"}<br />{translate key="editor.issues.uploaded"}:&nbsp;{if $styleFileName}<a href="javascript:openWindow('{$publicFilesDir}/{$styleFileName|escape}');" class="file">{$originalStyleFileName|escape}</a>&nbsp;<a href="{url op="removeStyleFile" path=$issueId}" onclick="return confirm('{translate|escape:"jsparam" key="editor.issues.removeStyleFile"}')">{translate key="editor.issues.remove"}</a>{else}&mdash;{/if}
	</div>
	<div class="control-group">
		<label class="control-label">{fieldLabel name="coverPageDescription" key="editor.issues.coverPageCaption"}</label>
		<div class="controls"><textarea name="coverPageDescription[{$formLocale|escape}]" id="coverPageDescription" cols="40" rows="5" class="textArea">{$coverPageDescription[$formLocale]|escape}</textarea></div>
	</div>
	<div class="control-group">
		<label class="control-label">{fieldLabel name="hideCoverPageArchives" key="editor.issues.coverPageDisplay"}</label>
		<label class="checkbox" for="hideCoverPageArchives"><input type="checkbox" name="hideCoverPageArchives[{$formLocale|escape}]" id="hideCoverPageArchives" value="1" {if $hideCoverPageArchives[$formLocale]} checked="checked"{/if} />{translate key="editor.issues.hideCoverPageArchives"}</label>
		<label class="checkbox" for="hideCoverPageCover"><input type="checkbox" name="hideCoverPageCover[{$formLocale|escape}]" id="hideCoverPageCover" value="1" {if $hideCoverPageCover[$formLocale]} checked="checked"{/if} />{translate key="editor.issues.hideCoverPageCover"}</label>
	</div>

</div>
<div class="save">
	<div class="arrow_down_box">
		<h3>{translate key="common.save"}</h3>
	</div>
	<p><input type="button" value="{translate key="common.cancel"}" onclick="document.location.href='{url op="index" escape=false}'" class="btn btn-danger btn-small" /> <input type="submit" value="{translate key="common.save"}" class="btn btn-small" style="float:right;"/></p>	
</div>	
</form>
</div>
{include file="common/footer.tpl"}
{* MODIFICADO OJS V.2.4.2 / 04-2013*}
