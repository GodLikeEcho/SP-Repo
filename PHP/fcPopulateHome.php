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
    $returnValue["Owner"] = "true";
    //echo json_encode($returnValue);
    //return;
  }

  else
  {
    $returnValue["Owner"] = "false";
    //echo json_encode($returnValue);
    //return;

  }

  $stmt = $mysqli->query("SELECT * FROM FoodCart WHERE fcName = '$fcName'");
  //$result  = $mysqli->query($stmt);
  //$row = mysqli_fetch_array($test0);
  while($row = $stmt->fetch_assoc()){
    $returnValue["UserName"] = $row['UserName'];
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
}

  echo json_encode($returnValue);
//   if (mysql_num_rows($stmt) > 0) {
//     while ($row = mysql_fetch_assoc($stmt)) {
//       $returnValue["UserName"] = $row["UserName"];
//       $returnValue["fcName"] = $row["fcName"];
//       echo json_encode($returnValue);
//     }
// }

  // if($result ->num_rows > 0)
  // {
  //   while($row = $result->fetch_assoc()) {
  //       $returnValue["UserName"] = $row["UserName"];
  //       $returnValue["fcName"] = $row["fcName"];
  //       echo json_encode($returnValue);
  //   }
  // }

  return
  $mysqli->close();

?>
