<?php
	$style = $_GET['style'];
	setcookie("style", $style, time()+604800);
	if(isset($_GET['js'])) {
		echo $style; 
	} else {
		header("Location: ".$_SERVER['HTTP_REFERER']);
	}
?>