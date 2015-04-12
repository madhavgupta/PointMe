package pointMeApp.server;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;

@Entity
public class Point {
    @Id Long id;
    @Index String license;
    Double latitude;
    Double longitude;
    String number;
    private Point() {}
    public Point(Long id, Double latitude, Double longitude) {
    	this.id = id;
    	this.latitude = latitude;
    	this.longitude = longitude;
    }
    public Point(Long id, Double latitude, Double longitude, String number_s) {
    	this.number = number_s;
    	this.id = id;
    	this.latitude = latitude;
    	this.longitude = longitude;
    }
}