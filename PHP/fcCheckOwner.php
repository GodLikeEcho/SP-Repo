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

  $test0 = $mysqli->query("SELECT UserName FROM FoodCart WHERE fcName = '$fcName'");
  $row0 = mysqli_fetch_array($test0);
  $salt0 = $row0['UserName'];

  if (strcmp($salt0, $UserName) == 0)
  {
    $returnValue = "true";
    echo json_encode($returnValue);
    return;
  }

  else
  {
    $returnError = "false";
    echo json_encode($returnError);
    return;

  }

  $mysqli->close();

?>
