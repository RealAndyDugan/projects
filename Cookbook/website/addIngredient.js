function fields() {
	var fname = document.getElementById('RecipeName').value;
	var name = fname.replace(" ", "_");
	var ingredients = document.getElementById('Ingredient').value;
	if(name.length == 0 || ingredients.length == 0) {
		window.alert("One or more fields are empty");
	}
	else {
		//First Search
		var xhr = new XMLHttpRequest();
		var url = "https://sandbox-andy-dev-test-developer-edition.cs96.force.com/services/apexrest/cookbook/searchRecipes";
		var proxy = 'https://thingproxy.freeboard.io/fetch/';
		var result;
		var recipeId;
		xhr.open("GET", proxy+url+"?searchTerm="+name, true);
		xhr.onload = function () {
			result = JSON.parse(xhr.responseText);
			if(result != 0) {
				recipeId = result[0].id;
				addIngredient(recipeId);
			}
			else {
				window.alert("Recipe Does Not Exist");
			}
		}
		xhr.send(url);
		
		function addIngredient(string) {
			var url2 = "https://sandbox-andy-dev-test-developer-edition.cs96.force.com/services/apexrest/cookbook/addIngredient";
			var proxy = 'https://thingproxy.freeboard.io/fetch/';
			var object = { "recipeId": recipeId, "name": ingredients };
			var result2;
			xhr.open("POST", proxy + url2, true);
			xhr.setRequestHeader("Content-Type", "application/json");
			xhr.onload = function() {
				result2 = JSON.parse(xhr.responseText);
				window.alert("Ingredient " + ingredients + " added" );
			}
			xhr.send(JSON.stringify(object));
		}
	};
}