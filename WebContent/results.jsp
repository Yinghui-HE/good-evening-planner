<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Good Evening</title>
		<link rel="stylesheet" type="text/css" href="results.css">
	</head>
	<body>
		<div id="header">
			<a href="index.jsp"><h1 style="display:inline-block">Good Evening</h1></a>
		</div>
		<div id="icon">
			<a href="profile.jsp"><img src="user.png" style="width: 50px; padding-right: 50px; margin-bottom: 0px; float: right;"></a>
		</div>
		<div id="body">
			<div id="title">
				<h2>Your Evening is Ready</h2>
				<h3>Are you?</h3>
			</div>
			<div id="results">
				<h2>Results</h2>
				<div id="eventItem">
					<div id="eventTitle">Spiderman: Homecoming</div>
					<div id="img"><img src="spiderman.jpg" style="height: 150px"></div>
					<div id="startTime">7:00pm</div>
					<div id="endTime">9:00pm</div>
					<div id="location">Location: LA Live</div>
					<div id="category">Category: Movie</div>
					<div id="subCat">Sub Category: Action</div>
				</div>
			</div>
			<div id="redo">
				<button id="retry" style="font-size: 24px;" onclick="retry();">Retry</button>
			</div>
			<div id="saveShare">
				<button id="share" style="font-size: 24px;">Share</button>
				<button id="save" style="font-size: 24px;"> Save</button>
			</div>
		</div>
		<div id="footer">
			<h6>CSCI201 Final Project</h6>
			<h6>Yinghui (Linda) He, Guancheng “Ivan” Qiu, Cameron Haseyama, Will DuCharme, Gaurav Malhotra</h6>	
		</div>
	</body>
	<script>
		function retry(){
			document.location.href = "planning.jsp";
		}
	</script>
</html>