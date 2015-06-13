<?php

/**
 * @file classes/DuraCloudContent.inc.php
 *
 * Copyright (c) 2011 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class DuraCloudContent
 * @ingroup duracloud_classes
 *
 * @brief DuraCloud API content
 */

class DuraCloudContent {
	/** @var $contentDescriptor object */
	var $contentDescriptor;

	/** @var $fp resource */
	var $fp;

	/**
	 * Constructor
	 * @param $spaceId string
	 * @param $contentId string
	 */
	function DuraCloudContent(&$contentDescriptor) {
		$this->contentDescriptor =& $contentDescriptor;
	}

	function &getDescriptor() {
		return $this->contentDescriptor;
	}

	function setResource(&$fp) {
		$this->fp =& $fp;
	}

	function &getResource() {
		return $this->fp;
	}

	function close() {
		fclose($this->fp);
	}
}

?>
