function fields() {
	var name = document.getElementById('RecipeName').value;
	var directions = document.getElementById('Directions').value;
	if(name.length == 0 || directions.length == 0) {
		window.alert("One or more fields are empty");
	}
	else {
		var xhr = new XMLHttpRequest();
		var url = "https://sandbox-andy-dev-test-developer-edition.cs96.force.com/services/apexrest/cookbook/createRecipe";
		var proxy = 'https://thingproxy.freeboard.io/fetch/';
		var object = { "name": name, "directions": directions };
		var result;
		xhr.open("POST", proxy + url, true);
		xhr.setRequestHeader("Content-Type", "application/json");
		xhr.onload = function() {
			result = JSON.parse(xhr.responseText);
			console.log(result.id);
			window.alert("Recipe Created");
		}
		xhr.send(JSON.stringify(object));
	};
}
