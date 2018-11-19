<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import="goodevening.ServerSocket.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Good Evening</title>
		<link rel="stylesheet" type="text/css" href="profile.css">
		
		<script>
			function logOut(){
				if(session.getAttribute("userID") == null){
					var xhttp = new XMLHttpRequest();
					xhttp.open("GET", "Servlet?logOutUser=true", true); 
					xhttp.send();
					window.location.href="index.jsp"
				}
			}
		</script>
		<script>
    		var socket;
    
			function connectToServer() {
			    socket = new WebSocket("ws://localhost:8080/good-evening-planner/ws");
			    socket.onopen = function(event) {
			        //document.getElementById("newsfeed").innerHTML += "Connected!";
			    }
			    socket.onmessage = function(event) {
			        //location.reload();
			        document.getElementById("pokes").innerHTML += event.data + "<br/>";
			        
			    }
			    socket.onclose = function(event) {
			        //document.getElementById("mychat").innerHTML += "Disconnected!";
			    }
			}
			function sendMessage() {
			    console.log(document.chatform.message.value + " Poked!");
			    socket.send(document.chatform.message.value + " Poked!");
			    return false;
			}
			</script>
	</head>
	<body onload="connectToServer()">
		<div id="header">
			<a href="index.jsp"><h1 style="display: inline-block;">Good Evening</h1></a>
		</div>
		<div id="icon">
			<a href="profile.jsp"><img src="user.png" style="width: 50px; padding-right: 50px; margin-bottom: 0px; float: right;"/></a>
		</div>
		<br>
		<div id="body">
			<div id="evenings">
			
			</div>
			<div id="pokes">
				<h2>Notifications</h2>
			</div>
			<div id = "share">
				<form name="chatform" onsubmit="return sendMessage();">
				<input type="text" name="message" value="Type Here" /><br />
				<input type="submit" name="submit" value="Send Message"/><br />
				</form>
			</div>
			<div id="logout">
				<button style="float: right;" onclick="logOut()">Log Out</button>
			</div>
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