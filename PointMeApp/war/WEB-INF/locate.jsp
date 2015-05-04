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
	 	String[] URLarr =URL.split("/");

		if(!URL.equals("locate.css"))
		{
			System.out.println(URLarr[4]);
			DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
			Filter keyFilter = new FilterPredicate("UniqueID",
			                      FilterOperator.EQUAL,
			                      URLarr[4]);
			Query getID = new Query("UniqueID").setFilter(keyFilter);
		
		List<Entity> IDS = datastore.prepare(getID).asList(FetchOptions.Builder.withLimit(20));
		if(!IDS.isEmpty()){
			Entity ServerSide = IDS.get(0);
			lon = ServerSide.getProperty("Longitude");
			lat = ServerSide.getProperty("Latitude");
			pageContext.setAttribute("Longitude",lon);
 			pageContext.setAttribute("Latitude",lat);
//  			latitude = (Integer) ServerSide.getProperty("Latitude");
//  			longitude = (Integer) ServerSide.getProperty("Longitude");
	%>
	Your friend's ' location:
	<b>${fn:escapeXml(Latitude)}</b> ,y
	<b>${fn:escapeXml(Longitude)}</b>
	<br>
	<center>
		<div id="compassContainer">
			<center>
				<img
					src="https://cdn4.iconfinder.com/data/icons/marine-and-nautical/78/Marine_nautical-09-512.png"
					alt="Arrow" id="compass">
			</center>
		</div>
	</center>
	<%
		}
		else {
	%>
	Sorry But this URL is Invalid! You will now be redirected to the home
	page.
	<META http-equiv="refresh"
		content="5;URL=http://1-dot-pointmeapplication.appspot.com">

	<%
		}
			}
	%>

	<script>
		var yourLocation = document.getElementById("demo");
		var yourDistance = document.getElementById("demo2");
		var yourAngle = document.getElementById("demo3");
		var yourAlpha = document.getElementById("demo4");
		var yourDA = document.getElementById("demo5");
		var friendLocation = document.getElementById("demo6");

		var angle;
		var angleFound = false;

		function handleOrientation(event) {
			var alpha;
			var displayAngle;
			if (angleFound) {
				if (event.webkitCompassHeading) {
					
					alpha = event.webkitCompassHeading;
					displayAngle = angle + alpha;
					
					//rotation reversed for iOS
					
					compass.style.WebkitTransform = 'rotate(-' + (displayAngle - 45)
							+ 'deg)';
					
				} else {
					alpha = event.alpha;
					displayAngle = angle + alpha;
					webkitAlpha = displayAngle;
					if (!window.chrome) {
						webkitAlpha = webkitAlpha - 270;
					}
	 				
					compass.style.WebkitTransform = 'rotate(' + (webkitAlpha - 45)
						+ 'deg)';
					
				}
				if (alpha === undefined || alpha === null) {
					yourAlpha.innerHTML = "Can't determine your device's orientation...";
				} else {
					yourAlpha.innerHTML = "Alpha is: " + alpha;

				}
				
// 				compass.style.Transform = 'rotate(' + alpha + 'deg)';

// 				compass.style.MozTransform = 'rotate(-' + alpha + 'deg)';
			
				yourDA.innerHTML = "Displaying angle: " + displayAngle;
			}

		}

		window.addEventListener('deviceorientation', handleOrientation);

		function getLocation() {
			if (navigator.geolocation) {
				navigator.geolocation.watchPosition(callbackPosition);
			} else {
				yourLocation.innerHTML = "Geolocation is not supported by this browser.";
			}
		}
		function getPrimaryLocation() {
			alert(location.href.split("/")[4]);
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
			var primaryLocation = getPrimaryLocation();
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
			//data['id'] = id;
			//$.ajax({
			//	url : "",
			//	data : data,
			//	method : "POST",
			//	success : function(msg) {

			//	},
			//});

		}
		getLocation();
	</script>

</body>

</html>
