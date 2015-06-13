{**
 * plugins/blocks/user/block.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Common site sidebar menu -- user tools.
 *
 *}
{if $isUserLoggedIn}
	<div class="block" id="sidebarUser">
	{if !$implicitAuth}
		<div class="blockTitleModified">{translate key="navigation.user"}</div>
	{/if}
		<p style="padding-left:8px;">{translate key="plugins.block.user.loggedInAs"}<br />
		<strong>{$loggedInUsername|escape}</strong></p>
		<ul class="sd_bl_user">
			{**{if $hasOtherJournals}
				<li><a href="{url journal="index" page="user"}">{translate key="plugins.block.user.myJournals"}</a></li>
			{/if} *}
			<li class="sidebarblockUserHome"><a href="{$baseUrl}/user.html">{translate key="plugins.block.user.myHome"}</a></li>
			<li class="sidebarblockUserProfile"><a href="{$baseUrl}/user/profile.html">{translate key="plugins.block.user.myProfile"}</a></li>
			<li class="sidebarblockUserLogout"><a href="{$baseUrl}/login/signOut.html">{translate key="plugins.block.user.logout"}</a></li>			
			{if $userSession->getSessionVar('signedInAs')}
				<li class="sidebarblockUserLogoff"><a href="{url page="login" op="signOutAsUser"}">{translate key="plugins.block.user.signOutAsUser"}</a></li>
			{/if}
		</ul>
	</div>
	{else}
		{if $implicitAuth}
			<a href="{url page="login" op="implicitAuthLogin"}">Journals Login</a>
		{**{else}
			<form method="post" action="{$userBlockLoginUrl}">
				<table>
					<tr>
						<td><label for="sidebar-username">{translate key="user.username"}</label></td>
						<td><input type="text" id="sidebar-username" name="username" value="" size="12" maxlength="32" class="textField" /></td>
					</tr>
					<tr>
						<td><label for="sidebar-password">{translate key="user.password"}</label></td>
						<td><input type="password" id="sidebar-password" name="password" value="{$password|escape}" size="12" maxlength="32" class="textField" /></td>
					</tr>
					<tr>
						<td colspan="2"><input type="checkbox" id="remember" name="remember" value="1" /> <label for="remember">{translate key="plugins.block.user.rememberMe"}</label></td>
					</tr>
					<tr>
						<td colspan="2"><input type="submit" value="{translate key="user.login"}" class="button" /></td>
					</tr>
				</table>
			</form> *}
		{/if}	
{/if}
{* MODIFICADO OJS V.2.4.2 / 04-2012*}