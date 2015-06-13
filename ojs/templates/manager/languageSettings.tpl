{**
 * templates/manager/languageSettings.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Form to edit journal language settings.
 *
 *}
{strip}
{assign var="pageTitle" value="common.languages"}
{include file="common/header.tpl"}
{/strip}

<p><span class="instruct">{translate key="manager.languages.languageInstructions"}</span></p>

{include file="common/formErrors.tpl"}

{if count($availableLocales) > 1}
<form method="post" action="{url op="saveLanguageSettings"}">


<p><strong>{fieldLabel name="primaryLocale" required="true" key="locale.primary"}</strong></p>
		<select id="primaryLocale" name="primaryLocale" size="1" class="selectMenu">
			{html_options options=$availableLocales selected=$primaryLocale}
		</select>

</p>
<p>{translate key="manager.languages.primaryLocaleInstructions"}</p>

<p><strong>{fieldLabel suppressId="true" name="supportedLocales" key="locale.supported"}</strong></p>
	{foreach from=$availableLocales key=localeKey item=localeName}
			<p>{$localeName|escape}
			<label class="checkbox"><input type="checkbox" name="supportedLocales[]" value="{$localeKey|escape}"{if in_array($localeKey, $supportedLocales)} checked="checked"{/if}/>
				{translate key="manager.language.ui"}</label>
			<label class="checkbox"><input type="checkbox" name="supportedSubmissionLocales[]" value="{$localeKey|escape}"{if in_array($localeKey, $supportedSubmissionLocales)} checked="checked"{/if}/>
			{translate key="manager.language.submissions"}</label>
			<label class="checkbox"><input type="checkbox" name="supportedFormLocales[]" value="{$localeKey|escape}"{if in_array($localeKey, $supportedFormLocales)} checked="checked"{/if}/>
			{translate key="manager.language.forms"}</label>
			<a href="{url op="reloadLocalizedDefaultSettings" localeToLoad=$localeKey}" onclick="return confirm('{translate|escape:"jsparam" key="manager.language.confirmDefaultSettingsOverwrite"}')" class="action">{translate key="manager.language.reloadLocalizedDefaultSettings"}</a>
		<br/>
	{/foreach}
</p>
<p>{translate key="manager.languages.supportedLocalesInstructions"}</span></td>
</p>
<br>
<p><input type="button" value="{translate key="common.cancel"}" class="btn btn-danger btn-small" onclick="document.location.href='{url page="manager"}'" /> <input type="submit" value="{translate key="common.save"}" class="btn btn-small" /></p>

<p>{translate key="common.requiredField"}</p>

</form>

{else}
<div class="separator"></div>
<p><span class="instruct">{translate key="manager.languages.noneAvailable"}</span></p>
{/if}
{* MODIFICADO OJS V.2.4.2 / 04-2013*}
{include file="common/footer.tpl"}

