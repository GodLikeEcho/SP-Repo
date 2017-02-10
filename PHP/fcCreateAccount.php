<?php
  $jsonString = file_get_contents('php://input');
  $jsonArray = json_decode($jsonString, true);

  $UserName = $jsonArray['UserName'];
  $Password = $jsonArray['Password'];
  $Email = $jsonArray['Email'];
  $PrivLevel = $jsonArray['PrivLevel'];


  if(empty($UserName)||empty($Password)||empty($Email)||empty($PrivLevel))
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

  $test0 = $mysqli->query("SELECT UserName FROM Users WHERE UserName = '$UserName'");
  $row0 = mysqli_fetch_array($test0);
  $salt0 = $row0['UserName'];

  if (strcmp($salt0, $UserName) == 0)
  {
    $returnError["status"] = "error";
    $returnError["message"] = "UserName $UserName already exists";
    echo json_encode($returnError);
    return;
  }

  else
  {
    $test1 = $mysqli->query("SELECT Email FROM Users WHERE Email = '$Email'");
    $row1 = mysqli_fetch_array($test1);
    $salt1 = $row1['Email'];

    if (strcmp($salt1, $Email) == 0)
    {
      $returnError["status"] = "error";
      $returnError["message"] = "Email $Email already in use";
      echo json_encode($returnError);
      return;
    }
    else {

      if($stmt = $mysqli->prepare("INSERT INTO Users (UserName, Password, Email, PrivLevel)
        VALUES (?, ?, ?, ?);"))
        {
          $stmt->bind_param('ssss', $UserName, $Password, $Email, $PrivLevel);
          if($stmt->execute()) {
            $success = true;
            $returnSuccess["message"] = "Account Created";
            echo json_encode($returnSuccess);
            return;
          }
          else{
            $returnValues["message"] = "Unable to create account";
            echo json_encode($returnValues);
            return;
          }
        }
        $stmt->close();
      }
  }

  $mysqli->close();

?>
