{**
 * lib/pkp/templates/common/formErrors.tpl
 *
 * Copyright (c) 2000-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * List errors that occurred during form processing.
 *}
{if $isError}
	<div id="formErrors">
		<div class="alert alert-block">
			<button type="button" class="close" data-dismiss="alert">&times;</button>
			<h4>{translate key="form.errorTitle"}</h4>		
			<p>
			{translate key="form.errorsOccurred"}:<br/>
			<ul class="plain">
			{foreach key=field item=message from=$errors}
				<li><a href="#{$field|escape}">{$message}</a></li>
			{/foreach}
			</ul>
			</p>
		</div>
		
	</div>
	<script type="text/javascript">{literal}
		<!--
		// Jump to form errors.
		window.location.hash="formErrors";
		// -->
	{/literal}</script>
{/if}
{* MODIFICADO OJS V.2.4.2 / 04-2013*}