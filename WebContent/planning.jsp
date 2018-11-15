<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Good Evening</title>
		<link rel="stylesheet" type="text/css" href="planning.css">
	</head>
	<script>
		function submitPlan(){
			console.log("In submitPlan");
			//Error Check Submission Fields
			var error = "false"; 
			var timeError = "false";
			
			//Validate Start and End Time Values
			var eveningStart = document.getElementById("eveningStart").value;
			if(eveningStart == ""){
				document.getElementById("startError").innerHTML = "Please choose a start time.";
				console.log("invalid start time");
				error = "true";
				timeError = "true";
			}
			else{
				console.log("valid start time");
				document.getElementById("endError").innerHTML = "";
				//Format Time
				eveningStart = eveningStart.substring(0,2) + eveningStart.substring(3,5);
			}
			var eveningEnd = document.getElementById("eveningEnd").value;
			if(eveningEnd == ""){
				document.getElementById("endError").innerHTML = "Please choose an end time.";
				console.log("invalid end time");
				error = "true";
				timeError = "true";
			}
			else{
				console.log("valid end time");
				document.getElementById("endError").innerHTML = "";
				//Format Time
				eveningEnd = eveningEnd.substring(0,2) + eveningEnd.substring(3,5);
			}
			//Check for starttime > endtime
			if(parseInt(eveningStart) > parseInt(eveningEnd)){
				eveningEnd = parseInt(eveningEnd) + 2400;
				eveningEnd = eveningEnd.toString();
				console.log(eveningEnd);
			}
			
			//Check Group Size
			
			
			//Check Event Type Values
			var i
			var movieTypes = document.getElementsByName('movie');
			var movie = "";
			for(i= 0; i < movieTypes.length; i++){
			    if(movieTypes[i].checked){
			    	movie = movieTypes[i].value;
			    }
			}

			var exhibitionTypes = document.getElementsByName('exhibition');
			var exhibition = "";
			for(i = 0; i < exhibitionTypes.length; i++){
			    if(exhibitionTypes[i].checked){
			    	exhibition = exhibitionTypes[i].value;
			    }
			}
			
			var restaurantTypes = document.getElementsByName('restaurant');
			var restaurant = "";
			for(i = 0; i < restaurantTypes.length; i++){
			    if(restaurantTypes[i].checked){
			        restaurant = restaurantTypes[i].value;
			    }
			}
			
			var sightseeingTypes = document.getElementsByName('sightseeing');
			var sightseeing = "";
			for(i = 0; i < sightseeingTypes.length; i++){
			    if(sightseeingTypes[i].checked){
			    	sightseeing = sightseeingTypes[i].value;
			    }
			}
			
			var shoppingTypes = document.getElementsByName('shopping');
			var shopping = "";
			for(var i = 0; i < shoppingTypes.length; i++){
			    if(shoppingTypes[i].checked){
			    	shopping = shoppingTypes[i].value;
			    }
			}

			var liveshowTypes = document.getElementsByName('liveshow');
			var liveshow = "";
			for(i = 0; i < liveshowTypes.length; i++){
			    if(liveshowTypes[i].checked){
			    	liveshow= liveshowTypes[i].value;
			    }
			}
			
			//Check for no events chosen
			if(shopping == "" && restaurant == "" && sightseeing == "" && exhibition == "" && movie == "" && liveshow == ""){
				console.log("Event error");
				error = "true";
				document.getElementById("eventError").innerHTML = "Please choose at least one event type.";
			}
			else{
				document.getElementById("eventError").innerHTML = "";
			}

			//Print error message if true
			if(error == "true"){
				return;
			}
			else{
				//Submit Form
				console.log("Submitting planning form");
				var xhttp = new XMLHttpRequest();
				if(1){
					console.log("Start Time: " + eveningStart);
					console.log("End Time: " + eveningEnd);
					console.log("Shopping: " + shopping);
					console.log("Restaurant: " + restaurant);
					console.log("Sightseeing: " + sightseeing);
					console.log("Exhibition: " + exhibition);
					console.log("Movie: " + movie);
					console.log("Live shows: " + liveshow);
				}
				xhttp.open("GET", "Servlet?eveningStart="+eveningStart+
						"&eveningEnd="+eveningEnd+"&restaurant="+restaurant
						"&movie="+movie+"&exhibition="+exhibition+
						"&liveshow="+liveshow+"&sightseeing="+sightseeing+"&shopping="+shopping, true); 
	/* 			xhttp.onreadystatechange = function(){
					errorMessage = this.responseText;
					if(errorMessage.length != 0) {
						console.log(errorMessage)
						if(errorMessage.trim() == "success") {
							window.location.href = "results.jsp";
						} else {
							document.getElementById("planningError").innerHTML = this.responseText;	
						}
						
					}
				}
				xhttp.send(); */
			}
		}
		function highlightButton(num){
			
		}
	</script>
	<body>
		<div id="header">
			<a href="index.jsp"><h1 style="display: inline-block;">Good Evening</h1></a>
		</div>
		<div id="icon">
			<a href="profile.jsp"><img src="user.png" style="width: 50px; padding-right: 50px; margin-bottom: 0px; float: right;"/></a>
		</div>

		<div id="body">
			<div id="goodEvening">
				<div class="quant" style="font-size: 64px;">Let's Plan Your Evening</div>
				<form id="planning"> <!-- action="Servlet" -->
					<div class="quant">
						Start Time: <input type="time" id="eveningStart">
						<p id="startError"></p>
					</div>
					<div class="quant">
						End Time: <input type="time" id="eveningEnd">
						<p id="endError"></p>
					</div>
					<div class="quant">
						Type of Events:
						<p id="eventError"></p>
					</div>
					<div class="quant">
						<button class="accordion" type="button">Sightseeing</button>
						<div class="panel">
							 <h4>Urban <input type="radio" name="sightseeing" value="urban"></h4>
							 <h4>Outdoors <input type="radio" name="sightseeing" value="outdoors"> </h4>
						</div>
						<button class="accordion" type="button">Exhibition</button>
						<div class="panel">
							 <h4>Art <input type="radio" name="exhibition" value="art"> </h4>
							 <h4>History <input type="radio" name="exhibition" value="history"></h4>
							 <h4>Science <input type="radio" name="exhibition" value="science"></h4>
						</div>
						<button class="accordion" type="button">Movie</button>
						<div class="panel">
							 <h4>Animated <input type="radio" name="movie" value="animated"></h4>
							 <h4>Action <input type="radio" name="movie" value="action"></h4>
							 <h4>Romantic <input type="radio" name="movie" value="romantic"></h4>
							 <h4>Comedy <input type="radio" name="movie" value="comedy"></h4>
							 <h4>Horror <input type="radio" name="movie" value="horror"></h4>
							 <h4>Drama <input type="radio" name="movie" value="drama"></h4>
						</div>
						<button class="accordion" type="button">Restaurant</button>
						<div class="panel">
							 <h4>Italian <input type="radio" name="restaurant" value="italian"></h4>
							 <h4>Asian <input type="radio" name="restaurant" value="asian"></h4>
							 <h4>Korean Barbecue<input type="radio" name="restaurant" value="koreanbarbecue"></h4>
							 <h4>Mexican <input type="radio" name="restaurant" value="mexican"></h4>
							 <h4>Seafood <input type="radio" name="restaurant" value="seafood"></h4>
							 <h4>Mixed <input type="radio" name="restaurant" value="mixed"></h4>
							 <h4>Steakhouse <input type="radio" name="restaurant" value="steakhouse"></h4>
							 <h4>French <input type="radio" name="restaurant" value="french"></h4>
							 <h4>Californian <input type="radio" name="restaurant" value="californian"></h4>
						</div>	
						<button class="accordion" type="button">Live Shows</button>
						<div class="panel">
							 <h4>Musicals <input type="radio" name="liveshow" value="musical"></h4>
							 <h4>Comedy Show <input type="radio" name="liveshow" value="comedy"></h4>
							 <h4>Theater <input type="radio" name="liveshow" value="theater"></h4>
						</div>
						<button class="accordion" type="button">Shopping</button>
						<div class="panel">
							 <h4>Outlet Mall ($) <input type="radio" name="liveshow" value="$"></h4>
							 <h4>Mall ($$) <input type="radio" name="liveshow" value="$$"></h4>
							 <h4>Boutique Shops ($$$) <input type="radio" name="liveshow" value="$$$"></h4>
						</div>		
					</div>			
					<div class="quant">
						Group Size:</div>	
						<div class="quant">
							<button class="bbutton2" type="button">Individual (1)</button>
							<button class="bbutton2" type="button">Small (2-4)</button>
							<button class="bbutton2" type="button">Medium (5-8)</button>
							<button class="bbutton2" type="button">Large (8+)</button>
					</div>
					 <div class="quant">
						<button type="button" class="accordion" style="text-align:center;" onclick="submitPlan()">Submit</button>
					</div>
 				</form>

			</div>
		</div>
		<div id="footer">
			<h6>CSCI201 Final Project</h6>
			<h6>Yinghui (Linda) He, Guancheng “Ivan” Qiu, Cameron Haseyama, Will DuCharme, Gaurav Malhotra</h6>
		</div>
	</body>
	
	<script>
		var acc = document.getElementsByClassName("accordion");
		var i;
						
		for (i = 0; i < acc.length; i++) {
			acc[i].addEventListener("click", function() {
			this.classList.toggle("active");
			var panel = this.nextElementSibling;
			if (panel.style.maxHeight){
				panel.style.maxHeight = null;
			} else {
				panel.style.maxHeight = panel.scrollHeight + "px";
			} 
			});
		}
		
		var btns = document.getElementsByClassName("bbutton2");
		for (i = 0; i < btns.length; i++) {
			  btns[i].addEventListener("click", function() {
				this.classList.toggle("active");
			  });
		}
		</script>
</html>