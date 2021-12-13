function health() {
	var xhr = new XMLHttpRequest();
	var url = "https://sandbox-andy-dev-test-developer-edition.cs96.force.com/services/apexrest/cookbook/healthCheck";
	var proxy = 'https://thingproxy.freeboard.io/fetch/';
	xhr.open("GET", proxy+url, true);
	//Response Handler
	xhr.onload = function () {
		var result = xhr.responseText;
		console.log(result);
		var div = document.getElementById("check");
		div.innerHTML += result;
	}
	//Send request
	xhr.send(url);
}

//Does xhr even support DELETE requests?
function clear() {
/* 	var xhr = new XMLHttpRequest();
	var url = "https://sandbox-andy-dev-test-developer-edition.cs96.force.com/services/apexrest/cookbook/clearDatabase";
	var proxy = 'https://thingproxy.freeboard.io/fetch/';
	xhr.open("DELETE", proxy+url, true);
	//Response Handler
	xhr.onload = function () {
		var result = xhr.responseText;
		console.log(result);
		var div = document.getElementById("clear");
		div.innerHTML += result;
	}
	//Send request
	xhr.send(url); */
}