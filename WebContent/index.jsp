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
	console.log("userID in index: ");
	function CheckLogIn(){
		document.getElementById("registerError").innerHTML = "";
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
		document.getElementById("logInError").innerHTML = "";
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
	
	
	<body>
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
					<input type="text" id="username" name="username"><br/>
					<input type="password" id="password" name="password"><br/>
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
				<h2>Let's make it a perfect night.</h2>
				<!-- <h3>Let's make it a perfect night.</h3> -->
			</div>
			<div id="featured">
				<h2>Featured Events</h2>
				
				<!-- Slideshow container -->
				<div class="slideshow-container">
				  <!-- Full-width images with number and caption text -->
				  <div class="mySlides fade">
				    <div class="numbertext">1 / 3</div>
				    <img src="beach.jpg" id="slides">
				    <div class="text">Santa Monica Pier</div>
				  </div>
				
				  <div class="mySlides fade">
				    <div class="numbertext">2 / 3</div>
				    <img src="laughfactory.jpg" id="slides">
				    <div class="text">Laugh Factory</div>
				  </div>
				
				  <div class="mySlides fade">
				    <div class="numbertext">3 / 3</div>
				    <img src="catchla.jpg" id="slides">
				    <div class="text">Catch LA</div>
				  </div>
				
				  <!-- Next and previous buttons -->
				  <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
				  <a class="next" onclick="plusSlides(1)">&#10095;</a>
				</div>
				<br>
				
				<!-- The dots/circles -->
				<div style="text-align:center">
				  <span class="dot" onclick="currentSlide(1)"></span> 
				  <span class="dot" onclick="currentSlide(2)"></span> 
				  <span class="dot" onclick="currentSlide(3)"></span> 
				</div>
			</div>
		</div>
		<div id="footer">
			<h6>CSCI201 Final Project</h6>
			<h6>Yinghui (Linda) He, Guancheng “Ivan” Qiu, Cameron Haseyama, Will DuCharme, Gaurav Malhotra</h6>
			<h6>Fall 2018</h6>
		</div>
	</body>
	<script>
		var slideIndex = 1;
		showSlides(slideIndex);
	
		// Next/previous controls
		function plusSlides(n) {
		  showSlides(slideIndex += n);
		}
	
		// Thumbnail image controls
		function currentSlide(n) {
		  showSlides(slideIndex = n);
		}
	
		function showSlides(n) {
		  var i;
		  var slides = document.getElementsByClassName("mySlides");
		  var dots = document.getElementsByClassName("dot");
		  if (n > slides.length) {slideIndex = 1} 
		  if (n < 1) {slideIndex = slides.length}
		  for (i = 0; i < slides.length; i++) {
		      slides[i].style.display = "none"; 
		  }
		  for (i = 0; i < dots.length; i++) {
		      dots[i].className = dots[i].className.replace(" active", "");
		  }
		  slides[slideIndex-1].style.display = "block"; 
		  dots[slideIndex-1].className += " active";
		}
	</script>
</html>