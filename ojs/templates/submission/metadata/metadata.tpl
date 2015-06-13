{**
 * templates/submission/metadata/metadata.tpl
 *
 * Copyright (c) 2003-2013 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the submission metadata table. Non-form implementation.
 *}
<div id="metadata">
<h3>{translate key="submission.metadata"}</h3>

{if $canEditMetadata}
<div class="edit_metadata">
	<p><a href="{url op="viewMetadata" path=$submission->getId()}" class="action editar_general">{translate key="submission.editMetadata"}</a></p>
	{call_hook name="Templates::Submission::Metadata::Metadata::AdditionalEditItems"}
</div>
{/if}

<div id="authors">
<h4>{translate key="article.authors"}</h4>	
	{foreach name=authors from=$submission->getAuthors() item=author}
	<p><strong>{translate key="user.name"}</strong>: 
			{assign var=emailString value=$author->getFullName()|concat:" <":$author->getEmail():">"}
			{url|assign:"url" page="user" op="email" redirectUrl=$currentUrl to=$emailString|to_array subject=$submission->getLocalizedTitle()|strip_tags articleId=$submission->getId()}
			{$author->getFullName()|escape} {icon name="mail" url=$url}
	</p>
	{if $author->getUrl()}
		<p><strong>{translate key="user.url"}</strong>: <a href="{$author->getUrl()|escape:"quotes"}">{$author->getUrl()|escape}</a>
		</p>
	{/if}
	<p><strong>{translate key="user.affiliation"}</strong>: {$author->getLocalizedAffiliation()|escape|nl2br|default:"&mdash;"}
	</p>
	<p><strong>{translate key="common.country"}</strong>: {$author->getCountryLocalized()|escape|default:"&mdash;"}
	</p>
	{if $currentJournal->getSetting('requireAuthorCompetingInterests')}
		<p><strong>
				{url|assign:"competingInterestGuidelinesUrl" page="information" op="competingInterestGuidelines"}
				{translate key="author.competingInterests" competingInterestGuidelinesUrl=$competingInterestGuidelinesUrl}
			</strong>: 
			{$author->getLocalizedCompetingInterests()|strip_unsafe_html|nl2br|default:"&mdash;"}
		</p>
	{/if}
	<p><strong>{translate key="user.biography"}</strong>: 
		{$author->getLocalizedBiography()|strip_unsafe_html|nl2br|default:"&mdash;"}
	</p>
	{if $author->getPrimaryContact()}
		<p><strong>{translate key="author.submit.selectPrincipalContact"}</strong>
		</p>
	{/if}
	{if !$smarty.foreach.authors.last}
		<hr/>
	{/if}
	{/foreach}
</div>

<div id="titleAndAbstract">
<h4>{translate key="submission.titleAndAbstract"}</h4>
	<p><strong>{translate key="article.title"}</strong>: 
		{$submission->getLocalizedTitle()|strip_unsafe_html|default:"&mdash;"}
	</p>

	<p><strong>{translate key="article.abstract"}</strong>: 
		{$submission->getLocalizedAbstract()|strip_unsafe_html|nl2br|default:"&mdash;"}
	</p>
</div>

<div id="indexing">
<h4>{translate key="submission.indexing"}</h4>
	
	{if $currentJournal->getSetting('metaDiscipline')}
		<p><strong>{translate key="article.discipline"}</strong>:
			{$submission->getLocalizedDiscipline()|escape|default:"&mdash;"}
		</p>
	{/if}
	{if $currentJournal->getSetting('metaSubjectClass')}
		<p><strong>{translate key="article.subjectClassification"}</strong>:
			{$submission->getLocalizedSubjectClass()|escape|default:"&mdash;"}
		</p>
	{/if}
	{if $currentJournal->getSetting('metaSubject')}
		<p><strong>{translate key="article.subject"}</strong>:
			{$submission->getLocalizedSubject()|escape|default:"&mdash;"}
		</p>
	{/if}
	{if $currentJournal->getSetting('metaCoverage')}
		<p><strong>{translate key="article.coverageGeo"}</strong>:
			{$submission->getLocalizedCoverageGeo()|escape|default:"&mdash;"}
		</p>
		<p><strong>{translate key="article.coverageChron"}</strong>:
			{$submission->getLocalizedCoverageChron()|escape|default:"&mdash;"}
		</p>
		<p><strong>{translate key="article.coverageSample"}</strong>:
			{$submission->getLocalizedCoverageSample()|escape|default:"&mdash;"}
		</p>
	{/if}
	{if $currentJournal->getSetting('metaType')}
		<p><strong>{translate key="article.type"}</strong>:
			{$submission->getLocalizedType()|escape|default:"&mdash;"}
		</p>
	{/if}
	<p><strong>{translate key="article.language"}</strong>:
		{$submission->getLanguage()|escape|default:"&mdash;"}
	</p>
</div>

<div id="supportingAgencies">
	<h4>{translate key="submission.supportingAgencies"}</h4>		
	<p><strong>{translate key="submission.agencies"}</strong>:
			{$submission->getLocalizedSponsor()|escape|default:"&mdash;"}
	</p>
</div>

{call_hook name="Templates::Submission::Metadata::Metadata::AdditionalMetadata"}

{if $currentJournal->getSetting('metaCitations')}
	<div id="citations">
		<h4>{translate key="submission.citations"}</h4>
		<p><strong>{translate key="submission.citations"}
				{$submission->getCitations()|strip_unsafe_html|nl2br|default:"&mdash;"}
		</p>
	</div>
{/if}

</div><!-- metadata -->
{* MODIFICADO OJS V.2.4.2 / 04-2013*}
