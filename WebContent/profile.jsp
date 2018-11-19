<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Good Evening</title>
		<link rel="stylesheet" type="text/css" href="profile.css">
	</head>
	<body>
		<div id="header">
			<p>User</p>
		</div>
		<div id="evenings">
		
		</div>
		<div id="pokes">
			<h2>Notifications</h2>
		</div>
		<div id="footer">
			<h6>CSCI201 Final Project</h6>
			<h6>Yinghui (Linda) He, Guancheng “Ivan” Qiu, Cameron Haseyama, Will DuCharme, Gaurav Malhotra</h6>
		</div>
	</body>
	<script>
	//loadTable();
	function loadTable() {
		//Filling in the past evenings table
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			console.log(xhttp.responseText);
			console.log("hi");
			//document.getElementsByClassName("tablediv")[0].innerHTML = xhttp.responseText;
			console.log("Received: " + xhttp.responseText);
			document.getElementById("evenings").innerHTML = xhttp.responseText;
		}
		xhttp.open("GET", "Servlet?displayHistory=true", true);
		xhttp.send();
	};
	
	function guestDiplay(){
		console.log("hi");
		document.getElementById("evenings").innerHTML = "<h1>Past Evenings</h1><br><h6>Log into an account to see your past evenings</h6>"
	};
		
	</script>
	
	
	<%
	session = request.getSession();
	if(session.getAttribute("userID") != null) {
		int userID = (int)session.getAttribute("userID");	
	%> 
	<script>
	document.getElementById("evenings").innerHTML = "<h1>Past Evenings</h1><br><h4>Log into an account to see your past evenings</h4>"
	</script>
	<%
	} else{
		%>
	<script>
		guestDisplay();
	</script>
	<% 
	}
	%>
	
	
</html>