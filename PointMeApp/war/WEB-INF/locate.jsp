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
	var x = document.URL;
	var res = x.substring(51);

	document.getElementById("demo").innerHTML = res;
</script>
 <%
 
	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
	Filter keyFilter = new FilterPredicate("UniqueID",
	                      FilterOperator.EQUAL,
	                      11351);
	Query getID = new Query("UniqueID").setFilter(keyFilter);
		
		List<Entity> IDS = datastore.prepare(getID).asList(FetchOptions.Builder.withLimit(20));
		if(!IDS.isEmpty())
			out.println("<p>WOOHOO</p>");
		else System.out.println("<p>OH SHIT</p>");
	
%>
<h2> Distance from final destination: </h2>
<img src="https://cdn4.iconfinder.com/data/icons/marine-and-nautical/78/Marine_nautical-09-512.png" alt="Arrow">
  </body>
  
</html>