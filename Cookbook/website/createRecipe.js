function fields() {
	//Get user input
	var name = document.getElementById('RecipeName').value;
	var directions = document.getElementById('Directions').value;
	//If user input is null, alert
	if(name.length == 0 || directions.length == 0) {
		window.alert("One or more fields are empty");
	}
	//Else continue to HTTP request
	else {
		//Start new request with url, proxy, and create JSON object
		var xhr = new XMLHttpRequest();
		var url = "https://sandbox-andy-dev-test-developer-edition.cs96.force.com/services/apexrest/cookbook/createRecipe";
		var proxy = 'https://thingproxy.freeboard.io/fetch/';
		var object = { "name": name, "directions": directions };
		var result;
		
		//Request type and header
		xhr.open("POST", proxy + url, true);
		xhr.setRequestHeader("Content-Type", "application/json");
		
		//Request handling
		xhr.onload = function() {
			result = JSON.parse(xhr.responseText);
			console.log(result.id);
			window.alert("Recipe Created");
			//Could do this if an alert is too much
			//var res = document.getElementById("out");
			//res.intterHTML = "Recipe Created";
		}
		
		//Send request
		xhr.send(JSON.stringify(object));
	};
}
