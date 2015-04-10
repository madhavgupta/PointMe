package pointMeApp.server;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.logging.Logger;
public class TwilioController extends HttpServlet{
	public static String FROM = "5123841298";
	public static String SID = "AC737f025b7c7506fb64d75e4737ad8143";
	public static String AUTHTOKEN = "aaf1131572f1f8b22f00fea818ba28d7";
	public static Boolean AUTHENTICATED = false;
	private static final HttpURLConnection HttpURLConnection = null;
	private static final Logger log = Logger.getLogger("CLASS");

	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String to = req.getParameter("to");
		String body = req.getParameter("body");
		log.info("HERE");
		if(!verifyAuthentication()) {
			log.info("HERE23");

			authenticate();
			log.info("HERE2");

		}
		log.info("HERE3");

		sendMessage(to,body);
		log.info("HERE");


	}
	private void authenticate() {
		// TODO Auto-generated method stub
		try {
			URL url = new URL("https://" + SID + ":" + AUTHTOKEN + "@api.twilio.com/2010-04-01/Accounts.json");
			HttpURLConnection connection =  (HttpURLConnection) url.openConnection();
			connection.setDoOutput(true);
			connection.setRequestMethod("GET");
			OutputStreamWriter writer = new OutputStreamWriter(connection.getOutputStream());
		
			if(connection.getResponseCode() == HttpURLConnection.HTTP_OK || connection.getResponseCode() == HttpURLConnection.HTTP_CREATED) {
				BufferedReader br = new BufferedReader(new InputStreamReader((connection.getInputStream())));
				StringBuilder sb = new StringBuilder();
				String out;
				while((out = br.readLine()) != null) {
					sb.append(out);
				}
				
				TwilioController.AUTHENTICATED = true;
				log.info(sb.toString());

			} else {
				TwilioController.AUTHENTICATED = false;
				log.info("CONNECTION FAILED 1");
				log.info(connection.getResponseCode() + "");
			}
		} catch (Exception e) {
			log.info(e.toString());

			TwilioController.AUTHENTICATED = false;
		} finally {
			
		}
	}
	private boolean verifyAuthentication() {
		// TODO Auto-generated method stub
		try {
			URL url = new URL("https://api.twilio.com/2010-04-01/Accounts.json");
			HttpURLConnection connection =  (HttpURLConnection) url.openConnection();
			connection.setDoOutput(true);
			connection.setRequestMethod("POST");
			OutputStreamWriter writer = new OutputStreamWriter(connection.getOutputStream());
			if(connection.getResponseCode() == HttpURLConnection.HTTP_OK || connection.getResponseCode() == HttpURLConnection.HTTP_CREATED) {
				String response = connection.getResponseMessage();
				if(response.contains("active")) {
					TwilioController.AUTHENTICATED = true;
					log.info(connection.getResponseMessage());

				} else {
					TwilioController.AUTHENTICATED = false;
					log.info("CONNECTION FAILED 2");

				}
			} else {
				TwilioController.AUTHENTICATED = false;
			}
		} catch (Exception e) {
			log.info(e.toString());

			TwilioController.AUTHENTICATED = false;
		} finally {
			
		}
		return TwilioController.AUTHENTICATED;
	}
	public String sendMessage(String to, String body) throws UnsupportedEncodingException {
		String message = URLEncoder.encode(body, "UTF-8");
		String toNumber = URLEncoder.encode(to, "UTF-8");
		try {
			URL url = new URL("https://api.twilio.com/2010-04-01/Accounts/"+TwilioController.SID + "/SMS/Messages");
			HttpURLConnection connection =  (HttpURLConnection) url.openConnection();
			connection.setDoOutput(true);
			connection.setRequestMethod("POST");
			OutputStreamWriter writer = new OutputStreamWriter(connection.getOutputStream());
			writer.write("To=" + toNumber);
			writer.write("Body=" + message);
			writer.write("From=" + TwilioController.FROM);
			writer.close();
			BufferedReader br = new BufferedReader(new InputStreamReader((connection.getInputStream())));
			StringBuilder sb = new StringBuilder();
			String out;
			while((out = br.readLine()) != null) {
				sb.append(out);
			}
			if(connection.getResponseCode() == HttpURLConnection.HTTP_OK || connection.getResponseCode() == HttpURLConnection.HTTP_CREATED) {
				//
				
				log.info(sb.toString());

			} else {
				log.info(sb.toString());

				log.info("CONNECTION FAILED 3");
				log.info(connection.getResponseCode()+"");

			}
		} catch (Exception e) {
			log.info(e.toString());


		} finally {
			
		}
		return "";
	}
}
