package pointMeApp.server;

import java.io.IOException;
import java.util.logging.Logger;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.Query;


public class ObtainLocation extends HttpServlet {
	private static final Logger log = Logger.getLogger("CLASS");

	 public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
	        //Create a Twilio REST client
		 
		 String identifier_s = req.getParameter("identifier");
		 String long_s = req.getParameter("lon");
		 String lat_s = req.getParameter("lat");
		 String number_s = req.getParameter("to");
		 
		 Long identifier = Long.parseLong(identifier_s);
		 Double longitude = Double.parseDouble(long_s);
		 Double latitude = Double.parseDouble(lat_s);

		 DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		 Entity greeting = new Entity("UniqueID",identifier_s);
		 greeting.setProperty("Longitude", long_s);
		 greeting.setProperty("Latitude", lat_s);
		 greeting.setProperty("UniqueID", identifier_s);
		  datastore.put(greeting);
		 
		  resp.setStatus(200);
			resp.getWriter().write("{latitude: " +lat_s + ", longitude: " + long_s + "}");
	    }
	 
}
