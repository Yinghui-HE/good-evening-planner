<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Good Evening</title>
		<link rel="stylesheet" type="text/css" href="results.css">
	</head>
	<%
	session = request.getSession();
	if(session.getAttribute("userID") != null) {
		int userID = (int)session.getAttribute("userID");
	%> 
	<%
	}
	%>
	<body>
		<div id="header">
			<p>User</p>
		</div>
		<div id="title">
			<h1>Your Evening is Ready</h1>
			<p>Are you?</p>
		</div>
		<div id="results">
			<h1>Results</h1>
		</div>
		<div id="saveShare">
			<form>
				<button>Share
				</button>
				<button> Save
				</button>
			</form>
		</div>
		<div id="footer">
			<h6>CSCI201 Final Project</h6>
			<h6>Yinghui (Linda) He, Guancheng “Ivan” Qiu, Cameron Haseyama, Will DuCharme, Gaurav Malhotra</h6>	
		</div>
	</body>
</html>