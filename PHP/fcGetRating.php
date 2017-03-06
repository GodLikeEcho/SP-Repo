<?php

  $jsonString = file_get_contents('php://input');
  $jsonArray = json_decode($jsonString, true);

  $fcName = $jsonArray['fcName'];
  //$fcName = $jsonArray['fcName'];

  if(empty($fcName))
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
  $stmt = $mysqli->query("SELECT Rating FROM fcReviews WHERE fcName = '$fcName'");

  $n = 1;
  $check = 1;

    //$rows = array();
    while($row = $stmt->fetch_assoc())
		{
      $check = 2;
			$returnValue["$n"] = $row['Rating'];
			$n += 1;
		}
    if($check == 1)
    {
      $returnValue["1"] = "False";
    }
  echo json_encode($returnValue);
  return

  $mysqli->close();

?>
