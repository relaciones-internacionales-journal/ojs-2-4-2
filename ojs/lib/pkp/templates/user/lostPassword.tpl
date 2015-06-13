{**
 * templates/user/lostPassword.tpl
 *
 * Copyright (c) 2000-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Password reset form.
 *
 *}
{strip}
{assign var="pageTitle" value="user.login.resetPassword"}
{include file="common/header.tpl"}
{/strip}
{if !$registerLocaleKey}
	{assign var="registerLocaleKey" value="user.login.registerNewAccount"}
{/if}

<form id="reset" action="{url page="login" op="requestResetPassword"}" method="post">
<p><span class="instruct">{translate key="user.login.resetPasswordInstructions"}</span></p>

{if $error}
	<p><span class="pkp_form_error">{translate key="$error"}</span></p>
{/if}

<p>{translate key="user.login.registeredEmail"}</p>
<p><input type="text" name="email" value="{$username|escape}" size="30" maxlength="90" class="textField" /></p>

<p><input type="submit" value="{translate key="user.login.resetPassword"}" class="btn" /></p>

{*{if !$hideRegisterLink}
	&#187; <a href="{url page="user" op=$registerOp}">{translate key=$registerLocaleKey}</a>
{/if}*}

<script type="text/javascript">
<!--
	document.getElementById('reset').email.focus();
// -->
</script>
</form>

{include file="common/footer.tpl"}
{* MODIFICADO OJS V.2.4.2 / 04-2013*}