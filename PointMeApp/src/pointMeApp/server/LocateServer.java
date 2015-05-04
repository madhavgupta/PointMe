package pointMeApp.server;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LocateServer extends HttpServlet{
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		//retrieve url data from datastore ie with number get location coordinates
    	String ID = getUniqueURL();
    	String input = req.getParameter("content");
    	Enumeration<?> m =req.getParameterNames();
    	while(m.hasMoreElements()){
    		System.out.println(m.nextElement());
    	}
    	TwilioController.sendMessage(input, "http://1-dot-pointmeapplication.appspot.com/locate/"+ID);

    	resp.sendRedirect("/track/"+ID);
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
