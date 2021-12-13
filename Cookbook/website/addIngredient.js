function fields() {
	//Get user input
	var fname = document.getElementById('RecipeName').value;
	var name = fname.replace(" ", "_");
	var ingredients = document.getElementById('Ingredient').value;
	//If user input is empty, alert
	if(name.length == 0 || ingredients.length == 0) {
		window.alert("One or more fields are empty");
	}
	//Continue if user input is not empty
	else {
		//First request -- for searching if the recipe even exists
		var xhr = new XMLHttpRequest();
		var url = "https://sandbox-andy-dev-test-developer-edition.cs96.force.com/services/apexrest/cookbook/searchRecipes";
		var proxy = 'https://thingproxy.freeboard.io/fetch/';
		var result;
		var recipeId;
		xhr.open("GET", proxy+url+"?searchTerm="+name, true);
		//Response handler
		xhr.onload = function () {
			result = JSON.parse(xhr.responseText);
			//If a recipe is found
			if(result != 0) {
				//Query results for recipe that exactly matches recipe entered
				for(i = 0; i < result.length; i++) {
					//If found, continue to adding recipe
					if(result[i].name.toLowerCase() === fname.toLowerCase()) {
						recipeId = result[i].id;
						addIngredient(recipeId);
					}
				}
				//If not found, alert
				if(recipeId == null) {
					window.alert("Recipe Does Not Exist");
				}
			}
			//No recipe found
			else {
				window.alert("Recipe Does Not Exist");
			}
		}
		xhr.send(url);
		
		//Second request -- for adding ingredient to recipe
		function addIngredient(string) {
			//Creating second request
			var url2 = "https://sandbox-andy-dev-test-developer-edition.cs96.force.com/services/apexrest/cookbook/addIngredient";
			var proxy = 'https://thingproxy.freeboard.io/fetch/';
			var object = { "recipeId": recipeId, "name": ingredients };
			var result2;
			xhr.open("POST", proxy + url2, true);
			xhr.setRequestHeader("Content-Type", "application/json");
			//Second request response handler
			xhr.onload = function() {
				result2 = JSON.parse(xhr.responseText);
				window.alert("Ingredient " + ingredients + " added" );
			}
			xhr.send(JSON.stringify(object));
		}
	};
}