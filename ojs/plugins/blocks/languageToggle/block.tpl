{**
 * plugins/blocks/languageToggle/block.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Common site sidebar menu -- language toggle.
 *
 *}
{if $enableLanguageToggle}
<div class="block_nav sidebarLanguageToggle" style="display:none;">
	<div class="blockTitle">{translate key="common.language"}</div>
	{foreach from=$languageToggleLocales key=langkey item=langname}
      {if $langkey == $currentLocale}
         <a class="icon" href="#"><img src="{$baseUrl}/plugins/blocks/languageToggle/locale/{$langkey}/flag.png" alt="{$langname}" title="{$langname}" width="18" height="12" /></a>
      {else}
         <a class="icon" href={if $languageToggleNoUser}'{$currentUrl|escape}{if strstr($currentUrl, '?')}&{else}?{/if}setLocale={$langkey}'{else}'{url page="user" op="setLocale" path=$langkey source=$smarty.server.REQUEST_URI escape=false}'{/if}>
            <img src="{$baseUrl}/plugins/blocks/languageToggle/locale/{$langkey}/flag.png" alt="{$langname}" title="{$langname}" width="18" height="12" />
         </a>
      {/if}
   {/foreach}
</div>
{/if}
{* MODIFICADO OJS V.2.3.7 / 04-2012*}