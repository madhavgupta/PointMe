package pointMeApp;

import static org.junit.Assert.*;

import org.junit.Test;

public class LocationTest {
	/*
	 * The location test will be used to ensure the proper functionality of the location class
	 * we will try getting the location of a location object and comparing it to the preset values
	 */
	@Test
	public void LocationTest() {
		fail("Not yet implemented");
	}
	/*
	 * This test should verify whether we are able to create an observer properly.  When the user creates the receiver class they will
	 * register to be an observer to any changes in the location of the sender or the receiver
	 */
	@Test
	public void newOperationTest() {
		fail("Not yet implemented");
	}
	/*
	 * This test should ensure that the sender creates a signleton which will be used to register observers.
	 * The observers will access the singleton object and monitor for any changes in location
	 */
		@Test
	public void registerObserverTest() {
		fail("Not yet implemented");
	}
		/*
		 * this test should ensure that the link expires after the user expires the link.
		 * After the link is expired the Subject class will unregister all observers
		 */
	@Test
	public void unregisterObserverTest() {
		fail("Not yet implemented");
	}
	/*
	 * This test will be used to ensure that the distances and angles are calculated properly.
	 * a perset value will be passed to the calcDistance function and will be used to determine 
	 * whether we get the correct output
	 */
		@Test
	public void calculateDistanceTest() {
		fail("Not yet implemented");
	}
		/*
		 * this test will be used to ensure that when we attempt to get the location values from
		 * our various objects it will achieve proper functionality.  we will use the same method as in the
		 * calculate distance test above
		 */
		@Test
	public void getLocationTest() {
		fail("Not yet implemented");
	}
		/*
		 * This test will be used to ensure that all values are being updated properly for both the sender and the receiver
		 * All location values should be updated in both the sender and receiver when there is a change in either the 
		 * sender or the receivers location.
		 */
		@Test
	public void UpdateTest() {
		fail("Not yet implemented");
	}
}
