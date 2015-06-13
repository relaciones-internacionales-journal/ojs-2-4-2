<?php

/**
 * @file createspace.php
 *
 * Copyright (c) 2011 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Connect to a DuraCloud server and create a new space.
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

if (count($argv) < 5 || count($argv) > 6) {
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
$location = $ds->createSpace(
	$spaceId,
	array(DURACLOUD_SPACE_ACCESS => DURACLOUD_SPACE_ACCESS_OPEN),
	$storeId
);

if ($location !== false) {
	echo "\nThe new space was created as \"$location\".\n";
} else {
	echo "The new space could not be created. Check your credentials and space ID.\n";
	exit(-3);
}

?>
