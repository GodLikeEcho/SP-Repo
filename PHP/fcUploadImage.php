<?php

$UserName = $_POST["UserName"];
//$lastName = $_POST["lastName"];
//$userId = $_POST["userId"];

$target_dir = "/home2/godlikeecho/public_html/Images";
if(!file_exists($target_dir))
{
  mkdir($target_dir, 0777, true);
}

$target_dir = $target_dir . "/" . basename($_FILES["file"]["name"]);

if (move_uploaded_file($_FILES["file"]["tmp_name"], $target_dir))
{
  echo json_encode([
  "Message" => "The file ". basename( $_FILES["file"]["name"]). " has been uploaded.",
  "Status" => "OK",
  "UserName" => $_REQUEST["UserName"]
  ]);

}

else {

  echo json_encode([
    "Message" => "Sorry, there was an error uploading your file.",
    "Status" => "Error",
    "UserName" => $_REQUEST["UserName"]
  ]);
}
?>
