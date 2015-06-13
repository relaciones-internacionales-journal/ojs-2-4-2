<?php

/**
 * @file content.php
 *
 * Copyright (c) 2011 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Connect to a DuraCloud server, create content, and twiddle with it.
 */

// A useful bit of content
define('TEST_CONTENT_STRING', 'This is test content!');

// Configure error display to maximum level
ini_set('display_errors', E_ALL);

// Import DuraCloud PHP library
require_once('../DuraCloudPHP.inc.php');

// Check usage.
if (!isset($argv)) {
	echo "This is a command line example. You must use the PHP CLI tool to execute.\n";
	exit(-1);
}

if (count($argv) != 6) {
	echo "Usage:\n";
	echo array_shift($argv) . " [DuraCloud base URL] [username] [password] [spaceID] [contentId]\n";
	exit(-2);
}

// Get arguments.
$exampleName = array_shift($argv);
$baseUrl = array_shift($argv);
$username = array_shift($argv);
$password = array_shift($argv);
$spaceId = array_shift($argv);
$contentId = array_shift($argv);

// Try a connection.
$dcc = new DuraCloudConnection($baseUrl, $username, $password);
$ds = new DuraStore($dcc);

// Create a content file.
$fp = tmpfile();
fwrite($fp, TEST_CONTENT_STRING);

// Create content.
$descriptor = new DuraCloudContentDescriptor(array('custommetadataname' => 'CustomMetadataValue'));
$content = new DuraCloudFileContent($descriptor);
$content->setResource($fp);
unset($fp);

// Store content.
$location = $ds->storeContent(
	$spaceId, $contentId,
	$content
);
if (!$location) die("Could not create content!\n");

// Clean up
unset($content, $descriptor);

// Check its metadata.
$descriptor = $ds->getContentMetadata($spaceId, $contentId);
if ($descriptor) $metadata = $descriptor->getMetadata();
else $metadata = null;
if (!$metadata) die("Could not read content metadata part 1!\n");
if ($metadata['custommetadataname'] != 'CustomMetadataValue') {
	die("Incorrect metadata part 1!\n");
}

// Reset its metadata.
$descriptor->setMetadata('custommetadataname', 'CustomMetadataNewValue');
$result = $ds->setContentMetadata($spaceId, $contentId, $descriptor);
if (!$result) die("Unable to set content metadata!\n");
unset($descriptor, $metadata);

// Check the results.
$content = $ds->getContent($spaceId, $contentId);
if ($content) $descriptor =& $content->getDescriptor();
else $descriptor = null;
if ($descriptor) $metadata = $descriptor->getMetadata();
else $metadata = null;
if (!$metadata) die("Could not read content metadata part 2!\n");
if ($metadata['custommetadataname'] != 'CustomMetadataNewValue') die("Incorrect metadata part 2!\n");

// Verify the contents.
$fp =& $content->getResource();
fseek($fp, 0);
$data = fread($fp, 9999);
$content->close();
if ($data != TEST_CONTENT_STRING) {
	die("Incorrect data read back!\n");
}

// Clean up.
if (!$ds->deleteContent($spaceId, $contentId)) die("Unable to delete content!\n");


echo "Success!\n";

?>
