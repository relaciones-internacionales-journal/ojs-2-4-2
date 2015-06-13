<?php

/**
 * @file classes/DuraCloudComponent.inc.php
 *
 * Copyright (c) 2011 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class DuraCloudComponent
 * @ingroup duracloud_classes
 *
 * @brief DuraCloud API client implementation base class
 */

class DuraCloudComponent {
	/** @var $dcc DuraCloudConnection */
	var $dcc;

	/** @var $componentName string */
	var $componentName;

	/**
	 * Constructor
	 * @param $dcc DuraCloudConnection
	 */
	function DuraCloudComponent(&$dcc, $componentName) {
		$this->dcc =& $dcc;
		$this->componentName = $componentName;
	}

	function &getConnection() {
		return $this->dcc;
	}

	function getPrefix() {
		return "$this->componentName/";
	}
}

?>
