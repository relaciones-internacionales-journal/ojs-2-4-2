{**
 * templates/user/index.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * User index.
 *
 *}
{strip}
{assign var="pageTitle" value="user.userHome"}
{include file="common/header.tpl"}
{/strip}

{if $isSiteAdmin}
	{assign var="hasRole" value=1}
	<div class="users_home_user_cat">
		<p class="user_cat"><a href="{url journal="index" page=$isSiteAdmin->getRolePath()}">{translate key=$isSiteAdmin->getRoleName()}</a></p>
	</div>
	{call_hook name="Templates::User::Index::Site"}
{/if}

<div id="myJournals">
{if !$currentJournal}<h3>{translate key="user.myJournals"}</h3>{/if}

{foreach from=$userJournals item=journal}
	<div id="journal-{$journal->getPath()|escape}">
	{assign var="hasRole" value=1}
	{if !$currentJournal}<h4><a href="{url journal=$journal->getPath() page="user"}">{$journal->getLocalizedTitle()|escape}</a></h4>
	{else}<h3 style="display:none;">{$journal->getLocalizedTitle()|escape}</h3>{/if}
	{assign var="journalId" value=$journal->getId()}
	{assign var="journalPath" value=$journal->getPath()}
		{if $isValid.JournalManager.$journalId}
			<div class="users_home_user_cat">
				<p class="user_cat"><a href="{url journal=$journalPath page="manager"}">{translate key="user.role.manager"}</a></p>
				{if $setupIncomplete.$journalId}[<p><a href="{url journal=$journalPath page="manager" op="setup" path="1"}">{translate key="manager.setup"}</a></p>]{/if}
			<hr/></div>
		{/if}
		{if $isValid.SubscriptionManager.$journalId}
			<div class="users_home_user_cat">
				<p class="user_cat"><a href="{url journal=$journalPath page="subscriptionManager"}">{translate key="user.role.subscriptionManager"}</a></p>
			<hr/></div>
		{/if}
		{if $isValid.Editor.$journalId || $isValid.SectionEditor.$journalId || $isValid.LayoutEditor.$journalId || $isValid.Copyeditor.$journalId || $isValid.Proofreader.$journalId}
			{}
		{/if}
		{if $isValid.Editor.$journalId}
			<div class="users_home_user_cat">
				{assign var="editorSubmissionsCount" value=$submissionsCount.Editor.$journalId}
				<p class="user_cat"><a href="{url journal=$journalPath page="editor"}">{translate key="user.role.editor"}</a></p>
				<p class="user_cat_content">{if $editorSubmissionsCount[0]}
						<a href="{url journal=$journalPath page="editor" op="submissions" path="submissionsUnassigned"}"><span class="medium_number">{$editorSubmissionsCount[0]}</span> {translate key="common.queue.short.submissionsUnassigned"}</a>
					{else}<span class="disabled">0 {translate key="common.queue.short.submissionsUnassigned"}</span>{/if}
				</p>
				<p class="user_cat_content">{if $editorSubmissionsCount[1]}
						<a href="{url journal=$journalPath page="editor" op="submissions" path="submissionsInReview"}"><span class="medium_number">{$editorSubmissionsCount[1]}</span> {translate key="common.queue.short.submissionsInReview"}</a>
					{else}<span class="disabled">0 {translate key="common.queue.short.submissionsInReview"}</span>{/if}
				</p>
				<p class="user_cat_content">{if $editorSubmissionsCount[2]}
						<a href="{url journal=$journalPath page="editor" op="submissions" path="submissionsInEditing"}"><span class="medium_number">{$editorSubmissionsCount[2]}</span> {translate key="common.queue.short.submissionsInEditing"}</a>
					{else}<span class="disabled">0 {translate key="common.queue.short.submissionsInEditing"}</span>{/if}
				</p>
				<p class="user_cat_actions_create">[<a href="{url journal=$journalPath page="editor" op="createIssue"}">{translate key="editor.issues.createIssue"}</a>] </p>
				<p class="user_cat_actions_notify">[<a href="{url journal=$journalPath page="editor" op="notifyUsers"}">{translate key="editor.notifyUsers"}</a>]</p>
			<hr/></div>
		{/if}
		{if $isValid.SectionEditor.$journalId}
			{assign var="sectionEditorSubmissionsCount" value=$submissionsCount.SectionEditor.$journalId}
			<div class="users_home_user_cat">
				<p class="user_cat"><a href="{url journal=$journalPath page="sectionEditor"}">{translate key="user.role.sectionEditor"}</a></p>
				<p class="user_cat_content">{if $sectionEditorSubmissionsCount[0]}
						<a href="{url journal=$journalPath page="sectionEditor" op="index" path="submissionsInReview"}"><span class="medium_number">{$sectionEditorSubmissionsCount[0]}</span>  {translate key="common.queue.short.submissionsInReview"}</a>
					{else}<span class="disabled">0 {translate key="common.queue.short.submissionsInReview"}</span>{/if}
				</p>
				<p class="user_cat_content">{if $sectionEditorSubmissionsCount[1]}
						<a href="{url journal=$journalPath page="sectionEditor" op="index" path="submissionsInEditing"}"><span class="medium_number">{$sectionEditorSubmissionsCount[1]}</span>  {translate key="common.queue.short.submissionsInEditing"}</a>
					{else}<span class="disabled">0 {translate key="common.queue.short.submissionsInEditing"}</span>{/if}
				</p>
				<td align="right"></td>
			<hr/></div>
		{/if}
		{if $isValid.LayoutEditor.$journalId}
			{assign var="layoutEditorSubmissionsCount" value=$submissionsCount.LayoutEditor.$journalId}
			<div class="users_home_user_cat">
				<p class="user_cat"><a href="{url journal=$journalPath page="layoutEditor"}">{translate key="user.role.layoutEditor"}</a></p>
				<p class="user_cat_content">{if $layoutEditorSubmissionsCount[0]}
						<a href="{url journal=$journalPath page="layoutEditor" op="submissions"}"><span class="medium_number">{$layoutEditorSubmissionsCount[0]}</span>  {translate key="common.queue.short.submissionsInEditing"}</a>
					{else}<span class="disabled">0 {translate key="common.queue.short.submissionsInEditing"}</span>{/if}
				</p>
			<hr/></div>
		{/if}
		{if $isValid.Copyeditor.$journalId}
			{assign var="copyeditorSubmissionsCount" value=$submissionsCount.Copyeditor.$journalId}
			<div class="users_home_user_cat">
				<p class="user_cat"><a href="{url journal=$journalPath page="copyeditor"}">{translate key="user.role.copyeditor"}</a></p>
				<p class="user_cat_content">{if $copyeditorSubmissionsCount[0]}
						<a href="{url journal=$journalPath page="copyeditor"}"><span class="medium_number">{$copyeditorSubmissionsCount[0]}</span> {translate key="common.queue.short.submissionsInEditing"}</a>
					{else}<span class="disabled">0 {translate key="common.queue.short.submissionsInEditing"}</span>{/if}
				</p>
			<hr/></div>
		{/if}
		{if $isValid.Proofreader.$journalId}
			{assign var="proofreaderSubmissionsCount" value=$submissionsCount.Proofreader.$journalId}
			<div class="users_home_user_cat">
				<p class="user_cat"><a href="{url journal=$journalPath page="proofreader"}">{translate key="user.role.proofreader"}</a></p>
				<p class="user_cat_content">{if $proofreaderSubmissionsCount[0]}
						<a href="{url journal=$journalPath page="proofreader"}"><span class="medium_number">{$proofreaderSubmissionsCount[0]}</span> {translate key="common.queue.short.submissionsInEditing"}</a>
					{else}<span class="disabled">0 {translate key="common.queue.short.submissionsInEditing"}</span>{/if}
				</p>
			<hr/></div>
		{/if}
		{if $isValid.Author.$journalId || $isValid.Reviewer.$journalId}
			{}
		{/if}
		{if $isValid.Author.$journalId}
			{assign var="authorSubmissionsCount" value=$submissionsCount.Author.$journalId}
			<div class="users_home_user_cat">
				<p class="user_cat"><a href="{url journal=$journalPath page="author"}">{translate key="user.role.author"}</a></p>
				<p class="user_cat_content">{if $authorSubmissionsCount[0]}
						<a href="{url journal=$journalPath page="author"}"><span class="medium_number">{$authorSubmissionsCount[0]}</span> {translate key="common.queue.short.active"}</a>
					{else}<span class="disabled">0 {translate key="common.queue.short.active"}</span>{/if}
				</p>
				{* This is for all non-pending items*}
				<p class="user_cat_content">{if $authorSubmissionsCount[1]}
						<a href="{url journal=$journalPath path="completed" page="author"}"><span class="medium_number">{$authorSubmissionsCount[1]}</span> {translate key="common.queue.short.completed"}</a>
					{else}<span class="disabled">0 {translate key="common.queue.short.completed"}</span>{/if}
				</p>
				<p class="user_cat_actions_create">[<a href="{url journal=$journalPath page="author" op="submit"}">{translate key="author.submit"}</a>]</p>
			<hr/></div>
		{/if}
		{if $isValid.Reviewer.$journalId}
			{assign var="reviewerSubmissionsCount" value=$submissionsCount.Reviewer.$journalId}
			<div class="users_home_user_cat">
				<p class="user_cat"><a href="{url journal=$journalPath page="reviewer"}">{translate key="user.role.reviewer"}</a></p>
				<p class="user_cat_content">{if $reviewerSubmissionsCount[0]}
						<a href="{url journal=$journalPath page="reviewer"}"><span class="medium_number">{$reviewerSubmissionsCount[0]}</span> {translate key="common.queue.short.active"}</a>
					{else}<span class="disabled">0 {translate key="common.queue.short.active"}</span>{/if}
				</p>
				
			</div>
		{/if}
		{* Add a row to the bottom of each table to ensure all have same width*}
			
	{call_hook name="Templates::User::Index::Journal" journal=$journal}
	</div>
{/foreach}
</div>	


{if !$hasRole}
	{if $currentJournal}
		<div id="noRolesForJournal">
		<p>{translate key="user.noRoles.noRolesForJournal"}</p>
		<ul class="plain">
			<li>
				&#187;
				{if $allowRegAuthor}
					{url|assign:"submitUrl" page="author" op="submit"}
					<a href="{url op="become" path="author" source=$submitUrl}">{translate key="user.noRoles.submitArticle"}</a>
				{else}{* $allowRegAuthor *}
					{translate key="user.noRoles.submitArticleRegClosed"}
				{/if}{* $allowRegAuthor *}
			</li>
			<li>
				&#187;
				{if $allowRegReviewer}
					{url|assign:"userHomeUrl" page="user" op="index"}
					<a href="{url op="become" path="reviewer" source=$userHomeUrl}">{translate key="user.noRoles.regReviewer"}</a>
				{else}{* $allowRegReviewer *}
					{translate key="user.noRoles.regReviewerClosed"}
				{/if}{* $allowRegReviewer *}
			</li>
		</ul>
		</div>
	{else}{* $currentJournal *}
		<div id="currentJournal">
		<p>{translate key="user.noRoles.chooseJournal"}</p>
		<ul class="plain">
			{foreach from=$allJournals item=thisJournal}
				<li>&#187; <a href="{url journal=$thisJournal->getPath() page="user" op="index"}">{$thisJournal->getLocalizedTitle()|escape}</a></li>
			{/foreach}
		</ul>
		</div>
	{/if}{* $currentJournal *}
{/if}{* !$hasRole *}

<div id="myAccount">
<div class="arrow_down_box">
<h3>{translate key="user.myAccount"}</h3>
</div>
<ul class="plain">
	{*{if $hasOtherJournals}
		{if !$showAllJournals}
			<li class="view"><a href="{url journal="index" page="user"}">{translate key="user.showAllJournals"}</a></li>
		{/if}
	{/if}*}
	{if $currentJournal}
		{if $subscriptionsEnabled}
			<li>&#187; <a href="{url page="user" op="subscriptions"}">{translate key="user.manageMySubscriptions"}</a></li>
		{/if}
	{/if}
	{if $currentJournal}
		{if $acceptGiftPayments}
			<li>&#187; <a href="{url page="user" op="gifts"}">{translate key="gifts.manageMyGifts"}</a></li>
		{/if}
	{/if}
	<li class="edit"><a href="{url page="user" op="profile"}">{translate key="user.editMyProfile"}</a></li>

	{if !$implicitAuth}
		<li class="edit"><a href="{url page="user" op="changePassword"}">{translate key="user.changeMyPassword"}</a></li>
	{/if}

	{if $currentJournal}
		{if $journalPaymentsEnabled && $membershipEnabled}
			{if $dateEndMembership}
				<li>&#187; <a href="{url page="user" op="payMembership"}">{translate key="payment.membership.renewMembership"}</a> ({translate key="payment.membership.ends"}: {$dateEndMembership|date_format:$dateFormatShort})</li>
			{else}
				<li>&#187; <a href="{url page="user" op="payMembership"}">{translate key="payment.membership.buyMembership"}</a></li>		
			{/if}
		{/if}{* $journalPaymentsEnabled && $membershipEnabled *}
	{/if}{* $userJournal *}

	<li class="logout"><a href="{url page="login" op="signOut"}">{translate key="user.logOut"}</a></li>
	{call_hook name="Templates::User::Index::MyAccount"}
</ul>
</div>

{include file="common/footer.tpl"}
{* MODIFICADO OJS V.2.4.2 / 04-2013*}
