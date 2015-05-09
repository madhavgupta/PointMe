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
<!DOCTYPE html>
<head>
   <script type="text/javascript" language="javascript" src="pointmeapp/jquery-1.11.3.min.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
</head>
<body>
	<h1>PointMe : Your Guide to Finding Your Friends</h1>

<h1>PointMe : Your Guide to Finding Your Friends</h1>
	<p id="demo"></p>
	<p id="demo2"></p>
	<p id="demo3"></p>
	<p id="demo4"></p>
	<p id="Longitude"></p>
	<p id="Latitude"></p>
	<%
	StringBuffer requestURL = request.getRequestURL();
 	String URL = requestURL.toString();
 	String[] URLarr =URL.split("/");
	pageContext.setAttribute("id",URLarr[URLarr.length -1 ]);
	%>
	<span id="uniqueID" type="hidden">${fn:escapeXml(id)}</span>
	
	<script>
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
			yourLocation.innerHTML = "Your location: "
					+ position.coords.latitude + ","
					+ position.coords.longitude;
			

			document.getElementById("lon") = position.coords.longitude;
			document.getElementById("lat") = position.coords.longitude;
			
//			friendLocation.innerHTML = "Pointing to: "
//					+ lat + ", " + lon;

			document.getElementById("Longitude").innerHTML = position.coords.longitude;
			document.getElementById("Latitude").innerHTML= position.coords.latitude;
		
			
			data['lon'] = position.coords.longitude;
			data['lat'] = position.coords.latitude;
			data['identifier'] = document.getElementById("uniqueID");

			$.ajax({
				type : "GET",
				url : "/registerLocation",
				data : data,
				dataType: "json",
				async:false,
				always : function() {
				alert("ajax success");

				},
				success : function() {
				alert("ajax success");

				},
			     error: function () {
       			 alert("FAILURE");
     			 },
				complete: function(){
				alert("ajax call complete");
				}
			});

		}
		
		getLocation();
	</script>

</body>

</html>
