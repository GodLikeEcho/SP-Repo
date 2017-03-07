<?php

  $jsonString = file_get_contents('php://input');
  $jsonArray = json_decode($jsonString, true);

  $UserName = $jsonArray['UserName'];
  //$fcName = $jsonArray['fcName'];

  if(empty($UserName))
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
  $stmt0 = $mysqli->query("SELECT UserName FROM fcReviews WHERE UserName = '$UserName'");
  $u = 1;
  $check0 = 1;

    //$rows = array();
    while($row0 = $stmt0->fetch_assoc())
    {
      $check0 = 2;
      $returnValue["u$u"] = $row0['UserName'];
      $u += 1;
    }
    if($check0 == 1)
    {
      $returnValue["u1"] = "False";
    }

  $stmt = $mysqli->query("SELECT Post FROM fcReviews WHERE UserName = '$UserName'");

  $n = 1;
  $check = 1;

    //$rows = array();
    while($row = $stmt->fetch_assoc())
    {
      $check = 2;
      $returnValue["p$n"] = $row['Post'];
      $n += 1;
    }
    if($check == 1)
    {
      $returnValue["p1"] = "False";
    }


    $stmt2 = $mysqli->query("SELECT Rating FROM fcReviews WHERE UserName = '$UserName'");
  // //
    $r = 1;
    $check2 = 1;
  // //
  // //   //$rows = array();
     while($row2 = $stmt2->fetch_assoc())
    {
      $check2 = 2;
      $returnValue["r$r"] = $row2['Rating'];
      $r += 1;
    }
    if($check2 == 1)
    {
      $returnValue["r1"] = "False";
    }
    //echo json_encode($returnValue2);
    echo json_encode($returnValue);
    return

  $mysqli->close();

?>
