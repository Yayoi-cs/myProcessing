<?php
function auth($inputName){
	$Name = empty(getenv('USER')) ? '' : getenv('USER');
	if (!isset($Name)){
		echo 'Your name please';
	} else {
		$result = strcmp($inputName, $Name);
		if (0 === $result){
            echo "Hello World ".$inputName;
        } else {
            echo "Who are you?";
		}
	}
}
auth("tsuneki");
?>