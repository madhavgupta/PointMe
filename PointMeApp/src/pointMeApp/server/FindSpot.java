package pointMeApp.server;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.googlecode.objectify.ObjectifyService;

public class FindSpot extends HttpServlet  {
	static{
		ObjectifyService.register(Point.class);
	}
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
	 String identifier_s = req.getParameter("identifier");
	 Long identifier = Long.parseLong(identifier_s);



	 Point ds_point = ObjectifyService.ofy().load().type(Point.class).id(identifier).get();
	 if(ds_point != null) { //Already exists
		 ds_point.id = identifier;
		 resp.addHeader("latitude", ds_point.latitude.toString());
		 resp.addHeader("longitude", ds_point.longitude.toString());
		 resp.setStatus(200);
		 resp.getWriter().write("{latitude: " + ds_point.latitude.toString() + ", longitude: " + ds_point.longitude.toString() + "}");



	 } else { //Create New one
		 resp.addHeader("latitude", "0");
		 resp.addHeader("longitude", "0");
		 resp.setStatus(200);
		 resp.getWriter().write("{latitude: " + "0" + ", longitude: " + "0" + "}");



	 }
	}
}
