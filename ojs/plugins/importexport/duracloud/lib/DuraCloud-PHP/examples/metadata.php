<?php

/**
 * @file metadata.php
 *
 * Copyright (c) 2011 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Connect to a DuraCloud server, create a new space, and twiddle with metadata.
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

if (count($argv) != 5) {
	echo "Usage:\n";
	echo array_shift($argv) . " [DuraCloud base URL] [username] [password] [spaceID]\n";
	exit(-2);
}

// Get arguments.
$exampleName = array_shift($argv);
$baseUrl = array_shift($argv);
$username = array_shift($argv);
$password = array_shift($argv);
$spaceId = array_shift($argv);

// Try a connection.
$dcc = new DuraCloudConnection($baseUrl, $username, $password);
$ds = new DuraStore($dcc);

// Create a space.
$location = $ds->createSpace(
	$spaceId,
	array(DURACLOUD_SPACE_ACCESS => DURACLOUD_SPACE_ACCESS_OPEN)
);
if (!$location) die("Could not create a space!\n");

// Check its metadata.
$metadata = $ds->getSpaceMetadata($spaceId);
if (!$metadata) die("Could not read space metadata part 1!\n");
if ($metadata[DURACLOUD_SPACE_ACCESS] != DURACLOUD_SPACE_ACCESS_OPEN) die("Incorrect metadata part 1!\n");

// Reset its metadata.
$result = $ds->setSpaceMetadata($spaceId, array(DURACLOUD_SPACE_ACCESS => DURACLOUD_SPACE_ACCESS_CLOSED));
if (!$result) die("Unable to set space metadata!\n");

// Check the results.
$metadata = $ds->getSpaceMetadata($spaceId);
if (!$metadata) die("Could not read space metadata part 2!\n");
if ($metadata[DURACLOUD_SPACE_ACCESS] != DURACLOUD_SPACE_ACCESS_CLOSED) die("Incorrect metadata part 2!\n");

if (!$ds->deleteSpace($spaceId)) die("Unable to delete space!\n");

echo "Success!\n";

?>
