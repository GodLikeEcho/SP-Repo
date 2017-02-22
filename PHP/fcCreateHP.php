<?php
  $jsonString = file_get_contents('php://input');
  $jsonArray = json_decode($jsonString, true);

  $UserName = $jsonArray['UserName'];
  $fcName = $jsonArray['fcName'];
  $fcAdd1 = $jsonArray['fcAdd1'];
  $fcAdd2 = $jsonArray['fcAdd2'];
  $fcAdd3 = $jsonArray['fcAdd3'];
  $fcMon = $jsonArray['fcMon'];
  $fcTue = $jsonArray['fcTue'];
  $fcWed = $jsonArray['fcWed'];
  $fcThu = $jsonArray['fcThu'];
  $fcFri = $jsonArray['fcFri'];
  $fcSat = $jsonArray['fcSat'];
  $fcSun = $jsonArray['fcSun'];
  $fcRate = $jsonArray['fcRate'];

  if(empty($UserName)||empty($fcName)||empty($fcAdd1)||empty($fcAdd2)
  || empty($fcAdd3)||empty($fcMon)||empty($fcTue)||empty($fcWed)
  || empty($fcThu)||empty($fcFri)||empty($fcSat)||empty($fcSun)||empty($fcRate))
  {
      //$returnValue["UserName"] = $UserName;
      //$returnValue["Password"] = $Password;
      //$returnValue["Email"] = $Email;
      //$returnValue["PrivLevel"] = $PrivLevel;
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

  $test0 = $mysqli->query("SELECT UserName FROM FoodCart WHERE UserName = '$UserName'");
  $row0 = mysqli_fetch_array($test0);
  $salt0 = $row0['UserName'];

  if (strcmp($salt0, $UserName) == 0)
  {
    //$returnError["status"] = "error";
    //$returnError["message"] = "UserName $UserName already exists";
    //echo json_encode($returnError);
    //return;
    if($stmt1 = $mysqli->prepare("UPDATE FoodCart SET fcName = ?, fcAdd1 = ?, fcAdd2 = ?, fcAdd3 =?, fcMon = ?, fcTue = ?, fcWed = ?, fcThu = ?, fcFri = ?, fcSat = ?, fcSun = ?, fcRate = ? WHERE UserName = ?"))
    {
        $stmt1->bind_param('sssssssssssss', $fcName, $fcAdd1, $fcAdd2, $fcAdd3, $fcMon, $fcTue, $fcWed, $fcThu, $fcFri, $fcSat, $fcSun, $fcRate, $UserName);
        if($stmt1->execute()) {
          $success1 = true;
          $returnSuccess1["message"] = "Page Updated";
          echo json_encode($returnSuccess1);
          return;
        }
        else{
          $returnValues1["message"] = "Unable to update page";
          echo json_encode($returnValues1);
          return;
        }
      }
      $stmt1->close();
  }

  else
  {
      if($stmt = $mysqli->prepare("INSERT INTO FoodCart (UserName, fcName, fcAdd1, fcAdd2, fcAdd3, fcMon, fcTue, fcWed, fcThu, fcFri, fcSat, fcSun, fcRate)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);"))
        {
          $stmt->bind_param('sssssssssssss', $UserName, $fcName, $fcAdd1, $fcAdd2, $fcAdd3, $fcMon, $fcTue, $fcWed, $fcThu, $fcFri, $fcSat, $fcSun, $fcRate);
          if($stmt->execute()) {
            $success = true;
            $returnSuccess["message"] = "Page Created";
            echo json_encode($returnSuccess);
            return;
          }
          else{
            $returnValues["message"] = "Unable to create page";
            echo json_encode($returnValues);
            return;
          }
        }
        $stmt->close();
  }

  $mysqli->close();

?>
