<?php
  $jsonString = file_get_contents('php://input');
  $jsonArray = json_decode($jsonString, true);

  $UserName = $jsonArray['UserName'];
  $fcName = $jsonArray['fcName'];


  if(empty($UserName)||empty($fcName))
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

  $test0 = $mysqli->query("SELECT Favorite FROM ucFavorites WHERE UserName = '$UserName' AND Favorite = '$fcName'");
  $row0 = mysqli_fetch_array($test0);
  $salt0 = $row0['Favorite'];

  if (strcmp($salt0, $fcName) == 0)
  {
    $stmt1 = $mysqli->query("DELETE FROM ucFavorites WHERE UserName = '$UserName' AND Favorite = '$fcName'");
    $returnValue["Status:"] = "Removed Favorite";
    echo json_encode($returnValue);
  }

  else
  {
    if($stmt = $mysqli->prepare("INSERT INTO ucFavorites (UserName, Favorite)
      VALUES (?, ?);"))
      {
        $stmt->bind_param('ss', $UserName, $fcName);
        if($stmt->execute()) {
          $success = true;
          $returnSuccess["message"] = "Favorite Added";
          echo json_encode($returnSuccess);
          return;
        }
        else{
          $returnValues["message"] = "Unable to add favorite";
          echo json_encode($returnValues);
          return;
        }
      }
      $stmt->close();
  }

  $mysqli->close();

?>
