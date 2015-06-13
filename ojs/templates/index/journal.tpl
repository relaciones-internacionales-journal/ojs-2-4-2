{**
 * templates/index/journal.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Journal index page.
 *
 *}
{strip}
{assign var="pageTitleTranslated" value=$siteTitle}
{include file="common/header.tpl"}
{/strip}

{* {if $journalDescription}
	<div>{$journalDescription}</div>
{/if}*}

{call_hook name="Templates::Index::journal"}

{* {if $homepageImage}
<br />
<div id="homepageImage"><img src="{$publicFilesDir}/{$homepageImage.uploadName|escape:"url"}" width="{$homepageImage.width|escape}" height="{$homepageImage.height|escape}" {if $homepageImageAltText != ''}alt="{$homepageImageAltText|escape}"{else}alt="{translate key="common.journalHomepageImage.altText"}"{/if} /></div>
{/if}*}

{* D{if $additionalHomeContent}
<br />
{$additionalHomeContent}
{/if}*}

{if $issue && $currentJournal->getSetting('publishingMode') != $smarty.const.PUBLISHING_MODE_NONE}
	{* Display the table of contents or cover page of the current issue. *}
	{* <br />
	<h3>{$issue->getIssueIdentification()|strip_unsafe_html|nl2br}</h3>*}
	<div class="alert alert-info">
		<button type="button" class="close" data-dismiss="alert">×</button>
		<img src="http://www.relacionesinternacionales.info/ojs/templates/images/style_dark/info32.png" align="left" alt="Cookies" style="margin-top:7px;" width="32" height="32"/>
		<p>{translate key="frontpage.cookiesPolicy"}</p>
	</div>	
	<div class="fp_issue_block">
		<div class="fp_issue_bignumber">
		  <p><a href="#">N{$issue->getNumber()|strip_unsafe_html|nl2br}</a></p>		  
		</div>
		<div class="fp_issue_title">	
		  <h2><a href="{$baseUrl}/issue/view/{$issue->getNumber()|strip_unsafe_html|nl2br}.html" title="{translate key="frontpage.lastIssue"}">{$issue->getLocalizedTitle()|strip_unsafe_html|nl2br}</a></h2>
		</div>
		{*TOCHANGEEACHISSUE*}<div class="fp_issue_meta"><p style="font-size:9pt;">{$issue->getLocalizedDescription() |strip_unsafe_html|nl2br} <span class="divider">/</span> {translate key="frontpage.lastIssueCoordinators"} Francisco Verdes-Montenegro Escanez {*{translate key="frontpage.CoordinatorsAnd"}*}
		<span class="divider">/</span> <a href="/ojs/article/download/648/415.pdf" title="Download" class="download" target="_blank" style="padding-left:20px;">{translate key="frontpage.downloadlastFullIssue"} {$issue->getNumber()|strip_unsafe_html|nl2br} {translate key="frontpage.full"}</a></p>
		</div>
	</div>
	
	<div class="fp_tabbed_area">  
		<ul class="nav nav-tabs" id ="myTab">
			<li class="active"><a href="#{translate key="frontpage.lastIssueIntro"}" data-toggle="tab">{translate key="frontpage.lastIssueIntro"}</a></li>
			{foreach name=sections from=$publishedArticles item=section key=sectionId}
			{if $sectionId !='10' && $sectionId !='8' && $sectionId !='5'}
			<li><a href="#{$section.title|escape}" data-toggle="tab">{$section.title|escape}</a></li>{/if}
			{if $sectionId =='5'}<li><a href="#VS" data-toggle="tab">{$section.title|escape}</a></li>{/if}
			{/foreach}
		</ul>
        <div class="tab-content">
			<div class="tab-pane active" id="{translate key="frontpage.lastIssueIntro"}">
			{*TOCHANGEEACHISSUE*}{if $locale =='es_ES'}
			<p class="fp_issue_intro">Coincidiendo que en este 2015 se cumple el plazo fijado en la Cumbre del Milenio para que se lograran los ocho Objetivos de Desarrollo del Mileno (ODM) y en el mismo a&ntilde;o en el que deben estar aprobadas las nuevas metas globales que les den continuidad, desde la revista Relaciones Internacionales hemos querido aprovechar la ocasi&oacute;n para profundizar en cuestiones relacionadas con el desarrollo y la cooperaci&oacute;n en materia de lucha contra la pobreza, la exclusi&oacute;n y las desigualdades en todas sus formas.
			<br><br>El Secretario General de Naciones Unidas ha llegado a afirmar que es “el a&ntilde;o m&aacute;s importante para el desarrollo desde que se fund&oacute; la organizaci&oacute;n”  ya que, en palabras del propio Ban Ki Moon,  “el mundo nunca antes ha tenido que hacer frente a una agenda tan compleja en un solo a&ntilde;o”.
			<br><br>Desde esta revista se ha querido contribuir a la reflexi&oacute;n en un momento tan trascendental y, para ello, en este n&uacute;mero nos aproximamos a la problem&aacute;tica desde diferentes &aacute;ngulos, complementarios entre s&iacute;, y sin perder de vista de d&oacute;nde venimos. Por ello, por un lado, se cuenta con trabajos que hacen un balance de los ODM, sus logros, los objetivos pendientes, y las cr&iacute;ticas que han suscitado en esta d&eacute;cada y media. Por otro lado, se presentan contribuciones en torno al proceso de debate y negociaci&oacute;n de la agenda post-2015  que est&aacute; teniendo lugar desde mayo de 2012 y que concluir&aacute; este a&ntilde;o con la aprobaci&oacute;n de los Objetivos de Desarrollo Sostenible (ODS), unas nuevas metas globales que vinculan la agenda de desarrollo y sostenibilidad. Para ello se presta especial atenci&oacute;n a las consecuencias que puede tener la nueva agenda que est&aacute; defini&eacute;ndose para los diferentes actores involucrados y las distintas regiones.
			</p></div>
			{elseif $locale =='en_US'}
			<p class="fp_issue_intro">The year 2015 is the deadline set in the Millennium Summit to achieve the eight Millennium Development Goals (MDGs), as well as the year in which new global goals that ensure the continuity of the former will be approved. Against this backdrop, in <em>Relaciones Internacionales</em> we did not want to miss the opportunity to delve into issues related to development and cooperation in their fight against poverty, exclusion and inequality in all its forms.<br><br>
			The UN Secretary General has even asserted that “it is the most important year for development since the organization was founded” because, in the words of Ban Ki Moon, "the world has never faced such a complex agenda in the span of a single year".<br><br>
			At this critical juncture, this journal set out to contribute to the discussion. To this end, the current issue has explored several approaches to the problematiques at hand. Undertaken from different angles, all of them are nevertheless complementary and do not deviate from the place where we come from. Therefore, on the one hand, this issue offers contributions that take stock of the MDGs, their achievements and the critiques that have arisen in the last decade and a half. On the other hand, it gathers contributions on the post-2015 agenda´s process of discussion and negotiation that has unfolded since May 2012. The latter is planned to come to an end this year with the approval of the Sustainable Development Goals (SDGs) –the new goals linking global development and sustainability agendas. In this sense, this issue pays special attention to the consequences that might ensue from the new agenda that is currently being defined for the different actors involved in distinct regions of the world.
			</p></div>
			{/if}
			{foreach name=sections from=$publishedArticles item=section key=sectionId}
			{if $sectionId !='10' && $sectionId !='8' && $sectionId !='5'}
			<div class="tab-pane" id="{$section.title|escape}">
				{foreach from=$section.articles item=article}
				{assign var=articlePath value=$article->getBestArticleId($currentJournal)}			  	
				<div class="tocArticle">
					{if $article->getLocalizedFileName() && $article->getLocalizedShowCoverPage() && !$article->getHideCoverPageToc($locale)}
					<div>
						<div class="tocArticleCoverImage">
						<a href="{url page="article" op="view" path=$articlePath}" class="file">
						<img src="{$coverPagePath|escape}{$article->getFileName($locale)|escape}"{if $article->getCoverPageAltText($locale) != ''} alt="{$article->getCoverPageAltText($locale)|escape}"{else} alt="{translate key="article.coverPage.altText"}"{/if}/></a></div>
					</div>
					{/if}
					{call_hook name="Templates::Issue::Issue::ArticleCoverImage"}

					{if $article->getLocalizedAbstract() == ""}
						{assign var=hasAbstract value=0}
					{else}
						{assign var=hasAbstract value=1}
					{/if}

					{assign var=articleId value=$article->getId()}
					{if (!$subscriptionRequired || $article->getAccessStatus() == $smarty.const.ARTICLE_ACCESS_OPEN || $subscribedUser || $subscribedDomain || ($subscriptionExpiryPartial && $articleExpiryPartial.$articleId))}
						{assign var=hasAccess value=1}
					{else}
						{assign var=hasAccess value=0}
					{/if}

					<div class="tocTitle">
					{if !$hasAccess || $hasAbstract}<a href="{$baseUrl}/article/view/{$articlePath}.html">{$article->getLocalizedTitle()|strip_unsafe_html}</a>
					{else}{$article->getLocalizedTitle()|strip_unsafe_html}{/if}
					</div>				
					
					{if (!$section.hideAuthor && $article->getHideAuthor() == $smarty.const.AUTHOR_TOC_DEFAULT) || $article->getHideAuthor() == $smarty.const.AUTHOR_TOC_SHOW}
					<div class="tocAuthors">
						{foreach from=$article->getAuthors() item=author name=authorList}
							{$author->getFullName()|escape}{if !$smarty.foreach.authorList.last},{/if}
						{/foreach}
					</div>
					{/if}
					
					<div class="tocPages">{$article->getPages()|escape}</div>	
					{if !$hasAccess || $hasAbstract}<div class="tocAbstract"><a href="{$baseUrl}/article/view/{$articlePath}.html">{if $hasAbstract}{translate key=article.abstract}
					{*{else}{translate key="article.details"}*}{/if}</a></div>{/if}
					
					<div class="tocGalleys">
						{if $hasAccess || ($subscriptionRequired && $showGalleyLinks)}
							{foreach from=$article->getGalleys() item=galley name=galleyList}
								<a href="{$baseUrl}/article/download/{$articlePath}/{$galley->getBestGalleyId($currentJournal)}.pdf" class="file" target="_blank">{$galley->getGalleyLabel()|escape}</a>
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
						{/if}
					</div>
				</div>
				{call_hook name="Templates::Issue::Issue::Article"}
				{/foreach}
			</div>
			{/if}
			
			{if $sectionId =='5'}
			<div class="tab-pane" id="VS">
				{foreach from=$section.articles item=article}
				{assign var=articlePath value=$article->getBestArticleId($currentJournal)}			  	
				<div class="tocArticle">
					{if $article->getLocalizedFileName() && $article->getLocalizedShowCoverPage() && !$article->getHideCoverPageToc($locale)}
					<div>
						<div class="tocArticleCoverImage">
						<a href="{url page="article" op="view" path=$articlePath}" class="file">
						<img src="{$coverPagePath|escape}{$article->getFileName($locale)|escape}"{if $article->getCoverPageAltText($locale) != ''} alt="{$article->getCoverPageAltText($locale)|escape}"{else} alt="{translate key="article.coverPage.altText"}"{/if}/></a></div>
					</div>
					{/if}
					{call_hook name="Templates::Issue::Issue::ArticleCoverImage"}

					{if $article->getLocalizedAbstract() == ""}
						{assign var=hasAbstract value=0}
					{else}
						{assign var=hasAbstract value=1}
					{/if}

					{assign var=articleId value=$article->getId()}
					{if (!$subscriptionRequired || $article->getAccessStatus() == $smarty.const.ARTICLE_ACCESS_OPEN || $subscribedUser || $subscribedDomain || ($subscriptionExpiryPartial && $articleExpiryPartial.$articleId))}
						{assign var=hasAccess value=1}
					{else}
						{assign var=hasAccess value=0}
					{/if}

					<div class="tocTitle">
					{if !$hasAccess || $hasAbstract}<a href="{$baseUrl}/article/view/{$articlePath}.html">{$article->getLocalizedTitle()|strip_unsafe_html}</a>
					{else}{$article->getLocalizedTitle()|strip_unsafe_html}{/if}
					</div>				
					
					{if (!$section.hideAuthor && $article->getHideAuthor() == $smarty.const.AUTHOR_TOC_DEFAULT) || $article->getHideAuthor() == $smarty.const.AUTHOR_TOC_SHOW}
					<div class="tocAuthors">
						{foreach from=$article->getAuthors() item=author name=authorList}
							{$author->getFullName()|escape}{if !$smarty.foreach.authorList.last},{/if}
						{/foreach}
					</div>
					{/if}
					
					<div class="tocPages">{$article->getPages()|escape}</div>	
					{if !$hasAccess || $hasAbstract}<div class="tocAbstract"><a href="{$baseUrl}/article/view/{$articlePath}.html">{if $hasAbstract}{translate key=article.abstract}
					{*{else}{translate key="article.details"}*}{/if}</a></div>{/if}
					
					<div class="tocGalleys">
						{if $hasAccess || ($subscriptionRequired && $showGalleyLinks)}
							{foreach from=$article->getGalleys() item=galley name=galleyList}
								<a href="{$baseUrl}/article/download/{$articlePath}/{$galley->getBestGalleyId($currentJournal)}.pdf" class="file"  target="_blank">{$galley->getGalleyLabel()|escape}</a>
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
						{/if}
					</div>
				</div>
				{call_hook name="Templates::Issue::Issue::Article"}
				{/foreach}
			</div>
			{/if}
			{/foreach}				  		
		</div> 
		<script>
		  $(function () {
			$('#myTab a:last').tab('show');
		  })
		</script>     
	</div>
	
	<div class="fp_sidebar_bt_left">
		{if $enableAnnouncementsHomepage}	
		{* Display announcements *}
		<div class="fp_announcementsHome">
			<h3><a href="{$baseUrl}/announcement.html">{translate key="announcement.announcementsHome"}</a></h3>
			{include file="announcement/list.tpl"}	
		</div>
		{/if}
		
		{if $isUserLoggedIn}
		<div class="fp_user_logged">
		<h3>{translate key="navigation.user"}</h3>
			<p style="padding-left:8px;">{translate key="plugins.block.user.loggedInAs"}<br />
			<strong>{$loggedInUsername|escape}</strong></p>
			<ul class="sd_bl_user">
				<li class="sidebarblockUserHome"><a href="{$baseUrl}/user.html">{translate key="plugins.block.user.myHome"}</a></li>
				<li class="sidebarblockUserProfile"><a href="{$baseUrl}/user/profile.html">{translate key="plugins.block.user.myProfile"}</a></li>
				<li class="sidebarblockUserLogout"><a href="{$baseUrl}/login/signOut.html">{translate key="plugins.block.user.logout"}</a></li>			
			</ul>
		</div>
		{/if}
	</div>
	
	
	<div class="fp_past_issues_carrousel_container">
		<div class="other_issues">
		<p>{translate key="frontpage.PastIssues"}<p>
		</div>
		<div id="ca-container" class="ca-container">
			<div class="ca-wrapper">
			
				<div class="ca-item ca-item-1">
					<div class="ca-item-main">
						<div class="ca-icon"></div>
						{*TOCHANGEEACHISSUE*}<h3>{translate key="issue.issue"} 27<br/><span style="font-size:22px;">{translate key="frontpage.OctoberIssue"} 2014</span>
						</h3>
							<a href="#" class="ca-more">{translate key="frontpage.More"}</a>
					</div>
					<div class="ca-content-wrapper">
						<div class="ca-content">
							<h6>{if $locale =='es_ES'}Feminismos en las Relaciones Internacionales, 30 a&ntilde;os despu&eacute;s
								{elseif $locale =='en_US'}Feminisms in International Relations, a 30 years journey{/if}</h6>
							<a href="#" class="ca-close">close</a>
							<div class="ca-content-text">
								<p>{if $locale =='es_ES'}Han pasado nueve a&ntilde;os desde que en este revista se public&oacute; el n&uacute;mero dedicado al “Feminismo en las Relaciones Internacionales”, en el que se abordaron cuestiones tan relevantes como las resistencias a la incorporaci&oacute;n de las metodolog&iacute;as feministas en la disciplina, o la &eacute;tica feminista en relaci&oacute;n a los procesos globales. Existen sin duda continuidades en este n&uacute;mero, mostrando as&iacute; la consolidaci&oacute;n durante los &uacute;ltimos treinta a&ntilde;os del campo feminista en el estudio de las relaciones internacionales, como la preocupaci&oacute;n por la participaci&oacute;n de las mujeres en los procesos de paz y los escenarios posconflicto. Sin embargo, en este n&uacute;mero hemos tratado de incorporar nuevos enfoques y avenidas investigadoras que se han ido desarrollando desde entonces, con la emergencia de los feminismos poscoloniales, decoloniales, o posestructuralistas. Son voces que provienen de mujeres chicanas, africanas, negras, queer, transg&eacute;nero, en la b&uacute;squeda de una conversaci&oacute;n particular entre “conocimientos situados” que nos [...] 
									{elseif $locale =='en_US'}Nine years have gone by since this journal devoted an issue to "Feminism in International Relations", where relevant issues such as the resistance to the incorporation of feminist methodologies within the discipline, or the feminist ethic in relation with global processes were addressed. The evident continuities between that and this issue show that a feminist stance has consolidated in the field of Interntional Relations throughout the last 30 years -see, for instance, the attention given to the participation of women in peace processes and post-conflict settings. This issue, however, is set out to incorporate new approaches and avenues of research that have developed since then, along with the appearance of postcolonial, decolonial and postructuralist feminism. Chicano, African, black, queer and transgender women voices stand out in their search for a particular conversation among "situated knowledges". These might help us widen our understanding of the subjects and connections that make up global relations, as well as reveal the intersection of the different oppressions that traverse both the subjects and the power mechanisms [...]
									{/if}</p>
							</div>
							<ul>
								<li><a href="/ojs/issue/view/27.html">{translate key="frontpage.ReadMore"}</a></li>
							</ul>
						</div>
					</div>
				</div>
			
				<div class="ca-item ca-item-2">
					<div class="ca-item-main">
						<div class="ca-icon"></div>
						{*TOCHANGEEACHISSUE*}<h3>{translate key="issue.issue"} 26<br/><span style="font-size:22px;">{translate key="frontpage.JuneIssue"} 2014</span>
						</h3>
							<a href="#" class="ca-more">{translate key="frontpage.More"}</a>
					</div>
					<div class="ca-content-wrapper">
						<div class="ca-content">
							<h6>{if $locale =='es_ES'}Resistencias y aportaciones africanas a las Relaciones Internacionales
								{elseif $locale =='en_US'}Resistances and African contributions to International Relations{/if}</h6>
							<a href="#" class="ca-close">close</a>
							<div class="ca-content-text">
								<p>{if $locale =='es_ES'}En este n&uacute;mero pretendemos contribuir a las discusiones que se han ido produciendo durante los &uacute;ltimos a&ntilde;os en torno al papel que &aacute;frica y los africanos y africanas pueden desempe&ntilde;ar en las Relaciones Internacionales. Para ello, pretendemos mostrar c&oacute;mo la agencia de los diversos actores africanos puede contribuir de forma notable a las cuestiones que plantean determinados conceptos centrales en las Relaciones Internacionales, tales como el estado, soberan&iacute;a, globalizaci&oacute;n, desarrollo, democracia, etc&Eacute;tera. Estas cuestiones se han tratado en los &uacute;ltimos a&ntilde;os de manera creciente. Sin embargo, a&uacute;n hoy siguen siendo una cuesti&oacute;n menor dentro de las Relaciones Internacionales, por lo que consideramos importante ampliar su alcance, especialmente en el contexto de las Relaciones Internacionales en espa&ntilde;ol, &aacute;mbito en el que las discusiones acerca de las aportaciones africanas a la disciplina son pr&aacute;cticamente nulas.
									{elseif $locale =='en_US'}In this issue, we intend to contribute to the debates arisen during the last years about the role that Africa and the Africans can play in International Relations. For this purpose, we intend to show how the agency of different African actors can contribute in a remarkable way to the debates around some key concepts of International Relations, such as the state, sovereignty, globalization, development, democracy, etc. Although these questions have been increasingly addressed in the last years, they are still today a minor issue in International Relations theory. For that reason, we consider that it is important to widen their scope, first of all within Spanish IR circles, where debates about African contributions to our field of study are almost non-existent.
									{/if}</p>
							</div>
							<ul>
								<li><a href="/ojs/issue/view/26.html">{translate key="frontpage.ReadMore"}</a></li>
							</ul>
						</div>
					</div>
				</div>
				
				<div class="ca-item ca-item-3">
					<div class="ca-item-main">
						<div class="ca-icon"></div>
						{*TOCHANGEEACHISSUE*}<h3>{translate key="issue.issue"} 25<br/><span style="font-size:22px;">{translate key="frontpage.FebruaryIssue"} 2014</span>
						</h3>
							<a href="#" class="ca-more">{translate key="frontpage.More"}</a>
					</div>
					<div class="ca-content-wrapper">
						<div class="ca-content">
							<h6>{if $locale =='es_ES'}El Caribe como m&uacute;ltiples espacios en lucha
								{elseif $locale =='en_US'}The Caribbean as Multiple Contested Spaces{/if}</h6>
							<a href="#" class="ca-close">close</a>
							<div class="ca-content-text">
								<p>{if $locale =='es_ES'}El n&uacute;mero que presentamos en esta ocasi&oacute;n tiene como prop&oacute;sito confrontar las visiones dist&oacute;picas sobre el Caribe para reflejarlo desde una diversidad amplia en narrativas, imaginarios e introspecciones. Los textos aqu&iacute; publicados buscan complejizar las m&uacute;ltiples realidades pasadas y presentes de ese espacio donde su transitar construye lo que Alejo Carpentier llam&oacute; lo real maravilloso. 
									{elseif $locale =='en_US'}One of the aims of this publication is to contest the dystopic visions about the Caribbean and to offer a wider diversity of imaginaries and narratives. In this issue the reader must find a publication enriched with narratives on Caribbean literature, diaspora studies, gender studies, daily practices of resistance, and critical approaches on development and security studies, among others. Disciplines as History, Anthropology, and Literature merged into a more complex framework to approach Caribbean history and current contested spaces.
									{/if}</p>
							</div>
							<ul>
								<li><a href="/ojs/issue/view/25.html">{translate key="frontpage.ReadMore"}</a></li>
							</ul>
						</div>
					</div>
				</div>
				
				<div class="ca-item ca-item-4">
					<div class="ca-item-main">
						<div class="ca-icon"></div>
						{*TOCHANGEEACHISSUE*}<h3>{translate key="issue.issue"} 24<br/><span style="font-size:22px;">{translate key="frontpage.OctoberIssue"} 2013</span>
						</h3>
							<a href="#" class="ca-more">{translate key="frontpage.More"}</a>
					</div>
					<div class="ca-content-wrapper">
						<div class="ca-content">
							<h6>{if $locale =='es_ES'}&iquest;C&oacute;mo pensar lo internacional / global en el siglo XXI? Herramientas, conceptos te&oacute;ricos, acontecimientos y actores
								{elseif $locale =='en_US'}How we think international / global in the 21st Century? Tools, theoretical concepts, events and actors{/if}</h6>
							<a href="#" class="ca-close">close</a>
							<div class="ca-content-text">
								<p>{if $locale =='es_ES'}El &uacute;ltimo n&uacute;mero de la European Journal of International Relations (EJIR, septiembre de 2013) est&aacute; dedicado monogr&aacute;ficamente a la pregunta  &quot;The End of International Relations Theory&quot;.  En sus p&aacute;ginas, hay un diversidad de posturas al respecto —mayoritariamente la contestaci&oacute;n es &quot;no&quot;—  en las que, en diferentes grados y formas, se expresa preocupaci&oacute;n,  cuando no desencanto o desesperanza por la falta de un cuerpo te&oacute;rico unificado de la disciplina o, dicho de otro modo, por la proliferaci&oacute;n dispersa de enfoques, perspectivas, epistemolog&iacute;as, ontolog&iacute;as, y metodolog&iacute;as, que se dan en la producci&oacute;n te&oacute;rica de lo que se considera la disciplina.
									{elseif $locale =='en_US'}The latest issue of the European Journal of International Relations (EJIR, September 2013) is solely dedicated to "The End of International Relations Theory" question. In its pages, there is a diversity of positions in this regard - mostly reply is "no" - that, in different degrees and forms, expressing concern, when not disappointment or hopelessness by the lack of a unified theoretical body of discipline or, in other words, by the dispersed proliferation of approaches, perspectives, epistemologies, ontologies, and methodologies, which are given in the theoretical production of what is considered a discipline.
									{/if}</p>
							</div>
							<ul>
								<li><a href="/ojs/issue/view/24.html">{translate key="frontpage.ReadMore"}</a></li>
							</ul>
						</div>
					</div>
				</div>																	
				
			</div>
		</div>		
		
	</div>
	
	{*TOCHANGEEACHISSUE*}<div id="last_issues_phone">
		<ul>
		<li><a href="/issue/view/27.html">{translate key="issue.issue"} 27</a></li>
		<li><a href="/issue/view/26.html">{translate key="issue.issue"} 26</a></li>
		<li><a href="/issue/view/25.html">{translate key="issue.issue"} 25</a></li>
		<li><a href="/issue/view/24.html">{translate key="issue.issue"} 24</a></li>
		</ul>
	</div>
	
{/if}

{include file="common/footer.tpl"}
{* MODIFICADO OJS V.2.4.2 / 04-2013*}
