<?php

/**
 * @file listspacemetadata.php
 *
 * Copyright (c) 2011 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Connect to a DuraCloud server and get a list of a space's metadata.
 */

// Configure error display to maximum level
ini_set('display_errors', E_ALL);

// Import DuraCloud PHP library
require_once('../DuraCloudPHP.inc.php');

// Check usage.
if (!isset($argv)) {
	echo "This is a command line example. You must use the PHP CLI tool to execute.\n";
	exit(-1);
}

if (count($argv) < 5 || count($argv) > 9) {
	echo "Usage:\n";
	echo array_shift($argv) . " [DuraCloud base URL] [username] [password] [spaceID] [(storeID)]\n";
	exit(-2);
}

// Get arguments.
$exampleName = array_shift($argv);
$baseUrl = array_shift($argv);
$username = array_shift($argv);
$password = array_shift($argv);
$spaceId = array_shift($argv);
$storeId = array_shift($argv); // Optional

// Try a connection.
$dcc = new DuraCloudConnection($baseUrl, $username, $password);
$ds = new DuraStore($dcc);
$metadata = $ds->getSpaceMetadata($spaceId, $storeId);

if ($metadata !== false) {
	echo "\nMetadata:\n";
	foreach ($metadata as $key => $value) {
		echo " $key: $value\n";
	}
	echo "\n";
} else {
	echo "The list of space metadata could not be fetched. Check your credentials and space ID.\n";
	exit(-3);
}

?>
