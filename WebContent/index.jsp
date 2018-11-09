<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
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
		xhttp.send();
		
	}
	</script>
	
	<%
	session = request.getSession();
	%>

	<body>
		<div id="header">
			<p>User</p>
		</div>
		<div id="authenticate">
			<form id="login" action="Servlet">
				<input type="text" id="username" name="username" required><br/>
				<input type="text" id="password" name="password" required><br/>
				<input type="button" value="LogIn" name="log-in" onclick="return CheckLogIn();">
				<input type="submit" value="Register" name="register">
				<input type="submit" value="Continue as Guest" name="guest">
				<% if(session.getAttribute("ErrorMessage") != null){
					String error = (String)session.getAttribute("ErrorMessage");
					System.out.println(error + "in jsp");

					if(error.length() > 0) {
			%>
					<span id="errorMessage"><%= error%></span>
			<%
					}
			}

			%>
			</form>
		</div>
		<div id="title">
			<h1>Good Evening</h1>
			<h2>Let's make it a perfect night.</h2>
		</div>
		<div id="featured">
			<h1>Featured Events</h1>
		</div>
		<div id="reviews">
			<h3>Reviews:</h3>
			<p>The best app I've ever used!</p>
			<p>Easy and fun to use!</p>
		</div>
		<div id="footer">
			<h6>CSCI201 Final Project</h6>
			<h6>Yinghui (Linda) He, Guancheng “Ivan” Qiu, Cameron Haseyama, Will DuCharme, Gaurav Malhotra</h6>
			
		</div>
	</body>
</html>