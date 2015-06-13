<?php

/**
 * @defgroup duracloud
 */

/**
 * @file DuraCloudPHP.inc.php
 *
 * Copyright (c) 2011 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class DuraCloudPHP
 * @ingroup duracloud
 *
 * @brief DuraCloud PHP library main
 */

define('DURACLOUD_PHP_VERSION', '0.1');
define('DURACLOUD_XML_ENCODING', 'UTF-8');

// Utility classes
require_once('classes/DuraCloudXMLParser.inc.php');

// Connection class
require_once('classes/DuraCloudConnection.inc.php');

// Content model
require_once('classes/DuraCloudContentDescriptor.inc.php');
require_once('classes/DuraCloudContent.inc.php');
require_once('classes/DuraCloudFileContent.inc.php');
require_once('classes/DuraCloudStreamContent.inc.php');

// API implementations
require_once('classes/DuraCloudComponent.inc.php');
require_once('classes/DuraStore.inc.php');

?>
