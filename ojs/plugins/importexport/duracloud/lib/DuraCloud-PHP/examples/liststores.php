<?php

/**
 * @file liststores.php
 *
 * Copyright (c) 2011 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Connect to a DuraCloud server and get a list of stores.
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

if (count($argv) != 4) {
	echo "Usage:\n";
	echo array_shift($argv) . " [DuraCloud base URL] [username] [password]\n";
	exit(-2);
}

// Get arguments.
$exampleName = array_shift($argv);
$baseUrl = array_shift($argv);
$username = array_shift($argv);
$password = array_shift($argv);

// Try a connection.
$dcc = new DuraCloudConnection($baseUrl, $username, $password);
$ds = new DuraStore($dcc);
$stores = $ds->getStores();

if ($stores !== false) {
	echo "The list of stores is:\n";
	foreach ($stores as $store) {
		echo " $store[id]: $store[storageProviderType]";
		if ($store['primary']) echo ' (Primary)';
		echo "\n";
	}
	echo "\n";
} else {
	echo "The list of stores could not be fetched. Check your credentials.\n";
	exit(-3);
}

?>
