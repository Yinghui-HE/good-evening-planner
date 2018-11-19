<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import="goodevening.Event" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Good Evening</title>
		<link rel="stylesheet" type="text/css" href="results.css">
		<%
		session = request.getSession();
		if(session.getAttribute("userID") != null) {
			int userID = (int)session.getAttribute("userID");
		%> 
		<script>
		console.log("userID in result.jsp: " + <%= userID%>);
		</script>
		<%
		}
		%>
		<script>
			function save(eveningID, userID){
				if(userID != -1) {
					var xhttp = new XMLHttpRequest();
					xhttp.open("GET", "Servlet?save=true", false); 
					xhttp.onreadystatechange = function(){
						window.location.href = "profile.jsp";
					}
					xhttp.send();
				}
				else
				{
					document.getElementById("saveError").innerHTML = "You need to log in to save the evening.";
				}
				
			}
			function retry(){
				document.location.href = "planning.jsp";
			}
		</script>
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
				<div id="events">
					<%
						if(session.getAttribute("result") != null){
							ArrayList<Event> events = (ArrayList<Event>)session.getAttribute("result");
							for(int i = 0; i < events.size(); i++){
							Event e = events.get(i);
							String start =  Integer.toString(e.getStartTime());
							String startTime = start.substring(0,2) + ":" + start.substring(2);
							String end =  Integer.toString(e.getEndTime());
							String endTime = end.substring(0,2) + ":" + end.substring(2);
							%> 	 	<div id="eventItem">
										<div id="eventTitle">Summary: <%= e.getSummary()%></div>
										<div id="img"><img src=<%= e.getImage() %>></div>
										<div id="startTime">Start Time: <%= startTime%></div>
										<div id="endTime">End Time: <%= endTime%></div>
				 						<div id="location"> <%= e.getLocation()%></div>
										<div id="category">Category: <%= e.getCategory()%></div>
										<div id="subCat">Sub Category: <%= e.getSubcategory()%></div>
									</div>
					        <%
						}}else{
							%> <h1>No Events Found</h1>
					        <%
						}
					%>
				</div>
			</div>
			<div id="saveShare">
				<button id="retry" style="font-size: 24px;" onclick="retry();">Retry</button>
				<%
				if(session.getAttribute("eveningID") != null) {
					int eveningID = (int)session.getAttribute("eveningID");
					int userID = (int)session.getAttribute("userID");
				%>
				
				<button id="save" style="font-size: 24px;" onclick="save(<%=eveningID%>, <%=userID%>)"> Save</button>
				<%	
				}
				%>
				<h4 id="saveError"></h4>
			</div>
		</div>
		<div id="footer">
			<h6>CSCI201 Final Project</h6>
			<h6>Yinghui (Linda) He, Guancheng “Ivan” Qiu, Cameron Haseyama, Will DuCharme, Gaurav Malhotra</h6>	
		</div>
	</body>
</html>