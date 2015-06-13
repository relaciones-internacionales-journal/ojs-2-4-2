{**
 * templates/article/footer.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Article View -- Footer component.
 *}

{*{if $sharingEnabled}
<!-- start AddThis -->
	{if isset($sharingDropDownMenu)}
		{if isset($sharingUserName)}
			<script type="text/javascript">
				var addthis_pub = '{$sharingUserName}';
			</script>
		{/if}
		<br />
		<br />
		<div class="addthis_container">
			<a href="http://www.addthis.com/bookmark.php"
				onmouseover="return addthis_open(this, '', '{$sharingArticleURL|escape:"javascript"}', '{$sharingArticleTitle|escape:"javascript"}')"
				onmouseout="addthis_close()" onclick="return addthis_sendto()">
					<img src="{$sharingButtonUrl}" width="{$sharingButtonWidth}" height="{$sharingButtonHeight}" border="0" alt="Bookmark and Share" style="border:0;padding:0" />
			</a>
			<script type="text/javascript" src="http://s7.addthis.com/js/200/addthis_widget.js"></script>
		</div>
	{else}
		<a href="http://www.addthis.com/bookmark.php"
			onclick="window.open('http://www.addthis.com/bookmark.php?pub={$sharingUserName|escape:"url"}&amp;url={$sharingRequestURL|escape:"url"}&amp;title={$sharingArticleTitle|escape:"url"}', 'addthis',
			                     'scrollbars=yes,menubar=no,width=620,height=520,resizable=yes,toolbar=no,location=no,status=no');
			         return false;"
			title="Bookmark using any bookmark manager!" target="_blank">
				<img src="{$sharingButtonUrl}" width="{$sharingButtonWidth}" height="{$sharingButtonHeight}" border="0" alt="Bookmark and Share" style="border:0;padding:0" />
		</a>
	{/if}
<!-- end AddThis -->
{/if}

{if $currentJournal && $currentJournal->getSetting('includeCreativeCommons')}
	<br /><br />
	<a rel="license" target="_new" href="http://creativecommons.org/licenses/by/3.0/"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by/3.0/80x15.png" /></a>
	<br />
	This <span xmlns:dc="http://purl.org/dc/elements/1.1/" href="http://purl.org/dc/dcmitype/Text" rel="dc:type">work</span> is licensed under a <a target="_new" rel="license" href="http://creativecommons.org/licenses/by/3.0/">Creative Commons Attribution 3.0 License</a>.
{/if}*}

{call_hook name="Templates::Article::Footer::PageFooter"}
{if $pageFooter}
<br /><br />
{$pageFooter}
{/if}
</div><!-- content -->
</div><!-- main -->
</div><!-- supramain -->
</div><!-- sub_container -->
</div><!-- general -->
<div id="footer">
	<div class="footer_container">
		<div class="row-fluid">
			<div class="span9">	
				<div class="footer_about_journal"  itemscope itemtype="http://schema.org/ScholarlyArticle">
					<h2 itemprop="editor">Relaciones Internacionales</span></h2>
					<p>{translate key="footer.multilanguage"}</p>
					<meta itemprop="publisher" content="Grupo de Estudios de Relaciones Internacionales (GERI), Facultad de Derecho, Universidad Autónoma de Madrid" />					
				</div>
			</div>
			<div class="span3">			
				<div class="footer_logo_uam">
					<a href="http://www.uam.es" title="UAM" target="_blank">UAM</a>
				</div>				
			</div>			
		</div>
		
		<div class="row-fluid">
			<div class="span9">			
				<div class="footer_ojs_tools"> 
					<ul>
						<li class="footerContent4_4"><a href="http://creativecommons.org/licenses/by-nc-sa/3.0/">BY-NC-SA</a></li>
						<li class="footerContent4_1"><a href="http://open-access.net/de_en/homepage/">OPEN ACESS</a></li>
						<li class="footerContent4_3"><a href="http://lockss.stanford.edu/lockss/Home">LOCKSS</a></li>
						<li class="footerContent4_5"><a href="http://dublincore.org/">DUBLIN CORE</a></li>
						<li class="footerContent4_2"><a href="http://pkp.sfu.ca/">PKP</a></li>
					</ul>
				</div>
			</div>
			<div class="span3">
				<div class="footer_nav">
					<ul>
						<li><a href="{$baseUrl}/about/contact.html">{translate key="footer.menuContact"}</a></li>
					</ul>
				</div>
				<div class="back-to-top" id="back-top">
					<a href="#" class="back-to-top">Top</a>
					</div>
							
									
					<script type="text/javascript">
					$('#back-to-top"').bind('click', function(e) {
					   e.preventDefault();
					   $('html, body').animate({ scrollTop: $(this.hash).offset().top }, "3000", "easeIn");

					   // edit: Opera requires the "html" elm. animated
					});
					</script>
			</div>
		</div>
	</div>
	
</div>
{if $defineTermsContextId}
<script type="text/javascript">
{literal}
<!--
	// Open "Define Terms" context when double-clicking any text
	function openSearchTermWindow(url) {
		var term;
		if (window.getSelection) {
			term = window.getSelection();
		} else if (document.getSelection) {
			term = document.getSelection();
		} else if(document.selection && document.selection.createRange && document.selection.type.toLowerCase() == 'text') {
			var range = document.selection.createRange();
			term = range.text;
		}
		if (url.indexOf('?') > -1) openRTWindowWithToolbar(url + '&defineTerm=' + term);
		else openRTWindowWithToolbar(url + '?defineTerm=' + term);
	}

	if(document.captureEvents) {
		document.captureEvents(Event.DBLCLICK);
	}
	document.ondblclick = new Function("openSearchTermWindow('{/literal}{url page="rt" op="context" path=$articleId|to_array:$galleyId:$defineTermsContextId escape=false}{literal}')");
// -->
{/literal}
</script>
{/if}

{get_debug_info}
{if $enableDebugStats}{include file=$pqpTemplate}{/if}
</div><!-- container -->
	<!-- JS Style switcher -->
	<script type="text/javascript">
				$('#style-switcher a').styleSwitcher();
	</script>
	
</body>
</html>
{* MODIFICADO OJS V.2.4.2 / 04-2013*}
