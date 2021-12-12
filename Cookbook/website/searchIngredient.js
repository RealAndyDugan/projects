function fields() {
	var fname = document.getElementById('Ingredient').value;
	var name = fname.replace(" ", "_");
	if(name.length == 0) {
		window.alert("You have to enter an ingredient");
	}
	else {
		var xhr = new XMLHttpRequest();
		var url = "https://sandbox-andy-dev-test-developer-edition.cs96.force.com/services/apexrest/cookbook/searchIngredients";
		var proxy = 'https://thingproxy.freeboard.io/fetch/';
		xhr.open("GET", proxy+url+"?searchTerm="+name, true);
		xhr.onload = function () {
			var result = JSON.parse(xhr.responseText);
			var formatted = document.createElement("P");
			//If results found
			if(result != 0) {
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
			//Display ingredient name
			var para = document.createElement("P");
			var inNames = document.createTextNode("Recipes with Ingredient: " + arr[i].name);
			para.appendChild(inNames);
			document.getElementById("body").appendChild(para);
			//Display list of recipes
			for(j = 0; j < arr[i].recipes.length; j++) {
				var list = document.createElement("LI");
				var recipes = document.createTextNode(arr[i].recipes[j].name);
				list.appendChild(recipes);
				document.getElementById("body").appendChild(list);
			}
			//Line break
			lb = document.createElement("br");
			document.getElementById("body").appendChild(lb);
		}
	}
}