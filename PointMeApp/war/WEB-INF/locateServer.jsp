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
<link rel="stylesheet" href="locate.css">
</head>
<body>
	<h1>PointMe : Your Guide to Finding Your Friends</h1>
	<p id="demo"></p>
	<p id="demo2"></p>
	<p id="demo3"></p>
	<p id="demo4"></p>
	<p id="demo5"></p>
	<p id="demo6"></p>


	<%
 	int latitude; int longitude;
 		Object lat; Object lon;
	 StringBuffer requestURL = request.getRequestURL();
	 	String URL = requestURL.toString();
	 	URL=URL.substring(50);
		if(!URL.equals("locate.css"))
		{
			System.out.println(URL);
			DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
			Entity greeting = new Entity("UniqueID",URL);
		 greeting.setProperty("Longitude", 0);
		 greeting.setProperty("Latitude", 0);
		 greeting.setProperty("UniqueID", URL);
		  datastore.put(greeting);
		
	
		}
	%>

	<script>
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

			data['long'] = position.coords.longitude;
			data['lat'] = position.coords.latitude;

//			friendLocation.innerHTML = "Pointing to: "
//					+ lat + ", " + lon;

			//Convert latitude and longitude into radians
			var myLatR = position.coords.latitude * Math.PI / 180;
			var myLonR = position.coords.longitude * Math.PI / 180;
			var theirLongR = document.getElementById("Longitude");
			var theirLatR = document.getElementById("Latitude");
			var dLat = (-97.743279 - position.coords.latitude) * Math.PI / 180; //WE NEED TO CHANGE THE 0'S TO THE SERVER VALUES
			var dLon = (30.295206 - position.coords.longitude) * Math.PI / 180; //and here

			//Calculate distance here            
			var R = 6371; // Radius of the earth in km
			var a = 0.5 - Math.cos(dLat) / 2 + Math.cos(myLatR)
					* Math.cos(theirLatR * Math.PI / 180) * //and here
					(1 - Math.cos(dLon)) / 2;

			var dist = R * 2 * 1000 * Math.asin(Math.sqrt(a));

			yourDistance.innerHTML = "Distance to your destination: " + dist
					+ " meters";

			//Calculate angle here
			var y = Math.sin(dLon) * Math.cos(theirLatR);                  //latitude of desination
			var x = Math.cos(myLatR) * Math.sin(theirLatR) - Math.sin(myLatR)      //latitude of destination
					* Math.cos(theirLatR) * Math.cos(dLon);                    //latitude of destination
			var brng = Math.atan2(y, x);
			angle = brng * 180 / Math.PI;
			angleFound = true;

			yourAngle.innerHTML = "Angle to your destination: " + angle
					+ " degrees";

			if (document.cookie == "") {

				id = hashCode(Date());
				document.cookie = id;
			} else {

			}
			data['id'] = id;
			$.ajax({
				url : "",
				data : data,
				method : "POST",
				success : function(msg) {

				},
			});

		}
		getLocation();
	</script>

</body>

</html>
