<?php

class dcdal
{

	public static function RegisterUser($UserName, $Password, $Email, $PrivLevel)
	{
		$mysqli = new mysqli("localhost", "godlikee_admin", "administrator", "godlikee_foodcart");
		//$pswrd = password_hash('$Password', PASSWORD_BCRYPT);
		if($stmt = $mysqli->prepare("INSERT INTO Users (UserName, Password, Email, PrivLevel)
			VALUES (?, ?, ?, ?);"))
			{
				$stmt->bind_param('sssi', $UserName, $Password, $Email, $PrivLevel);
				if($stmt->execute()) {
					$success = true;
				}
				else{
					//printf(mysqli_stmt_error($stmt));
				}
				$stmt->close();
			}
		$mysqli->close();
	}

	public static function CheckUser($UserName)
	{
		$retVal = true;
		$mysqli = new mysqli("localhost", "godlikee_admin", "administrator", "godlikee_foodcart");

		if ($mysqli->connect_errno)
		{
			printf("Connect failed: %s\n", $mysqli->connect_error);
			exit();
		}

		if ($result = $mysqli->query("SELECT * FROM Users WHERE UserName = '$UserName'"))
		{
			if($result->num_rows > 0)
				$retVal = true;
			else $retVal = false;

			/* free result set */
			$result->close();
		}
		$mysqli->close();
		return $retVal;
	}

	public static function CheckLogin($UserName, $PassWord)
	{
		$retVal = true;
		$mysqli = new mysqli("localhost", "godlikee_admin", "administrator", "godlikee_foodcart");

		if ($mysqli->connect_errno)
		{
			printf("Connect failed: %s\n", $mysqli->connect_error);
			exit();
		}

		$test = $mysqli->query("SELECT Password FROM Users WHERE UserName = '$UserName'");
		$row = mysqli_fetch_array($test);

		$salt = $row['Password'];

		if (strcmp($salt, $PassWord) == 0)
		{
				$retVal = true;
		}
		else $retVal = false;
		$mysqli->close();
		return $retVal;
	}



	public static function BanAccount($UserName)
	{
		$retVal = false;
		$mysqli = new mysqli("localhost", "godlikee_admin", "administrator", "godlikee_foodcart");

		if($mysqli->connect_errno)
		{
			printf("Connect Failed: %s\n", $mysqli->connect_error);
			exit();
		}

		$result = $mysqli->query("SELECT UserID FROM Users WHERE UserName = '$UserName'");
		if (!$result) {
  		echo 'Could not run query: ' . mysql_error();
  		exit;
		}

		$UserID = mysql_fetch_row($result);
		echo $UserID[0];
		//$UserID = "505";
		$mysqli->query("UPDATE Users SET Active='0' WHERE UserID = '$UserID[0]'");

		if($stmt = $mysqli->prepare("INSERT INTO BanList (UserID, UserName, BannedBy, ReasonBanned, BannedTil) VALUES ( ?, ?, ?, ?, ?"))
		{

			$stmt->bind_param('issss', $UserID[0], $Player, $ReqID, $Reason, $Days);
			if($stmt->execute())
			{
				$retVal = true;
			}
			else
			{
				//printf(mysqli_stmt_error($stmt));
				$retVal = false;
			}
			$result->close();
			$stmt->close();
		return $retVal;
		}
}

	public static function CheckAccountLevel($UserName, $PassWord)
	{

		$mysqli = new mysqli("localhost", "godlikee_admin", "administrator", "godlikee_foodcart");

		if ($mysqli->connect_errno)
		{
			printf("Connect failed: %s\n", $mysqli->connect_error);
			exit();
		}
		$PrivLevel = "u";
		$test = $mysqli->query("SELECT Password FROM Users WHERE UserName = '$UserName'");
		$row = mysqli_fetch_array($test);

		$salt = $row['Password'];

		if (strcmp($salt, $PassWord) == 0)
		{
				$test2 = $mysqli->query("SELECT PrivLevel FROM Users WHERE UserName = '$UserName'");
				$row2 = mysqli_fetch_array($test2);
				$faction = $row2['PrivLevel'];
		}
		else {
			$returnValue["Login"] = "error";
			$returnValue["message"] = "Passwords did not match";
			echo json_encode($returnValue);
			return;
		}

		$mysqli->close();
		return $faction;
	}

?>
