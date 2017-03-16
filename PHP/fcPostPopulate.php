<?php

  $jsonString = file_get_contents('php://input');
  $jsonArray = json_decode($jsonString, true);

  $UserName = $jsonArray['UserName'];
  $fcName = $jsonArray['fcName'];

  if(empty($UserName) || empty($fcName))
  {
      $returnValue["status"] = "error";
      $returnValue["message"] = "Missing required field";
      echo json_encode($returnValue);
      return;
  }

  $mysqli = new mysqli("localhost", "godlikee_admin", "administrator", "godlikee_foodcart");

  if ($mysqli->connect_errno)
  {
    printf("Connect failed: %s\n", $mysqli->connect_error);
    exit();
  }
  //$return = array();
  $stmt = $mysqli->query("SELECT Post FROM fcPosts WHERE Name = '$fcName'");

  $n = 1;
  $p = "p";
  $found = "false";
    $rows = array();
    while($row = $stmt->fetch_assoc())
		{
      $found = "true";
			$returnValue["$n"] = $row['Post'];
			$n += 1;
		}
  if($found == "false")
  {
    $returnValue["status"] = "No posts found";
  }
  echo json_encode($returnValue);
  return

  $mysqli->close();

?>
