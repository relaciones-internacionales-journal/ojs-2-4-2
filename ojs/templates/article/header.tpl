{**
 * templates/article/header.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Article View -- Header component.
 *}
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html>
<head>
	<title>{$article->getLocalizedTitle()|strip_tags|truncate:60:"...":true|escape} | {$article->getFirstAuthor(true)|truncate:40:"...":true|escape}</title>
	<!-- Mobile viewport optimized -->
	<meta name="viewport" content="width=device-width,initial-scale=1">
	<meta http-equiv="Content-Type" content="text/html; charset={$defaultCharset|escape}" />
	<meta http-equiv="content-language" content="{$currentLocale}">
	<meta name="description" content="{$article->getLocalizedTitle()|strip_tags|truncate:160:"...":true|escape}" />
	{if $article->getLocalizedSubject()}
		<meta name="keywords" content="{$article->getLocalizedSubject()|escape}" />
	{/if}

	{if $displayFavicon}<link rel="icon" href="{$faviconDir}/{$displayFavicon.uploadName|escape:"url"}" type="{$displayFavicon.mimeType|escape}" />{/if}

	{include file="article/dublincore.tpl"}
	{include file="article/googlescholar.tpl"}
	{call_hook name="Templates::Article::Header::Metadata"}

	<link rel="publisher" href="https://plus.google.com">

	{*<link rel="stylesheet" href="{$baseUrl}/lib/pkp/styles/pkp.css" type="text/css" />
	<link rel="stylesheet" href="{$baseUrl}/lib/pkp/styles/common.css" type="text/css" />
	<link rel="stylesheet" href="{$baseUrl}/styles/common.css" type="text/css" />
	<link rel="stylesheet" href="{$baseUrl}/styles/compiled.css" type="text/css" />
	<link rel="stylesheet" href="{$baseUrl}/styles/articleView.css" type="text/css" />
	{if $journalRt && $journalRt->getEnabled()}
		<link rel="stylesheet" href="{$baseUrl}/lib/pkp/styles/rtEmbedded.css" type="text/css" />
	{/if}*}

	{*{call_hook|assign:"leftSidebarCode" name="Templates::Common::LeftSidebar"}
	{call_hook|assign:"rightSidebarCode" name="Templates::Common::RightSidebar"}
	{if $leftSidebarCode || $rightSidebarCode}<link rel="stylesheet" href="{$baseUrl}/styles/sidebar.css" type="text/css" />{/if}
	{if $leftSidebarCode}<link rel="stylesheet" href="{$baseUrl}/styles/leftSidebar.css" type="text/css" />{/if}
	{if $rightSidebarCode}<link rel="stylesheet" href="{$baseUrl}/styles/rightSidebar.css" type="text/css" />{/if}
	{if $leftSidebarCode && $rightSidebarCode}<link rel="stylesheet" href="{$baseUrl}/styles/bothSidebars.css" type="text/css" />{/if}

	{foreach from=$stylesheets item=cssUrl}
		<link rel="stylesheet" href="{$cssUrl}" type="text/css" />
	{/foreach}*}
	{call_hook|assign:"leftSidebarCode" name="Templates::Common::LeftSidebar"}
	{call_hook|assign:"rightSidebarCode" name="Templates::Common::RightSidebar"}

	{if $rightSidebarCode}<link rel="stylesheet" href="{$baseUrl}/styles/rightSidebar.css" type="text/css" />{/if}
	{if $leftSidebarCode && $rightSidebarCode}<link rel="stylesheet" href="{$baseUrl}/styles/bothSidebars.css" type="text/css" />{/if}

	{foreach from=$stylesheets item=cssUrl}
		{*<link rel="stylesheet" href="{$cssUrl}" type="text/css" />*}
	{/foreach}
	
	<!-- Google Fonts -->
	<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto+Condensed:400,700,300" type="text/css" />
	<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:300,600,700" type="text/css" />
	<link href='http://fonts.googleapis.com/css?family=Crimson+Text:400,700,600' rel='stylesheet' type='text/css'>

	<link rel="stylesheet" href="http://www.relacionesinternacionales.info/min/g=css" type="text/css" />
	<!-- CSS styles -->	
	{php} 
		if(!empty($_COOKIE['style'])) $style = $_COOKIE['style'];
		else $style = 'custom';
	{/php}
	<link id="stylesheet" type="text/css" href="{$baseUrl}/styles/{php}echo $style{/php}.css" rel="stylesheet" />
	<!-- JS -->
	<script type="text/javascript" src="http://www.relacionesinternacionales.info/min/g=js"></script>
	{*<script type="text/javascript" src="{$baseUrl}/js/jquery.js"></script>
	<script type="text/javascript" src="{$baseUrl}/js/styleswitcher.jquery.js"></script>*}

	<!-- Base Jquery -->
	{if $allowCDN}<script type="text/javascript" src="http://www.google.com/jsapi"></script>
	<script type="text/javascript">{literal}
		// Provide a local fallback if the CDN cannot be reached
		if (typeof google == 'undefined') {
			document.write(unescape("%3Cscript src='{/literal}{$baseUrl}{literal}/lib/pkp/js/lib/jquery/jquery.min.js' type='text/javascript'%3E%3C/script%3E"));
			document.write(unescape("%3Cscript src='{/literal}{$baseUrl}{literal}/lib/pkp/js/lib/jquery/plugins/jqueryUi.min.js' type='text/javascript'%3E%3C/script%3E"));
		} else {
			google.load("jquery", "{/literal}{$smarty.const.CDN_JQUERY_VERSION}{literal}");
			google.load("jqueryui", "{/literal}{$smarty.const.CDN_JQUERY_UI_VERSION}{literal}");
		}
	{/literal}</script>
	{else}
	<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/jquery/jquery.min.js"></script>
	<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/jquery/plugins/jqueryUi.min.js"></script>
	{/if}

	{*<script type="text/javascript">{literal}
		$(function(){
			fontSize("#sizer", "body", 9, 16, 32, "{/literal}{$basePath|escape:"javascript"}{literal}"); // Initialize the font sizer
		});
	{/literal}</script>*}

	<!-- Compiled scripts -->
	{*{if $useMinifiedJavaScript}*}
		<script type="text/javascript" src="{$baseUrl}/js/pkp.min.js"></script>
	{*{else}
		{include file="common/minifiedScripts.tpl"}
	{/if}*}
	
	<!-- additionalHeadData -->
	{$additionalHeadData}
	
	<!-- AddThis Button BEGIN -->
	<script type="text/javascript">var addthis_config = {"data_track_clickback":true};</script>
	<script type="text/javascript" src="http://s7.addthis.com/js/250/addthis_widget.js#pubid=ra-4daff76407fac526"></script>
	<!-- AddThis Button END -->
	
	<!-- Google Analytics BEGIN -->
	<script type="text/javascript">
	  var _gaq = _gaq || [];
	  _gaq.push(['_setAccount', '']);
	  _gaq.push(['_trackPageview']);
	  	  (function() {
		var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
		ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
		var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
	  })();
	</script>
	<!-- Google Analytics END -->
</head>
<body>

<div id="container">

<div id="header">
		<div id="header_container">				
			<div class="headerTitle" itemscope itemtype="http://schema.org/Organization">
				<h1 itemprop="name"><a href="{$baseUrl}/index.html" itemprop="url">Relaciones Internacionales</a></h1>
				<meta itemprop="logo" content="{$baseUrl}/templates/images/logo_revista_57x50.png"" />				
			</div>
			<div class="user_menu">
				<ul>
					{if $isUserLoggedIn}
					<li><a href="{$baseUrl}/login/signOut.html">{translate key="navigation.logout"}</a></li>
					{else}				  
					<li>{*trigger modal*}<a href="#myModal" role="button"  data-toggle="modal">{translate key="navigation.login"}</a></li>
					{/if}
					<li><a href="{$baseUrl}/user/register.html">{translate key="navigation.register"}</a></li>
				</ul>
			
				{* Modal *}
				<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="login_modal-header"><p>{translate key="about.onlineSubmissions.registrationRequired"}</p></div>
				  <div class="modal-body">
						<form method="post" action="{$userBlockLoginUrl}">
							{if $error}
								<span class="pkp_form_error">{translate key="$error" reason=$reason}</span>
								<br />
								<br />
							{/if}
							<input type="hidden" name="source" value="{$source|strip_unsafe_html|escape}" />
							<table>
								<tr>
									<td><label for="sidebar-username">{translate key="user.username"}</label></td>
									<td><input type="text" id="sidebar-username" name="username" value="" size="12" maxlength="32" class="textField" /></td>
								</tr>
								<tr>
									<td><label for="sidebar-password">{translate key="user.password"}</label></td>
									<td><input type="password" id="sidebar-password" name="password" value="{$password|escape}" size="12" maxlength="32" class="textField" /></td>
								</tr>
							</table>
							
							<input type="submit" value="{translate key="user.login"}" class="btn" />
							<div class="login_modal_lost_pass">&#187; <a href="{url page="login" op="lostPassword"}">{translate key="user.login.forgotPassword"}</a></div>
							<div class="login_modal_close"><button class="btn" data-dismiss="modal" aria-hidden="true">{translate key="common.close"}</button></div>
							
						</form> 
					</div>							
				</div>
				{* Modal *}
			</div>

			<div class="block_nav" id="sidebarLanguageToggle">
				<div class="blockTitle" style="color:#333;">.</div>
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
			
			<div id="style-switcher">
				<p><strong>{translate key="user.styleswitcher"}</strong></p>			
				<div class="circle_dark"><a href="{$baseUrl}/style-switcher.php?style=custom"><img src="{$baseUrl}/templates/images/bulllet_dark.png" alt="{translate key="user.styleswitcher.dark"}" width="10" height="10"></a></div>
				<div class="circle_light"><a href="{$baseUrl}/style-switcher.php?style=custom_light"><img src="{$baseUrl}/templates/images/bulllet_light.png" alt="{translate key="user.styleswitcher.light"}" width="10" height="10"></a></div>
			</div>
		</div>
	</div>
	
	<div id="menu_principal_container">
		<div id="menu_principal" itemscope itemtype="http://schema.org/SiteNavigationElement">
			<ul>{if $enableAnnouncements}
				<li><a href="{$baseUrl}/announcement.html" itemprop="url">{translate key="announcement.announcements"}</a></li>
				{/if}{* enableAnnouncements *}
				<li><a href="{$baseUrl}/about.html" itemprop="url">{translate key="navigation.about"}</a></li>
				<li><a href="{$baseUrl}/issue/archive.html" itemprop="url">{translate key="navigation.past.issues"}</a></li>
				<li><a href="{$baseUrl}/pages/view/indices.html" itemprop="url">{translate key="navigation.indexes"}</a></li>
				<li><a href="{$baseUrl}/about/submissions.html" itemprop="url">{translate key="navigation.ForAuthors"}</a></li>
				
				{call_hook name="Templates::Common::Header::Navbar::CurrentJournal"}

				{foreach from=$navMenuItems item=navItem}
					{if $navItem.url != '' && $navItem.name != ''}
						<li id="navItem"><a href="{if $navItem.isAbsolute}{$navItem.url|escape}{else}{$navItem.url|escape}{/if}">{if $navItem.isLiteral}{$navItem.name|escape}{else}{translate key=$navItem.name}{/if}</a></li>
					{/if}
				{/foreach}
			</ul>
			
			<div id="social_menu">			
				<a class="social_menu_twitter" href="http://twitter.com/RRInternacional" title="Twitter" target="_blank">T</a>
				<a class="social_menu_facebook" href="http://www.facebook.com/RelacionesInternacionales" title="Facebook" target="_blank">F</a>
				<a class="social_menu_academia" href="http://uam.academia.edu/relacionesinternacionales" title="Academia" target="_blank">A</a>				
			</div>
			
			<div id="block_search">			
				<form method="post" action="{url page="search" op="search"}">
				<table cellpadding="5">
				<tr>
					<td><input type="text" id="query" name="query" maxlength="255" value="{translate key="navigation.search"}" class="textField" /></td>		
				</tr>
				</table>
				</form>
			</div>			
		</div>
	</div>

	<div id="general">

		<div id="sub_container" >
		{if $currentUrl == "http://www.relacionesinternacionales.info/ojs/index.php?journal=Relaciones_Internacionales&page=index" || $currentUrl == "http://www.relacionesinternacionales.info/ojs/index.php?journal=Relaciones_Internacionales"}
		{include file="custom/frontpage.tpl"}
		{else}
		<div id="breadcrumb">
	<a href="{$baseUrl}/index.html" target="_parent">{translate key="navigation.home"}</a> &bull;
	<a href="{$baseUrl}/issue/archive.html" target="_parent">{translate key="issue.issues"}</a> &bull;
	{if $issue}<a href="{$baseUrl}/issue/view/{$issue->getBestIssueId($currentJournal)}.html" target="_parent">{$issue->getIssueTitle(false,true)|escape} | {$issue->getIssueIdentification(false,true)|escape}</a> &bull;{/if}
	<a href="{url page="article" op="view" path=$articleId|to_array:$galleyId}" class="current" target="_parent">{foreach from=$article->getAuthors() item=author name=authorList}{$author->getLastName()|escape}{if !$smarty.foreach.authorList.last},{/if}
			{/foreach}</a>
</div>
		{if $leftSidebarCode || $rightSidebarCode}
			<div id="sidebar">
				{if $leftSidebarCode}
					<div id="leftSidebar">
						{$leftSidebarCode}
					</div>
				{/if}
				{if $rightSidebarCode}
					<div id="rightSidebar">
						{$rightSidebarCode}
					</div>
				{/if}
			</div>
		{/if}

		{/if}

			<div id="supramain">
				<div id="main">				
<div id="content_article" itemscope itemtype="http://schema.org/ScholarlyArticle">
{* MODIFICADO OJS V.2.4.2 / 04-2013*}
