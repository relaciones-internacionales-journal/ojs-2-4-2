{**
 * templates/article/article.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Article View.
 *}
{if $galley}
	{assign var=pubObject value=$galley}
{else}
	{assign var=pubObject value=$article}
{/if}


{include file="article/header.tpl"}

{if $galley}
	{if $galley->isHTMLGalley()}
		{$galley->getHTMLContents()}
	{elseif $galley->isPdfGalley()}
		{include file="article/pdfViewer.tpl"}
	{/if}
{else}
	<div id="topBar" style="display:none;">
		{if is_a($article, 'PublishedArticle')}{assign var=galleys value=$article->getGalleys()}{/if}
		{if $galleys && $subscriptionRequired && $showGalleyLinks}
			<div id="accessKey">
				<img src="{$baseUrl}/lib/pkp/templates/images/icons/fulltext_open_medium.gif" alt="{translate key="article.accessLogoOpen.altText"}" />
				{translate key="reader.openAccess"}&nbsp;
				<img src="{$baseUrl}/lib/pkp/templates/images/icons/fulltext_restricted_medium.gif" alt="{translate key="article.accessLogoRestricted.altText"}" />
				{if $purchaseArticleEnabled}
					{translate key="reader.subscriptionOrFeeAccess"}
				{else}
					{translate key="reader.subscriptionAccess"}
				{/if}
			</div>
		{/if}
	</div>
	{if $coverPagePath}
		<div id="articleCoverImage"><img src="{$coverPagePath|escape}{$coverPageFileName|escape}"{if $coverPageAltText != ''} alt="{$coverPageAltText|escape}"{else} alt="{translate key="article.coverPage.altText"}"{/if}{if $width} width="{$width|escape}"{/if}{if $height} height="{$height|escape}"{/if}/>
		</div>
	{/if}
	{call_hook name="Templates::Article::Article::ArticleCoverImage"}
	<div id="articleTitle"><h2 itemprop="name">{$article->getLocalizedTitle()|strip_unsafe_html}</h2></div>
	<div id="authorString">
	{foreach from=$article->getAuthors() item=author name=authors}
	<div class="authorBio">
	<p itemprop="author">{$author->getFullName()|escape}</p>
	<p class="p_authorBio">{if $author->getUrl()}<a href="{$author->getUrl()|escape:"quotes"}">{$author->getUrl()|escape}</a><br/>{/if}
		{assign var=authorAffiliation value=$author->getLocalizedAffiliation()}
		{if $authorAffiliation}{$authorAffiliation|escape}{/if}
		{if !$authorAffiliation}{$author->getLocalizedBiography()|strip_unsafe_html|nl2br}{/if}
		{if $author->getCountry()}<br/>{$author->getCountryLocalized()|escape}{/if}
	</p>

	{*<p>{$author->getLocalizedBiography()|strip_unsafe_html|nl2br}</p>*}
	</div>
	{*{if !$smarty.foreach.authors.last}<div class="separator"></div>{/if}*}

	{/foreach}</div>
	<br />
	{if $article->getLocalizedAbstract()}
		<div id="articleAbstract">		       
			<h3>{translate key="article.abstract"}</h3>		
			<div itemprop="about">{$article->getLocalizedAbstract()|strip_unsafe_html|nl2br}</div>
		</div>
	{/if}

	{if $article->getLocalizedSubject()}
		{assign var='localizedSubjectString' value=$article->getLocalizedSubject()|escape}
		{assign var='numberOfDelimiters' value=$localizedSubjectString|substr_count:";"}
		{assign var='subjects' value=$localizedSubjectString|explode:";":$numberOfDelimiters+1}

		<div id="articleSubject">
		<h3>{translate key="article.subject"}</h3>
		<br />
		<ul>
		{foreach from=$subjects item=subject}
         {php}$this->assign('param', array("subject" => $this->get_template_vars('subject'))){/php}
         <li><a href="{url page="search" params=$param}"><span itemprop="keywords">{$subject}</span></a></li>
		{/foreach}
		</ul>
		<br />
		</div>
	{/if}


	{if (!$subscriptionRequired || $article->getAccessStatus() == $smarty.const.ARTICLE_ACCESS_OPEN || $subscribedUser || $subscribedDomain)}
		{assign var=hasAccess value=1}
	{else}
		{assign var=hasAccess value=0}
	{/if}

	{if $galleys}
		<div id="articleFullText">
		<h3>{translate key="reader.fullText"}</h3>
		<br />
		{if $hasAccess || ($subscriptionRequired && $showGalleyLinks)}
			{foreach from=$article->getGalleys() item=galley name=galleyList}
				<div><a itemprop="articleBody" href="{$baseUrl}/article/view/{$article->getBestArticleId($currentJournal)}/{$galley->getBestGalleyId($currentJournal)}.html" class="documento" target="_blank">{translate key="reader.download"}</a><br /><br />
				<a itemprop="url" class="descargar_general" id="pdfDownloadLink" target="_blank" href="{$baseUrl}/article/download/{$article->getBestArticleId($currentJournal)}/{$galley->getBestGalleyId($currentJournal)}.pdf">{translate key="article.pdf.download"}</a></div>
				{if $subscriptionRequired && $showGalleyLinks && $restrictOnlyPdf}
					{if $article->getAccessStatus() == $smarty.const.ARTICLE_ACCESS_OPEN || !$galley->isPdfGalley()}
						<img class="accessLogo" src="{$baseUrl}/lib/pkp/templates/images/icons/fulltext_open_medium.gif" alt="{translate key="article.accessLogoOpen.altText"}" />
					{else}
						<img class="accessLogo" src="{$baseUrl}/lib/pkp/templates/images/icons/fulltext_restricted_medium.gif" alt="{translate key="article.accessLogoRestricted.altText"}" />
					{/if}
				{/if}
			{/foreach}
			{if $subscriptionRequired && $showGalleyLinks && !$restrictOnlyPdf}
				{if $article->getAccessStatus() == $smarty.const.ARTICLE_ACCESS_OPEN}
					<img class="accessLogo" src="{$baseUrl}/lib/pkp/templates/images/icons/fulltext_open_medium.gif" alt="{translate key="article.accessLogoOpen.altText"}" />
				{else}
					<img class="accessLogo" src="{$baseUrl}/lib/pkp/templates/images/icons/fulltext_restricted_medium.gif" alt="{translate key="article.accessLogoRestricted.altText"}" />
				{/if}
			{/if}
		{else}
			&nbsp;<a href="{url page="about" op="subscriptions"}" target="_parent">{translate key="reader.subscribersOnly"}</a>
		{/if}
		</div>
	{/if}
	
	<!-- start AddThis -->
        {if $sharingEnabled}
            {if isset($sharingDropDownMenu)}
                {if isset($sharingUserName)}
                    <script type="text/javascript">
                        var addthis_pub = '{$sharingUserName}';
                    </script>
                {/if}
			
                <div class="addthis_container">
				<h3>{translate key="reader.articleShare"}</h3>
					<div class="addthis_toolbox addthis_default_style ">
						<a class="addthis_button_email addtoemail"></a>
						<a class="addthis_button_facebook addtofacebook"></a>
						<a class="addthis_button_tuenti addtotuenti"></a>
						<a class="addthis_button_twitter addtotwitter"></a>
						<a class="addthis_button_mendeley addtomendeley"></a>
						<a class="addthis_button_citeulike addtociteulike"></a>
					</div>  
				</div>					
            {/if}
        {/if}
        <!-- end AddThis -->
		

	{if $citationFactory->getCount()}
		<div id="articleCitations">
		<h4>{translate key="submission.citations"}</h4>
		<br />
		<div>
			{iterate from=citationFactory item=citation}
				<p>{$citation->getRawCitation()|strip_unsafe_html}</p>
			{/iterate}
		</div>
		<br />
		</div>
	{/if}
{/if}

{foreach from=$pubIdPlugins item=pubIdPlugin}
	{if $issue->getPublished()}
		{assign var=pubId value=$pubIdPlugin->getPubId($pubObject)}
	{else}
		{assign var=pubId value=$pubIdPlugin->getPubId($pubObject, true)}{* Preview rather than assign a pubId *}
	{/if}
	{if $pubId}
		<br />
		<br />
		{$pubIdPlugin->getPubIdDisplayType()|escape}: {if $pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}<a id="pub-id::{$pubIdPlugin->getPubIdType()|escape}" href="{$pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}">{$pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}</a>{else}{$pubId|escape}{/if}
	{/if}
{/foreach}

{include file="article/comments.tpl"}

{include file="article/footer.tpl"}
{* MODIFICADO OJS V.2.4.2 / 04-2013*}
