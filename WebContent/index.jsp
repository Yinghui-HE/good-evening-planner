<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Good Evening</title>
		<link rel="stylesheet" type="text/css" href="index.css">
	</head>
	<body>
		<div id="header">
			<p>User</p>
		</div>
		<div id="authenticate">
			<form id="login" action="PlanningServlet">
				<input type="text" id="username" name="username"><br/>
				<input type="text" id="password" name="password"><br/>
				<input type="hidden" id="field" name="field" value=log-in>
				<input type="submit" value="Submit">
			</form>
			<form id="register">
				<input type="submit" value="Register">
			</form>
			<form id="guest">
				<input type="submit" value="Continue as Guest">
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