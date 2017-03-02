<?php

  $jsonString = file_get_contents('php://input');
  $jsonArray = json_decode($jsonString, true);


  $fcName = $jsonArray['fcName'];
  $fcTimeDay = $jsonArray['$fcTimeDay'];

  if(empty($fcName) || empty($fcTimeDay))
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
  $stmt = $mysqli->query("SELECT fcName, $fcTimeDay, fcAdd1, fcRate FROM FoodCart WHERE fcName = '$fcName'");

  //$n = 1;
  //$p = "p";

    $rows = array();
    while($row = $stmt->fetch_assoc())
		{
			$returnValue["fcName"] = $row['fcName'];
      $returnValue["fcDay"] = $row[$fcTimeDay];
      $returnValue["fcAdd1"] = $row['fcAdd1'];
      $returnValue["fcRate"] = $row['fcRate'];
			//$n += 1;
		}

  echo json_encode($returnValue);
  return

  $mysqli->close();

?>
