package pointMeApp.server;

import java.io.IOException;
import java.util.Enumeration;
import java.util.List;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.PreparedQuery;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Query.Filter;
import com.google.appengine.api.datastore.Query.FilterPredicate;
import com.google.appengine.api.datastore.Query.FilterOperator;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.KeyFactory;

public class LocateServer extends HttpServlet{
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		//retrieve url data from datastore ie with number get location coordinates
				String test = (String) req.getParameter("id");
				test = test.substring(0, test.length()-1);
				
			 		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
				Filter uuidFilter = new FilterPredicate("UniqueID", FilterOperator.EQUAL, test);
				Query q = new Query("UniqueID").setFilter(uuidFilter);
				PreparedQuery pq = datastore.prepare(q);
				List<Entity> IDS = datastore.prepare(q).asList(FetchOptions.Builder.withLimit(20));
				for (Entity result : pq.asIterable()) {
				datastore.delete(result.getKey());
				}
				
		
		resp.sendRedirect("http://1-dot-pointmeapplication.appspot.com/");
	}
	
	
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException{
    	String ID = getUniqueURL();
    	String input = req.getParameter("content");
    	Enumeration<?> m =req.getParameterNames();
    	while(m.hasMoreElements()){
    		System.out.println(m.nextElement());
    	}
    	TwilioController.sendMessage(input, "http://1-dot-pointmeapplication.appspot.com/locate/"+ID);

    	resp.sendRedirect("/track/"+ID);
    }
    	private String getUniqueURL() {
		// TODO Auto-generated method stub
		int val = (int) (Math.random()*100000);
		String generated = ""+val;
		return generated;
	}
}