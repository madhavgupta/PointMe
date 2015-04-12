package pointMeApp.server;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Map;
import java.util.HashMap;

import com.twilio.sdk.resource.instance.Account;
import com.twilio.sdk.TwilioRestClient;
import com.twilio.sdk.TwilioRestException;
import com.twilio.sdk.resource.factory.SmsFactory;
import com.twilio.sdk.resource.instance.Sms;

import java.util.logging.Logger;
public class TwilioController extends HttpServlet{
	public static String FROM = "5123841298";
	public static String ACCOUNT_SID = "AC737f025b7c7506fb64d75e4737ad8143";
	public static String AUTH_TOKEN = "aaf1131572f1f8b22f00fea818ba28d7";
	public static Boolean AUTHENTICATED = false;
	private static final Logger log = Logger.getLogger("CLASS");
	public static final String MESSAGE = "Your friend would like to share their location with you.";
	public static final String LINK = "https://pointmeapplication.appspot.com/findSpot.html?id=";
    //Handle an incoming HTTP Request
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        //Create a Twilio REST client
		String to = req.getParameter("to");
		String body = req.getParameter("body");
		sendMessage(to,body);
    }
    public static void sendMessage(String to, String body) {
    	TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
        Account account = client.getAccount();
        log.info("Starting SMS factory");
        log.info("ToNumber = " + to);

        //Use the API to send a text message
        SmsFactory smsFactory = account.getSmsFactory();
        Map<String, String> smsParams = new HashMap<String, String>();
        log.info("PUTTING PARAMS");

        smsParams.put("To", to); 
        smsParams.put("From", "+15123841298"); // Replace with a Twilio phone number in your account
        smsParams.put("Body", body);
        log.info("Trying to send");

        try {
			Sms sms = smsFactory.create(smsParams);
	        log.info("Sent");

		} catch (TwilioRestException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
}