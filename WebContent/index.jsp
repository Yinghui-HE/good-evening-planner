<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Good Evening</title>
		<link rel="stylesheet" type="text/css" href="index.css">
	</head>
	
	<script>
	function CheckLogIn(){
		console.log("In checklogin")
		var username = document.getElementById("username").value;
		var password = document.getElementById("password").value;
		var xhttp = new XMLHttpRequest();
		xhttp.open("GET", "Servlet?log-in=true&username="+username+"&password="+password, true); 
		xhttp.onreadystatechange = function(){
			errorMessage = this.responseText;
			if(errorMessage.length != 0) {
				console.log(errorMessage)
				if(errorMessage.trim() == "success") {
					window.location.href = "planning.jsp";
				} else {
					document.getElementById("logInError").innerHTML = this.responseText;	
				}
				
			}
		}
		xhttp.send();
	}
	
	function Register(){
		console.log("In Register")
		var username = document.getElementById("username").value;
		var password = document.getElementById("password").value;
		var xhttp = new XMLHttpRequest();
		xhttp.open("GET", "Servlet?register=true&username="+username+"&password="+password, true); 
		xhttp.onreadystatechange = function(){
			errorMessage = this.responseText;
			if(errorMessage.length != 0) {
				console.log(errorMessage)
				if(errorMessage.trim() == "success") {
					window.location.href = "planning.jsp";
				} else {
					document.getElementById("registerError").innerHTML = this.responseText;	
				}
				
			}
		}
		xhttp.send();
	}
	
	function Guest() {
		console.log("In Guest");
		var xhttp = new XMLHttpRequest();
		xhttp.open("GET", "Servlet?guest=true", false); 
		xhttp.send();
		window.location.href = "planning.jsp";
	}
	</script>
	
	<%
	session = request.getSession();
	%>
	
	<body onload="loggedin()")>
		<div id="header">
			<a href="index.jsp"><h1 style="display: inline-block;">Good Evening</h1></a>
		</div>
		<div id="icon">
			<a href="profile.jsp"><img src="user.png" style="width: 50px; padding-right: 50px; margin-bottom: 0px; float: right;"/></a>
		</div>
		<br>
		<div id="body">
			<div id="authenticate">
				<form id="login" action="Servlet">
					<br/>
					<br/>
					<input type="text" id="username" value="username"><br/>
					<input type="text" id="password" value="password"><br/>
					<input type="button" value="LogIn" name="log-in" onclick="return CheckLogIn();">
					<input type="button" value="Register" name="register" onclick="return Register();">
					<br/>
					<input type="button" value="Continue as Guest" name="guest" onclick="return Guest();">
					<p id="logInError"></p>
					<p id="registerError"></p>
				</form>
			</div>
			
			<div id="title">
				<img src="icon.png" style="width: 150px;"/>
				<h2>Good Evening</h2>
				<h3>Let's make it a perfect night.</h3>
			</div>
			<div id="featured">
				<h2>Featured Events</h2>
			</div>
			<div id="reviews">
				<h2>Reviews</h2>
				<list>
					<li>The best app I've ever used!</li>
					<li>Easy and fun to use!</li>
					<li>Great way to plan a weekend.</li>
					<li>I've recommended this to all of my friends.</li>
				</list>
			</div>
		</div>
		<div id="footer">
			<h6>CSCI201 Final Project</h6>
			<h6>Yinghui (Linda) He, Guancheng “Ivan” Qiu, Cameron Haseyama, Will DuCharme, Gaurav Malhotra</h6>
			<h6>Fall 2018</h6>
		</div>
	</body>
</html>