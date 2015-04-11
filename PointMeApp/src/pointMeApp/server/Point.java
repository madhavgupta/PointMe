package pointMeApp.server;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;

@Entity
public class Point {
    @Id Long id;
    @Index String license;
    int latitude;
    int longitude;
    private Point() {}
    public Point(Long id, int latitude, int longitude) {
    	this.id = id;
    	this.latitude = latitude;
    	this.longitude = longitude;
    }
}