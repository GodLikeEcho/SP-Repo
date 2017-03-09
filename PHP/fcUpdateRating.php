<?php

  $jsonString = file_get_contents('php://input');
  $jsonArray = json_decode($jsonString, true);

  $fcName = $jsonArray['fcName'];
  $Rate = $jsonArray['Rate'];
  //$fcName = $jsonArray['fcName'];

  if(empty($fcName)||empty($Rate))
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

  $stmt2 =  $mysqli->query("UPDATE FoodCart SET fcRate= fcRate+'$Rate' where fcName = '$fcName'");

  $stmt =  $mysqli->query("SELECT fcRate FROM FoodCart where fcName = '$fcName'");
  $row = mysqli_fetch_array($stmt);
  $returnValue["Rate"] = $row['fcRate'];
  echo json_encode($returnValue);
  return

  $mysqli->close();

?>
