<?php

  $jsonString = file_get_contents('php://input');
  $jsonArray = json_decode($jsonString, true);

  $name = $jsonArray['name'];
  $address = $jsonArray['address'];
  $hours = $jsonArray['hours'];
  $rating = $jsonArray['rating'];


  if(empty($name)||empty($address)||empty($hours)||empty($rating))
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


?>
