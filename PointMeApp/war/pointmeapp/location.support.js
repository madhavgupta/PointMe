var id = 0;
function updateLocation(){ 
	var options = {
  		enableHighAccuracy: true,
  		timeout: 5000,
  		maximumAge: 0
	};
	if(navigator.geolocation) {
		console.log("about to call geolocate");
		navigator.geolocation.getCurrentPosition(callbackPosition, errorHandler,options);
	} else {
		alert('Location not supported by your browser');
	}
}
function errorHandler(error) {
	alert(error);
	console.log('in error hanlder');
}
function callbackPosition(position) {
		console.log('success');

	var data = {};
	alert(position.coords.longitude + ","+position.coords.latitude);
	data['long'] = position.coords.longitude;
	data['lat'] = position.coords.latitude;
			alert(document.cookie);

	if(document.cookie == "") {
		alert(document.cookie);
		alert('CREATING NEW ID');
		id = hashCode(Date());
		document.cookie = id;
	} else {
			alert('ID ALREADY CREATED. ' + document.cookie);
	}
	var id = "DINGINGING";
	data['identifier'] = document.cookie;
	$.ajax({
		url: "/registerLocation",
		data: data,
		method: "POST",
		success: function(msg) {
			alert(msg);
		},
	});
}
function hashCode(s) {
	return s.split("").reduce(function (a, b) {a=((a<<5) - a) + b.charCodeAt(0); return a&a},0);

}
