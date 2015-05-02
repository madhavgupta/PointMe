 var id;
function updateLocation(){ 
	if(navigator.geolocation) {
		navigator.geolocation.getCurrentPosition(callbackPosition);
		alert("callbacks?");
	} else {
		alert('Location not supported by your browser');
	}
}
function callbackPosition(position) {
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
	data['id'] = id;
	$.ajax({
		url: "",
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