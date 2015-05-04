package pointMeApp.server;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Logger;

import static com.googlecode.objectify.ObjectifyService.ofy;

import com.google.appengine.api.users.User;
import com.google.gwt.geolocation.client.Geolocation;
import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class ObtainLocation extends HttpServlet {
	static{
		ObjectifyService.register(Point.class);
	}
	private static final Logger log = Logger.getLogger("CLASS");

	 public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
	        //Create a Twilio REST client
		 
		 String identifier_s = req.getParameter("identifier");
		 String long_s = req.getParameter("long");
		 String lat_s = req.getParameter("lat");
		 String number_s = req.getParameter("to");
		 
		 Long identifier = Long.parseLong(identifier_s);
		 Double longitude = Double.parseDouble(long_s);
		 Double latitude = Double.parseDouble(lat_s);

		 log.info(identifier_s);
		 log.info(long_s);	
		 log.info(lat_s);
		 Point ds_point = ObjectifyService.ofy().load().type(Point.class).id(identifier).get();
		 if(ds_point != null) { //Already exists
			 ds_point.id = identifier;
			 ds_point.latitude = latitude;
			 ds_point.longitude = longitude;
			 if(number_s != null) {
				 ds_point.number = number_s;
			 }
			ofy().save().entity(ds_point).now(); 

		 } else { //Create New one
			 Point p;
			if(number_s != null) {
				p = new Point(identifier, longitude, latitude, number_s);
			} else {
				p = new Point(identifier, longitude, latitude);

			}
			ofy().save().entity(p).now(); 

		 }
		 if(number_s != null) {
			 TwilioController.sendMessage(number_s, TwilioController.MESSAGE + " " + TwilioController.LINK);
		 } 

	    }
}
