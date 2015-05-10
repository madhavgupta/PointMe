<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.google.appengine.api.users.User"%>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@ page
	import="com.google.appengine.api.datastore.DatastoreServiceFactory"%>
<%@ page import="com.google.appengine.api.datastore.DatastoreService"%>
<%@ page import="com.google.appengine.api.datastore.Query"%>
<%@ page import="com.google.appengine.api.datastore.Query.Filter"%>
<%@ page
	import="com.google.appengine.api.datastore.Query.FilterOperator"%>
<%@ page
	import="com.google.appengine.api.datastore.Query.FilterPredicate"%>
<%@ page import="com.google.appengine.api.datastore.Entity"%>
<%@ page import="com.google.appengine.api.datastore.FetchOptions"%>
<%@ page import="com.google.appengine.api.datastore.Key"%>
<%@ page import="com.google.appengine.api.datastore.KeyFactory"%>
<%@ page import="com.google.appengine.api.datastore.Text"%>
<%@ page import="java.lang.Math"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
   <script type="text/javascript" language="javascript" src="../jquery-1.11.3.min.js"></script>

</head>
<body bgcolor = "#81EC62">

	<h1 align=center style="background-color: #81EC62 ; margin: 0px 0px 0px; font-family:Helvetica,Lucida Sans Unicode , Verdana ; color:#4D3F68 ; font-size: 4em">PointMe</h1>
    <br>
    <h2 align=center style="background-color: #81EC62; margin: 0px 0px 0px; font-family:Helvetica,Lucida Sans Unicode , Verdana ; color:#4D3F68 ; font-size: 2em" >A Compass For Your Friends</h2> 
    <br>
    <br>
    <br>
	<p id="demo" align = center style="font-family:Helvetica,Lucida Sans Unicode , Verdana ; color:#4D3F68"></p>
	<p id="demo2" align = center style="font-family:Helvetica,Lucida Sans Unicode , Verdana ; color:#4D3F68"></p>
	<p id="demo3" align = center style="font-family:Helvetica,Lucida Sans Unicode , Verdana ; color:#4D3F68"></p>
	<p id="demo4" align = center style="font-family:Helvetica,Lucida Sans Unicode , Verdana ; color:#4D3F68"></p>
	<p id="Longitude" align = center style="font-family:Helvetica,Lucida Sans Unicode , Verdana ; color:#4D3F68"></p>
	<p id="Latitude" align = center style="font-family:Helvetica,Lucida Sans Unicode , Verdana ; color:#4D3F68"></p>

	<%
	StringBuffer requestURL = request.getRequestURL();
 	String URL = requestURL.toString();
 	String[] URLarr =URL.split("/");
	pageContext.setAttribute("id",URLarr[URLarr.length - 1 ]);
	
	%>
		<form align = center style="background-color: #81EC62"action="/SentNumber" method="GET"> 
    	<input id="sendButton" height="42" type="submit" value="Deactivate Link"/>
    	<input type = "hidden" name = "id" value = ${fn:escapeXml(id)}/>
   	</form>
	<script>
	old = true;
	setInterval(function(){ old = true; }, 10000);
	var yourLocation = document.getElementById("demo");

		function getLocation() {
			if (navigator.geolocation) {
				navigator.geolocation.watchPosition(callbackPosition);
			} else {
				yourLocation.innerHTML = "Geolocation is not supported by this browser.";
			}
		}
		function callbackPosition(position) {
			var data = {};
			yourLocation.innerHTML = "<b>Your location:</b> "
					+ position.coords.latitude + ","
					+ position.coords.longitude;

//			friendLocation.innerHTML = "<b>Pointing to: </b>"
//					+ lat + ", " + lon;

			document.getElementById("Longitude").innerHTML = position.coords.longitude;
			document.getElementById("Latitude").innerHTML= position.coords.latitude;
		
			
			data['lon'] = position.coords.longitude;
			data['lat'] = position.coords.latitude;
			data['id'] = ${fn:escapeXml(id)};
			checkAndUpdate(data);
			

		}
		function checkAndUpdate(data) {
			if(old) {
				old = false;
				$.ajax({
					type : "POST",
					url : "/registerLocation",
					data : data,
					success : function() {


					},
			     	error: function () {

     			 	},
					complete: function(){

					}
				});
			}

		}
		
		getLocation();
	</script>

</body>

</html>
