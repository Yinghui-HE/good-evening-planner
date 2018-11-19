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
	</head>
	<%
	session = request.getSession();
	if(session.getAttribute("userID") != null) {
		int userID = (int)session.getAttribute("userID");
	%> 
	<%
	}
	%>
<%-- <% List<Event> events = (ArrayList<Event>)request.getAttribute("result");
 
	if(events != null){
	    for(Event e : events)
	    {
	        %> <h1>Success</h1>
	        <%
	    }
	}
	else{
        %> <h1>Fail</h1>
        <%
	}
 
%> --%>
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
							%> 	 	<div id="eventItem">
										<div id="eventTitle">Summary: <%= e.getSummary()%></div>
										<div id="img"></div>
										<div id="startTime">Start Time: <%= e.getStartTime()%></div>
										<div id="endTime">End Time: <%= e.getEndTime()%></div>
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