function fields() {
	//Get user input
	var fname = document.getElementById('RecipeName').value;
	var name = fname.replace(" ", "_");
	//If input is empty
	if(name.length == 0) {
		window.alert("Recipe Name cannot be empty");
	}
	
	//Continue if field is entered correctly
	else {
		var xhr = new XMLHttpRequest();
		var url = "https://sandbox-andy-dev-test-developer-edition.cs96.force.com/services/apexrest/cookbook/searchRecipes";
		var proxy = 'https://thingproxy.freeboard.io/fetch/';
		xhr.open("GET", proxy+url+"?searchTerm="+name, true);
		//Response Handler
		xhr.onload = function () {
			var result = JSON.parse(xhr.responseText);
			var formatted = document.createElement("P");
			//If results found
			if(result != 0) {
				var searchresults = document.createTextNode("Results for " + fname);
				formatted.appendChild(searchresults);
				document.getElementById("body").appendChild(formatted);
				lb = document.createElement("br");
				document.getElementById("body").appendChild(lb);
				readArray(result);
			}
			//If no results found
			else {
				var searchresults = document.createTextNode("No results for " + fname);
				formatted.appendChild(searchresults);
				document.getElementById("body").appendChild(formatted);
			}
		}
		//Send request
		xhr.send(url);
	};
	
	function readArray(arr) {
		for(i = 0; i < arr.length; i++) {
			//Display recipe name
			var para = document.createElement("P");
			var recipenames = document.createTextNode("Recipe " + (i + 1) + ":" + " " + arr[i].name);
			para.appendChild(recipenames);
			document.getElementById("body").appendChild(para);
			//Display just the word Ingredients:
			var ingredients = document.createTextNode("Ingredients: ");
			document.getElementById("body").appendChild(ingredients);
			//Loop through ingredients and list them
			for(j = 0; j < arr[i].ingredients.length; j++) {
				var list = document.createElement("LI");
				var ingred = document.createTextNode(arr[i].ingredients[j].name);
				list.appendChild(ingred);
				document.getElementById("body").appendChild(list);
			}
			//Display directions
			var para2 = document.createElement("P");
			var directions = document.createTextNode("Directions: " + arr[i].directions);
			para2.appendChild(directions);
			document.getElementById("body").appendChild(para2);
			//Line break
			lb = document.createElement("br");
			document.getElementById("body").appendChild(lb);
		}
	}
}