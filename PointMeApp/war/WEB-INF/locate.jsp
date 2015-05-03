<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="com.google.appengine.api.datastore.Query.Filter" %>
<%@ page import="com.google.appengine.api.datastore.Query.FilterOperator" %>
<%@ page import="com.google.appengine.api.datastore.Query.FilterPredicate" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ page import ="com.google.appengine.api.datastore.Text" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
  <head>
	  <link rel="stylesheet" href="locate.css">
  </head>
  <body>
  <h1>PointMe : Your Guide to Finding Your Friends </h1>
	
get the users id from url and datastore and get associated location/calculate distance display
with arrow.  For repeated updates use a loop to continuously check location value and update arrow
	<p id="demo"></p>
<script>
var x = document.getElementById("demo");
	function getLocation() {
	    if (navigator.geolocation) {
	        navigator.geolocation.watchPosition(callbackPosition);
	    } else {
	        x.innerHTML = "Geolocation is not supported by this browser.";
	    }
	} 
	function callbackPosition(position) {
	var data = {};
	x.innerHTML=position.coords.longitude + ","+position.coords.latitude;
	data['long'] = position.coords.longitude;
	data['lat'] = position.coords.latitude;
			

	if(document.cookie == "") {

		id = hashCode(Date());
		document.cookie = id;
	} else {

	}
	data['id'] = id;
	$.ajax({
		url: "",
		data: data,
		method: "POST",
		success: function(msg) {
			
		},
	});

}
getLocation();
</script>
 <%
 StringBuffer requestURL = request.getRequestURL();
 	String URL = requestURL.toString();
 	URL=URL.substring(51);
	if(!URL.equals("locate.css"))
	{
		System.out.println(URL);
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		Filter keyFilter = new FilterPredicate("UniqueID",
		                      FilterOperator.EQUAL,
		                      URL);
		Query getID = new Query("UniqueID").setFilter(keyFilter);
			
			List<Entity> IDS = datastore.prepare(getID).asList(FetchOptions.Builder.withLimit(20));
			if(!IDS.isEmpty()){
				Entity ServerSide = IDS.get(0);
				pageContext.setAttribute("Longitude",ServerSide.getProperty("Longitude"));
				pageContext.setAttribute("Latitude",ServerSide.getProperty("Latitude"));
				
			%>
			Server Longitude: 
			<b>${fn:escapeXml(Longitude)}</b>
			Server Latitude:
			<b>${fn:escapeXml(Latitude)}</b>
			<%
			}
			else {
			%>
			OH SHIT!!!
			<%
			}
		}
%>
<h2> Distance from final destination: </h2>
<img src="https://cdn4.iconfinder.com/data/icons/marine-and-nautical/78/Marine_nautical-09-512.png" alt="Arrow">
  </body>
  
</html>