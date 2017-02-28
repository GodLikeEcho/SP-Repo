<?php
  $jsonString = file_get_contents('php://input');
  $jsonArray = json_decode($jsonString, true);

  $UserName = $jsonArray['UserName'];
  $fcName = $jsonArray['fcName'];
  $Post = $jsonArray['Post'];

  if(empty($UserName)||empty($fcName)||empty($Post))
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
    if($stmt = $mysqli->prepare("INSERT INTO fcPosts (Name, Owner, Post)
      VALUES (?, ?, ?);"))
      {
        $stmt->bind_param('sss', $fcName, $UserName, $Post);
        if($stmt->execute()) {
          $success = true;
          $returnSuccess["message"] = "Post Uploaded";
          echo json_encode($returnSuccess);
          return;
        }
        else{
          $returnValues["message"] = "Unable to Post";
          echo json_encode($returnValues);
          return;
        }
      }
      $stmt->close();
    }
    else {
      $returnError["status"] = "error";
      $returnError["message"] = "User $UserName is not owner";
      echo json_encode($returnError);
      return;
    }
  $mysqli->close();

?>
