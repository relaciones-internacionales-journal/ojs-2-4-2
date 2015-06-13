{**
 * plugins/generic/googleViewer/index.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Embedded PDF viewer using Google Doc embedder service.
 *}

{url|assign:"pdfUrl" op="viewFile" path=$articleId|to_array:$galley->getBestGalleyId($currentJournal) escape=false}
<iframe src="http://docs.google.com/viewer?url={$pdfUrl|escape:url}&embedded=true" style="width:100%; height:800px;" frameborder="0"></iframe>
<div id="pdfDownloadLinkContainer">
	<a class="descargar_general" id="pdfDownloadLink" target="_blank" style="font-size:12px;" href="{url op="download" path=$articleId|to_array:$galley->getBestGalleyId($currentJournal)}">{translate key="article.pdf.download"}</a>
</div>
{* MODIFICADO OJS V.2.4.2 / 04-2013*}