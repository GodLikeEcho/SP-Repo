<?php

  $jsonString = file_get_contents('php://input');
  $jsonArray = json_decode($jsonString, true);

  $username = $jsonArray['UserName'];
  $password = $jsonArray['Password'];

  if(empty($username)||empty($password))
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

  $test0 = $mysqli->query("SELECT UserName FROM Users WHERE UserName = '$username'");
  $row0 = mysqli_fetch_array($test0);
  $salt0 = $row0['UserName'];

  if (strcmp($salt0, $username) == 0)
  {
    $test = $mysqli->query("SELECT Password FROM Users WHERE UserName = '$username'");
    $row = mysqli_fetch_array($test);

    $salt = $row['Password'];

    if (strcmp($salt, $password) == 0)
    {
        $test2 = $mysqli->query("SELECT PrivLevel FROM Users WHERE UserName = '$username'");
        $row2 = mysqli_fetch_array($test2);
        $privlevel = $row2['PrivLevel'];
        //$privlevel["PrivLevel"] = "This is the option";
        echo json_encode($privlevel);
        return;
    }
    else {
      $returnValue["Login"] = "error";
      $returnValue["message"] = "Passwords did not match";
      echo json_encode($returnValue);
      return;
    }
  }
  else {
    $returnValues["Login"] = "error";
    $returnValues["message"] = "UserName was not found";
    echo json_encode($returnValues);
    return;
  }

  $mysqli->close();

?>
