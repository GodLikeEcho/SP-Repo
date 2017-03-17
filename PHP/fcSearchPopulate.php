<?php
  $jsonString = file_get_contents('php://input');
  $jsonArray = json_decode($jsonString, true);

  $UserName = $jsonArray['UserName'];
  $fcName = $jsonArray['fcName'];
  $fSearch = $jsonArray['fSearch'];
  //$fcName = $jsonArray['fcName'];

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
  $found = "false";
  $test0 = $mysqli->query("SELECT UserName FROM FoodCart WHERE fcName = '$fcName'");
  while($row0 = $test0->fetch_assoc()){
    if($row0 == $UserName) {
        $found = "true";
    }
  }
  $check = 0;
  if($found == "true")
  {
    $stmt0 = $mysqli->query("SELECT (fcRate/RevCount) AS calcRate FROM FoodCart WHERE UserName = '$UserName'");
    $row0 = mysqli_fetch_array($stmt0);
    $returnValue["calcRate"] = $row0['calcRate'];
    $returnValue["Owner"] = "true";
    //   //echo json_encode($returnValue);
    //   //return;
    $stmt = $mysqli->query("SELECT * FROM FoodCart WHERE UserName = '$UserName'");
    //$result  = $mysqli->query($stmt);
    //$row = mysqli_fetch_array($test0);
    while($row = $stmt->fetch_assoc()){
      //$returnValue["UserName"] = $row['UserName'];
      $returnValue["fcName"] = $row['fcName'];
      $returnValue["fcAdd1"] = $row['fcAdd1'];
      $returnValue["fcAdd2"] = $row['fcAdd2'];
      $returnValue["fcAdd3"] = $row['fcAdd3'];
      $returnValue["fcMon"] = $row['fcMon'];
      $returnValue["fcTue"] = $row['fcTue'];
      $returnValue["fcWed"] = $row['fcWed'];
      $returnValue["fcThu"] = $row['fcThu'];
      $returnValue["fcFri"] = $row['fcFri'];
      $returnValue["fcSat"] = $row['fcSat'];
      $returnValue["fcSun"] = $row['fcSun'];
      $returnValue["fcRate"] = $row['fcRate'];
      $check = 1;
    }
  }

  else
  {
    $returnValue["Owner"] = "false";
    //echo json_encode($returnValue);
    //return;
    $stmt0 = $mysqli->query("SELECT (fcRate/RevCount) AS calcRate FROM FoodCart WHERE fcName = '$fSearch'");
    $row0 = mysqli_fetch_array($stmt0);
    $returnValue["calcRate"] = $row0['calcRate'];
    $stmt1 = $mysqli->query("SELECT * FROM FoodCart WHERE fcName = '$fcName'");
    //$result  = $mysqli->query($stmt);
    //$row = mysqli_fetch_array($test0);
    while($row1 = $stmt1->fetch_assoc()){
      //$returnValue["UserName"] = $row1['UserName'];
      $returnValue["fcName"] = $row1['fcName'];
      $returnValue["fcAdd1"] = $row1['fcAdd1'];
      $returnValue["fcAdd2"] = $row1['fcAdd2'];
      $returnValue["fcAdd3"] = $row1['fcAdd3'];
      $returnValue["fcMon"] = $row1['fcMon'];
      $returnValue["fcTue"] = $row1['fcTue'];
      $returnValue["fcWed"] = $row1['fcWed'];
      $returnValue["fcThu"] = $row1['fcThu'];
      $returnValue["fcFri"] = $row1['fcFri'];
      $returnValue["fcSat"] = $row1['fcSat'];
      $returnValue["fcSun"] = $row1['fcSun'];
      $returnValue["fcRate"] = $row1['fcRate'];
      $check = 1;
    }

  }

  if($check == 0)
  {
    $returnValues["found"] = "false";
    echo json_encode($returnValues);
    return;
  }
  else {
    $returnValue["found"] = "true";
  }


  echo json_encode($returnValue);
  return
  $mysqli->close();

?>
