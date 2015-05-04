package pointMeApp.server;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Query.Filter;
import com.google.appengine.api.datastore.Query.FilterOperator;
import com.google.appengine.api.datastore.Query.FilterPredicate;
import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.annotation.Entity;

public class FindSpot extends HttpServlet  {
	static{
		ObjectifyService.register(Point.class);
	}
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
	 String identifier_s = req.getParameter("identifier");
	 Long identifier = Long.parseLong(identifier_s);
	 DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
	 Filter keyFilter = new FilterPredicate("UniqueID",
             FilterOperator.EQUAL,
             identifier_s);
	 Query getID = new Query("UniqueID").setFilter(keyFilter);
	 String lat="";
	 String lon="";
	 List<com.google.appengine.api.datastore.Entity> IDS = datastore.prepare(getID).asList(FetchOptions.Builder.withLimit(20));
		if(!IDS.isEmpty()){
			com.google.appengine.api.datastore.Entity ServerSide = IDS.get(0);
			 lon = ServerSide.getProperty("Longitude").toString();
			 lat = ServerSide.getProperty("Latitude").toString();
		}
		 resp.addHeader("latitude", lat);
		 resp.addHeader("longitude", lon);
		
		 resp.setStatus(200);
		 resp.getWriter().write("{latitude: " +lat + ", longitude: " + lon + "}");


	}
}
