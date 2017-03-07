//SELECT MAX(id) FROM fcPosts WHERE Name = 'fc42'

<?php

  $jsonString = file_get_contents('php://input');
  $jsonArray = json_decode($jsonString, true);

  //$UserName = $jsonArray['UserName'];
  $fcName = $jsonArray['fcName'];

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

  $test0 = $mysqli->query("SELECT MAX(id) FROM fcPosts WHERE Name = '$fcName'");
  $row0 = mysqli_fetch_array($test0);
  $salt0 = $row0['id'];

  $stmt = $mysqli->query("SELECT Post FROM fcPosts WHERE Name = '$fcName' AND id = '$salt0'");
  $row = mysqli_fetch_array($stmt);
  $returnValue["Post"] = $row['Post']

  echo json_encode($returnValue);
  return

  $mysqli->close();

?>
