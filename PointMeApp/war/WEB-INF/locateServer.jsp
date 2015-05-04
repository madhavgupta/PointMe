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

			data['lon'] = position.coords.longitude;
			data['lat'] = position.coords.latitude;

//			friendLocation.innerHTML = "Pointing to: "
//					+ lat + ", " + lon;

			document.getElementById("Longitude")= position.coords.longitude;
			document.getElementById("Latitude")= position.coords.latitude;
		
			
			if (document.cookie == "") {

				id = hashCode(Date());
				document.cookie = id;
			} else {

			}
			data['identifier'] = id;
			$.ajax({
				url : "/registerLocation/",
				data : data,
				method : "POST",
				success : function(msg) {
					alert(msg);
				},
			});

		}
		getLocation();
	</script>

</body>

</html>
