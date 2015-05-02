package pointMeApp.server;

import javax.servlet.RequestDispatcher;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.Query;

import pointMeApp.client.GreetingService;
import pointMeApp.shared.FieldVerifier;

import com.google.gwt.user.server.rpc.RemoteServiceServlet;

/**
 * The server-side implementation of the RPC service.
 */
@SuppressWarnings("serial")
public class GreetingServiceImpl extends RemoteServiceServlet implements
		GreetingService {

	public String greetServer(String input) throws IllegalArgumentException {
		//This will be where we send to the number and print out that the message has been sent
		// Verify that the input is valid. 
		if (!FieldVerifier.isValidName(input)) {
			// If the input is not valid, throw an IllegalArgumentException back to
			// the client.
			throw new IllegalArgumentException(
					"Name must be at least 4 characters long");
		}

		String serverInfo = getServletContext().getServerInfo();
		String userAgent = getThreadLocalRequest().getHeader("User-Agent");

		// Escape data from the client to avoid cross-site script vulnerabilities.
		input = escapeHtml(input);
		userAgent = escapeHtml(userAgent);
		String URL_send = getUniqueURL();
		
		TwilioController.sendMessage(input, "http://1-dot-pointmeapplication.appspot.com/locate/"+URL_send);

		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		 Entity greeting = new Entity("UniqueID",URL_send);
		 greeting.setProperty("Longitude", 0);
		 greeting.setProperty("Latitude", 0);
		  datastore.put(greeting);
		return "Your message has been sent to "+input;
	}

	private String getUniqueURL() {
		// TODO Auto-generated method stub
		int val = (int) (Math.random()*100000);
		String generated = ""+val;
		return generated;
	}

	/**
	 * Escape an html string. Escaping data received from the client helps to
	 * prevent cross-site script vulnerabilities.
	 * 
	 * @param html the html string to escape
	 * @return the escaped string
	 */
	private String escapeHtml(String html) {
		if (html == null) {
			return null;
		}
		return html.replaceAll("&", "&amp;").replaceAll("<", "&lt;")
				.replaceAll(">", "&gt;");
	}
}
