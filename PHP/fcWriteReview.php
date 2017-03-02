<?php
  $jsonString = file_get_contents('php://input');
  $jsonArray = json_decode($jsonString, true);

  $UserName = $jsonArray['UserName'];
  $fcName = $jsonArray['fcName'];
  $Post = $jsonArray['Post'];
  $Rate = $jsonArray['Rate'];

  if(empty($UserName)||empty($fcName)||empty($Post)||empty($Rate))
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

  $test0 = $mysqli->query("SELECT UserName FROM fcReviews WHERE UserName = '$UserName'");
  $row0 = mysqli_fetch_array($test0);
  $salt0 = $row0['UserName'];

  if (strcmp($salt0, $UserName) == 0)
  {
    $returnError["message"] = "$UserName already reviewed this cart";
    echo json_encode($returnError);
    return;
  }
    else {

      if($stmt = $mysqli->prepare("INSERT INTO fcReviews (UserName, fcName, Post, Rating)
        VALUES (?, ?, ?, ?);"))
        {
          $stmt->bind_param('ssss', $UserName, $fcName, $Post, $Rate);
          if($stmt->execute()) {
            $success = true;
            $returnSuccess["message"] = "Review Uploaded";
            echo json_encode($returnSuccess);
            return;
          }
          else{
            $returnValues["message"] = "Unable to upload Review";
            echo json_encode($returnValues);
            return;
          }
        }
        $stmt->close();
    }
  $mysqli->close();

?>
