
<?php

  $jsonString = file_get_contents('php://input');
  $jsonArray = json_decode($jsonString, true);

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

  $stmt = $mysqli->query("Select Post from fcPosts where id in(SELECT MAX(id) FROM fcPosts WHERE Name = '$fcName')");//AND id = '$salt0'

  $n = 1;
  $check = 1;
  while($row = $stmt->fetch_assoc())
  {
    $check = 2;
    $returnValue["$n"] = $row['Post'];
    $n += 1;
  }
  if ($check == 1)
  {
      $$returnValue["False"] = "I have no idea";
  }

  echo json_encode($returnValue);
  return

  $mysqli->close();

?>
