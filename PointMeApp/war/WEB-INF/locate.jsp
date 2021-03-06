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
<link rel="stylesheet"  type="text/css" href="WEB-INF/locate.css">
<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
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
	<p id="accuracy" align = center style="font-family:Helvetica,Lucida Sans Unicode , Verdana ; color:#4D3F68"></p>

	<p id="demo2" align = center style="font-family:Helvetica,Lucida Sans Unicode , Verdana ; color:#4D3F68"></p>
	<p id="demo3" align = center style="font-family:Helvetica,Lucida Sans Unicode , Verdana ; color:#4D3F68"></p>
	<p id="demo4" align = center style="font-family:Helvetica,Lucida Sans Unicode , Verdana ; color:#4D3F68"></p>
	<p id="demo5" align = center style="font-family:Helvetica,Lucida Sans Unicode , Verdana ; color:#4D3F68"></p>
	<p id="demo6" align = center style="font-family:Helvetica,Lucida Sans Unicode , Verdana ; color:#4D3F68"></p>

	<%
		int latitude; int longitude;
		 		Object lat; Object lon;
			 	StringBuffer requestURL = request.getRequestURL();
			 	String URL = requestURL.toString();
			 	String[] URLarr =URL.split("/");
			 	pageContext.setAttribute("id",URLarr[URLarr.length -1 ]);
		if(!URLarr[URLarr.length -1 ].equals("locate.css"))
		{

			DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
			Filter keyFilter = new FilterPredicate("UniqueID",
			                      FilterOperator.EQUAL,
			                      URLarr[URLarr.length -1 ]);
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
	<p id="update-location" align = center style="font-family:Helvetica,Lucida Sans Unicode , Verdana ; color:#4D3F68"><b>Your friend''s location:</b>

	</p>
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
		var accuracy = document.getElementById("accuracy");

		var yourDistance = document.getElementById("demo2");
		var yourAngle = document.getElementById("demo3");
		var yourAlpha = document.getElementById("demo4");
		var yourDA = document.getElementById("demo5");
		var friendLocation = document.getElementById("demo6");
		var fLat = ${fn:escapeXml(Latitude)};
		var fLon = ${fn:escapeXml(Longitude)};
		var angle;
		var angleFound = false;
		old = true;
		setInterval(function(){ old = true; }, 10000);
		function handleOrientation(event) {
			var alpha;
			var displayAngle;
			if (angleFound) {
				if (event.webkitCompassHeading) {

					alpha = event.webkitCompassHeading;
					displayAngle = angle + alpha;

					//rotation reversed for iOS

					compass.style.WebkitTransform = 'rotate(-'
							+ (displayAngle - 45) + 'deg)';

				} else {
					alpha = event.alpha;
					displayAngle = angle + alpha;
					webkitAlpha = displayAngle;
					if (!window.chrome) {
						webkitAlpha = webkitAlpha - 270;
					}

					compass.style.WebkitTransform = 'rotate('
							+ (webkitAlpha - 45) + 'deg)';

				}
				if (alpha === undefined || alpha === null) {
					yourAlpha.innerHTML = "Can't determine your device's orientation...";
				} else {

				}

				// 				compass.style.Transform = 'rotate(' + alpha + 'deg)';

				// 				compass.style.MozTransform = 'rotate(-' + alpha + 'deg)';

			}

		}

		var id, target, options;
		$( document ).ready(function() {
    		document.getElementById("update-location").innerHTML = fLon + ", " + fLat;
		});
		function success(pos) {
			var crd = pos.coords;

// 			if (target.latitude === crd.latitude
// 					&& target.longitude === crd.longitude) {
// 				console.log('Congratulations, you reached the target');
// 				//   navigator.geolocation.clearWatch(id);
// 			}
			accuracy.innerHTML = "<b>Accuracy: </b>" + crd.accuracy + ","

			var data = {};
			yourLocation.innerHTML = "<b>Your location: </b>" + crd.latitude + ","
					+ crd.longitude;

			data['long'] = crd.longitude;
			data['lat'] = crd.latitude;

			//			friendLocation.innerHTML = "Pointing to: "
			//					+ lat + ", " + lon;

			//Convert latitude and longitude into radians
			var myLatR = crd.latitude * Math.PI / 180;
			var myLonR = crd.longitude * Math.PI / 180;
			var theirLongR = document.getElementById("Longitude");
			var theirLatR = document.getElementById("Latitude");
			var dLat = (fLat - crd.latitude) * Math.PI / 180; //WE NEED TO CHANGE THE 0'S TO THE SERVER VALUES
			var dLon = (fLon - crd.longitude) * Math.PI / 180; //and here
			

			//Calculate distance here            
			var R = 6371; // Radius of the earth in km
			var a = 0.5 - Math.cos(dLat) / 2 + Math.cos(myLatR)
					* Math.cos(theirLatR * Math.PI / 180) * //and here
					(1 - Math.cos(dLon)) / 2;

			var dist = R * 2 * 1000 * Math.asin(Math.sqrt(a));


			//Calculate angle here
			var y = Math.sin(dLon) * Math.cos(theirLatR);
			var x = Math.cos(myLatR) * Math.sin(theirLatR) - Math.sin(myLatR)
					* Math.cos(theirLatR) * Math.cos(dLon);
			var brng = Math.atan2(y, x);
			angle = brng * 180 / Math.PI;
			angleFound = true;


			getFriendsLocation(data);

		}
		function getFriendsLocation(data) {
			if(old) {
				old = false;
				data['id'] = id;
				$.ajax({
					url : "/findSpot",
					data : data,
					method : "POST",
					success : function(msg) {
							location = JSON.parse(msg);
							fLon = location['longitude'];
							fLat = location['latitude'];
							document.getElementById("update-location").innerHTML = "Your friend's location: "+ location['longitude'] + " ," +location['latitude'] ;
					},
				});
			}

		}
		function error(err) {
			console.warn('ERROR(' + err.code + '): ' + err.message);
		}

		target = {
			latitude : 0, // add values from server here
			longitude : 0
		//
		};

		options = {
			enableHighAccuracy : true,
			timeout : 5000,
			maximumAge : 3000
		};

		id = navigator.geolocation.watchPosition(success, error, options);
		window.addEventListener('deviceorientation', handleOrientation);

		// 		function getLocation() {
		// 			if (navigator.geolocation) {
		// 				navigator.geolocation.watchPosition(callbackPosition);
		// 			} else {
		// 				yourLocation.innerHTML = "Geolocation is not supported by this browser.";
		// 			}
		// 		}
		// 		function getPrimaryLocation() {
		// 			alert(location.href.split("/")[4]);
		// 		}
		// 		function callbackPosition(position) {

		// 		}
		// 		getLocation();
		
	</script>

</body>

</html>
