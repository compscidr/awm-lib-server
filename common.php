<?php
require_once("config.php");

function attemptConnect() {
  $mysqli = new mysqli(HOST, USERNAME, PASSWORD, DBNAME);
  return $mysqli;
}

//http://www.onurguzel.com/storing-mac-address-in-a-mysql-database/
function macstringtobigint($mac) {
  //strip out the colons from the mac address string
  $base10mac = str_replace(":", "", $mac);

  return base_convert($base10mac, 16, 10);
}

?>
