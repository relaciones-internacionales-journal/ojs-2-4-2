<?php

/**
 * @file classes/DuraCloudFileContent.inc.php
 *
 * Copyright (c) 2011 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class DuraCloudFileContent
 * @ingroup duracloud_classes
 *
 * @brief DuraCloud API content model for files
 */

class DuraCloudFileContent extends DuraCloudContent {
	/**
	 * Constructor
	 * @param $spaceId string
	 * @param $contentId string
	 */
	function DuraCloudFileContent(&$contentDescriptor) {
		parent::DuraCloudContent($contentDescriptor);
	}

	/**
	 * Open a file by name.
	 * @param $fileName string
	 */
	function open($fileName, $mode = 'r') {
		$this->fp = fopen($fileName, $mode);
	}

	/**
	 * Get the size of the content.
	 * as it involves seeking to the end first.
	 * @return int
	 */
	function getSize() {
		fseek($this->fp, 0, SEEK_END);
		$i = ftell($this->fp);
		fseek($this->fp, 0, SEEK_SET);
		return $i;
	}
}

?>
