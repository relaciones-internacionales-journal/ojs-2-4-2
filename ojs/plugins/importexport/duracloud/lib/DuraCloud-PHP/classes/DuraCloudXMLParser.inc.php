<?php

/**
 * @file classes/DuraCloudXMLParser.inc.php
 *
 * Copyright (c) 2011 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class DuraCloudXMLParser
 * @ingroup duracloud_classes
 *
 * @brief DuraCloud PHP client XML helper class
 */

class DuraCloudXMLParser {
	/** @var $data array */
	var $data;

	/** @var $currentElement array Pointer into current element of $data */
	var $currentElement;

	/** @var $parser object */
	var $parser;

	/**
	 * Constructor
	 */
	function DuraCloudXMLParser() {
		$this->data = array('children' => array());
		$this->currentElement =& $this->data;
		$this->parser = xml_parser_create(DURACLOUD_XML_ENCODING);
		if ($this->parser) {
			xml_parser_set_option($this->parser, XML_OPTION_CASE_FOLDING, 0);
			xml_set_object($this->parser, $this);
			xml_set_element_handler($this->parser, 'startElement', 'endElement');
			xml_set_character_data_handler($this->parser, 'charData');
		}
	}

	function destroy() {
		xml_parser_free($this->parser);
		unset($this->data);
		unset($this->currentElement);
	}

	function parse($xmlContents) {
		if (!$this->parser) return false;
		return xml_parse($this->parser, $xmlContents);
	}

	function &getResults() {
		assert(isset($this->data['children'][0]));
		return $this->data['children'][0];
	}

	//
	// Internals
	//
	function startElement($parser, $tag, $attributes) {
		$newElement = array(
			'name' => $tag,
			'children' => array(),
			'parent' => &$this->currentElement,
			'content' => '',
			'attributes' => $attributes
		);
		$this->currentElement['children'][] =& $newElement;
		unset($this->currentElement);
		$this->currentElement =& $newElement;
	}

	function endElement($parser, $tag) {
		$oldCurrent =& $this->currentElement;
		unset($this->currentElement);
		$this->currentElement =& $oldCurrent['parent'];
	}

	function charData($parser, $data) {
		$this->currentElement['content'] .= $data;
	}
}

?>
