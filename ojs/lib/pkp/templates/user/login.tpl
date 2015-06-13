{**
 * templates/user/login.tpl
 *
 * Copyright (c) 2000-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * User login form.
 *
 *}
{strip}
{assign var="pageTitle" value="user.login"}
{include file="common/header.tpl"}
{/strip}

{if !$registerOp}
	{assign var="registerOp" value="register"}
{/if}
{if !$registerLocaleKey}
	{assign var="registerLocaleKey" value="user.login.registerNewAccount"}
{/if}

{if $loginMessage}
	<span class="instruct">{translate key="$loginMessage"}</span>
	<br />
	<br />
{/if}

{if $implicitAuth}
	<a id="implicitAuthLogin" href="{url page="login" op="implicitAuthLogin"}">Login</a>
{else}
<div class="login_form">
	<form id="signinForm" method="post" action="{$loginUrl}" class="form-horizontal">
{/if}

{if $error}
	<div class="alert alert-block">
			<button type="button" class="close" data-dismiss="alert">&times;</button>
			<p>{translate key="$error" reason=$reason}</p>
	</div>
	<br />
	<br />
{/if}

<input type="hidden" name="source" value="{$source|strip_unsafe_html|escape}" />

{if ! $implicitAuth}
	
	<div class="control-group">
		<label class="control-label" for="loginUsername">{translate key="user.username"}</label>
		<div class="input-prepend">
		  <span class="add-on"><i class="icon-user"></i></span>
		  <input type="text" id="loginUsername" name="username" value="{$username|escape}" size="20" maxlength="32" class="textField">
		</div>
	</div>
	
	<div class="control-group">
		<label class="control-label" for="loginPassword">{translate key="user.password"}</label>
		<div class="input-prepend">
			<span class="add-on"><i class="icon-lock"></i></span>
			<input type="password" id="loginPassword" name="password" value="{$password|escape}" size="20" maxlength="32" class="textField">
		</div>
	</div>
	
	<div class="control-group">
		<div class="controls" style="float:right;">
		<input type="submit" value="{translate key="user.login"}" class="btn" />
		</div>
	</div>
	
	<div class="control-group" style="float:right;">
		{if !$hideRegisterLink}<p class="login_lostpass"><a href="{url page="user" op=$registerOp}">{translate key=$registerLocaleKey}</a></p>{/if}
		<p class="login_lostpass"><a href="{url page="login" op="lostPassword"}">{translate key="user.login.forgotPassword"}</a></p>
	</div>
  
{/if}{* !$implicitAuth *}

<script type="text/javascript">
<!--
	document.getElementById('{if $username}loginPassword{else}loginUsername{/if}').focus();
// -->
</script>
</form>
</div>
{include file="common/footer.tpl"}
{* MODIFICADO OJS V.2.4.2 / 04-2013*}