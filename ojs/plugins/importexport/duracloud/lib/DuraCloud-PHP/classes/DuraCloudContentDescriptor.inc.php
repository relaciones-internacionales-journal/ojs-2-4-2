<?php

/**
 * @file classes/DuraCloudContentDescriptor.inc.php
 *
 * Copyright (c) 2011 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class DuraCloudContentDescriptor
 * @ingroup duracloud_classes
 *
 * @brief DuraCloud API content descriptor
 */

class DuraCloudContentDescriptor {
	/** @var $metadata array */
	var $metadata;

	/** @var $md5 string */
	var $md5;

	/** @var $contentType string */
	var $contentType;

	/**
	 * Constructor
	 * @param $spaceId string
	 * @param $contentId string
	 */
	function DuraCloudContentDescriptor($metadata = array()) {
		$this->metadata = $metadata;
	}

	function setMD5($md5) {
		$this->md5 = $md5;
	}

	function getMD5() {
		return $this->md5;
	}

	function setContentType($contentType) {
		$this->contentType = $contentType;
	}

	function getContentType() {
		return $this->contentType;
	}

	/**
	 * Get the entire metadata set, or a particular entry
	 * $param $name string Name of metadata element to get, or null for full array
	 * @return mixed
	 */
	function getMetadata($name = null) {
		if ($name === null) return $this->metadata;
		if (!isset($this->metadata[$name])) return null;
		return $this->metadata[$name];
	}

	/**
	 * Set the entire metadata set, or a particular entry
	 * Usage: setMetadata(array('name' => 'value'));
	 * ...or: setMetadata('name', 'value');
	 * @param $name mixed
	 * @param $value mixed
	 */
	function setMetadata($name, $value = null) {
		if (is_array($name)) {
			$this->metadata = $name;
		} else {
			if (!is_array($this->metadata)) $this->metadata = array();
			$this->metadata[$name] = $value;
		}
	}
}

?>
