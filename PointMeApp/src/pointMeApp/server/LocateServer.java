package pointMeApp.server;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LocateServer extends HttpServlet{
	public void doGet(HttpServletRequest req, HttpServletResponse resp){
		//retrieve url data from datastore ie with number get location coordinates

	}
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException{
    	String ID = getUniqueURL();
    	resp.sendRedirect("/track/"+ID);
    }
    	private String getUniqueURL() {
		// TODO Auto-generated method stub
		int val = (int) (Math.random()*100000);
		String generated = ""+val;
		return generated;
	}
}
