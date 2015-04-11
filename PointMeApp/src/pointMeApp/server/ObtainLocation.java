package pointMeApp.server;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import static com.googlecode.objectify.ObjectifyService.ofy;

import com.google.appengine.api.users.User;
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
	 public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
	        //Create a Twilio REST client
			Point p = new Point(Long.parseLong(req.getParameter("identifier")), Integer.parseInt(req.getParameter("long")), Integer.parseInt(req.getParameter("lat")));
			ofy().save().entity(p).now();
	    }
}
