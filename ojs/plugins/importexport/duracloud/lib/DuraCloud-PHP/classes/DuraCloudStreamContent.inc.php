<?php

/**
 * @file classes/DuraCloudStreamContent.inc.php
 *
 * Copyright (c) 2011 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class DuraCloudStreamContent
 * @ingroup duracloud_classes
 *
 * @brief DuraCloud API content model for streams
 */

class DuraCloudStreamContent extends DuraCloudContent {
	/** @var $size int */
	var $size;

	/**
	 * Constructor
	 * @param $spaceId string
	 * @param $contentId string
	 */
	function DuraCloudStreamContent(&$contentDescriptor) {
		parent::DuraCloudContent($contentDescriptor);
	}

	/**
	 * Set the content size
	 * @param $size
	 */
	function setSize($size) {
		$this->size = $size;
	}

	/**
	 * Get the size of the content.
	 * @return int
	 */
	function getSize() {
		return $this->size;
	}
}

?>
