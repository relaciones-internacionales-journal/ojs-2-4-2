{**
 * templates/article/pdfViewer.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Embedded PDF viewer.
 *}

{* The target="_parent" is for the sake of iphones, which present scroll problems otherwise. *}
{url|assign:"pdfUrl" op="viewFile" path=$articleId|to_array:$galley->getBestGalleyId($currentJournal) escape=false}
{translate|assign:"noPluginText" key='article.pdf.pluginMissing'}
<script type="text/javascript"><!--{literal}
	$(document).ready(function(){
		if ($.browser.webkit) { // PDFObject does not correctly work with safari's built-in PDF viewer
			var embedCode = "<object id='pdfObject' type='application/pdf' data='{/literal}{$pdfUrl|escape:'javascript'}{literal}' width='99%' height='99%'><div id='pluginMissing'>{/literal}{$noPluginText|escape:'javascript'}{literal}</div></object>";
			$("#inlinePdf").html(embedCode);
			if($("#pluginMissing").is(":hidden")) {
				$('#fullscreenShow').show();
				$("#inlinePdf").resizable({ containment: 'parent', handles: 'se' });
			} else { // Chrome Mac hides the embed object, obscuring the text.  Reinsert.
				$("#inlinePdf").html('<div id="pluginMissing"><p>The PDF file you selected should load here if your Web browser has a PDF reader plug-in installed (for example, a recent version of <a href="http://www.adobe.com/products/acrobat/readstep2.html">Adobe Acrobat Reader</a>).</p> <p>Alternatively, you can also download the PDF file directly to your computer, from where it can be opened using a PDF reader. To download the PDF, click the Download link below.</p> <p>If you would like more information about how to print, save, and work with PDFs, Highwire Press provides a helpful <a href="http://highwire.stanford.edu/help/pdf-faq.dtl">Frequently Asked Questions about PDFs</a>.</p></div>');
			}
		} else {
			var success = new PDFObject({ url: "{/literal}{$pdfUrl|escape:'javascript'}{literal}" }).embed("inlinePdf");
			if (success) {
				// PDF was embedded; enbale fullscreen mode and the resizable widget
				$('#fullscreenShow').show();
				$("#inlinePdfResizer").resizable({ containment: 'parent', handles: 'se' });
			}
		}
	});
{/literal}
// -->
</script>
<div id="inlinePdfResizer">
	<div id="inlinePdf" class="ui-widget-content">
	<object data="{/literal}{$pdfUrl|escape:'javascript'}{literal}" type="application/pdf" width="100%" height="100%">
	</object>		
	</div>
</div>
<div id="pdfDownloadLinkContainer" style="font-size:12px;margin-top:10px;">
	<a class="descargar_general" id="pdfDownloadLink" target="_parent" href="{$baseUrl}/article/download/{$article->getBestArticleId($currentJournal)}/{$galley->getBestGalleyId($currentJournal)}.pdf">{translate key="article.pdf.download"}</a>
</div>
<hr/>
<div id="pluginMissing" style="float:left;">{translate key="article.pdf.pluginMissing"}</div>
<p>
	<a class="action" href="#" id="fullscreenShow">{translate key="common.fullscreen"}</a>
	<a class="action" href="#" id="fullscreenHide">{translate key="common.fullscreenOff"}</a>
</p>
<div style="clear: both;"></div>
{* MODIFICADO OJS V.2.4.2 / 04-2013*}