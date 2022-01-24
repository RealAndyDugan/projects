var numDecks = 1;
var twos = 4;
var threes = 4;
var fours = 4;
var fives = 4;
var sixes = 4;
var sevens = 4;
var eights = 4;
var nines = 4;
var tens = 4;
var jacks = 4;
var queens = 4;
var kings = 4;
var aces = 4;
var cardsRemaining = 52;
var HiLo = 0;

function setNumDecks() {
	//Get dropdown list and store value in 'n'
	var decks = document.getElementById("drop");
	var n = decks.options[decks.selectedIndex].value;
	numDecks = n;
	cardsRemaining = numDecks * 52;
	var rem = document.getElementById("cardsRem");
	rem.innerHTML = "Cards Remaining = " + cardsRemaining;
	HiLo = 0;
	var highlow = document.getElementById("hilo");
	highlow.innerHTML = "Running Count = " + HiLo;
	
	//Reset Twos
	twos = 4 * n;
	var two = document.getElementById("twos");
	two.innerHTML = "2's == " + twos;
	
	//Reset Threes
	threes = 4 * n;
	var three = document.getElementById("threes");
	three.innerHTML = "3's == " + threes;
	
	//Reset Fours
	fours = 4 * n;
	var four = document.getElementById("fours");
	four.innerHTML = "4's == " + fours;
	
	//Reset Fives
	fives = 4 * n;
	var five = document.getElementById("fives");
	five.innerHTML = "5's == " + fives;
	
	//Reset Sixes
	sixes = 4 * n;
	var six = document.getElementById("sixes");
	six.innerHTML = "6's == " + sixes;
	
	//Reset Sevens
	sevens = 4 * n;
	var seven = document.getElementById("sevens");
	seven.innerHTML = "7's == " + sevens;
	
	//Reset Eights
	eights = 4 * n;
	var eight = document.getElementById("eights");
	eight.innerHTML = "8's == " + eights;
	
	//Reset Nines
	nines = 4 * n;
	var nine = document.getElementById("nines");
	nine.innerHTML = "9's == " + nines;
	
	//Reset Tens
	tens = 4 * n;
	var ten = document.getElementById("tens");
	ten.innerHTML = "10's == " + tens;
	
	//Reset Jacks
	jacks = 4 * n;
	var jack = document.getElementById("jacks");
	jack.innerHTML = "Jacks == " + jacks;
	
	//Reset Queens
	queens = 4 * n;
	var queen = document.getElementById("queens");
	queen.innerHTML = "Queens == " + queens;
	
	//Reset Kings
	kings = 4 * n;
	var king = document.getElementById("kings");
	king.innerHTML = "Kings == " + kings;
	
	//Reset Aces
	aces = 4 * n;
	var ace = document.getElementById("aces");
	ace.innerHTML = "Aces == " + aces;
}

function twoUpdate() {
	if(twos != 0) {
		twos = twos - 1;
		var two = document.getElementById("twos");
		two.innerHTML = "2's == " + twos;
		
		cardsRemaining = cardsRemaining - 1;
		var rem = document.getElementById("cardsRem");
		rem.innerHTML = "Cards Remaining = " + cardsRemaining;
		
		HiLo = HiLo + 1;
		var highlow = document.getElementById("hilo");
		highlow.innerHTML = "Running Count = " + HiLo;
	}
	else {
		twos = 0;
	}
}

function threeUpdate() {
	if(threes != 0) {
		threes = threes - 1;
		var three = document.getElementById("threes");
		three.innerHTML = "3's == " + threes;
		
		cardsRemaining = cardsRemaining - 1;
		var rem = document.getElementById("cardsRem");
		rem.innerHTML = "Cards Remaining = " + cardsRemaining;
		
		HiLo = HiLo + 1;
		var highlow = document.getElementById("hilo");
		highlow.innerHTML = "Running Count = " + HiLo;
	}
	else {
		threes = 0;
	}
}

function fourUpdate() {
	if(fours != 0) {
		fours = fours - 1;
		var four = document.getElementById("fours");
		four.innerHTML = "4's == " + fours;
		
		cardsRemaining = cardsRemaining - 1;
		var rem = document.getElementById("cardsRem");
		rem.innerHTML = "Cards Remaining = " + cardsRemaining;
		
		HiLo = HiLo + 1;
		var highlow = document.getElementById("hilo");
		highlow.innerHTML = "Running Count = " + HiLo;
	}
	else {
		fours = 0;
	}
}

function fiveUpdate() {
	if(fives != 0) {
		fives = fives - 1;
		var five = document.getElementById("fives");
		five.innerHTML = "5's == " + fives;
		
		cardsRemaining = cardsRemaining - 1;
		var rem = document.getElementById("cardsRem");
		rem.innerHTML = "Cards Remaining = " + cardsRemaining;
		
		HiLo = HiLo + 1;
		var highlow = document.getElementById("hilo");
		highlow.innerHTML = "Running Count = " + HiLo;
	}
	else {
		fives = 0;
	}
}

function sixUpdate() {
	if(sixes != 0) {
		sixes = sixes - 1;
		var six = document.getElementById("sixes");
		six.innerHTML = "6's == " + sixes;
		
		cardsRemaining = cardsRemaining - 1;
		var rem = document.getElementById("cardsRem");
		rem.innerHTML = "Cards Remaining = " + cardsRemaining;
		
		HiLo = HiLo + 1;
		var highlow = document.getElementById("hilo");
		highlow.innerHTML = "Running Count = " + HiLo;
	}
	else {
		sixes = 0;
	}
}

function sevenUpdate() {
	if(sevens != 0) {
		sevens = sevens - 1;
		var seven = document.getElementById("sevens");
		seven.innerHTML = "7's == " + sevens;
		
		cardsRemaining = cardsRemaining - 1;
		var rem = document.getElementById("cardsRem");
		rem.innerHTML = "Cards Remaining = " + cardsRemaining;
		
		HiLo = HiLo + 0;
		var highlow = document.getElementById("hilo");
		highlow.innerHTML = "Running Count = " + HiLo;
	}
	else {
		sevens = 0;
	}
}

function eightUpdate() {
	if(eights != 0) {
		eights = eights - 1;
		var eight = document.getElementById("eights");
		eight.innerHTML = "8's == " + eights;
		
		cardsRemaining = cardsRemaining - 1;
		var rem = document.getElementById("cardsRem");
		rem.innerHTML = "Cards Remaining = " + cardsRemaining;
		
		HiLo = HiLo + 0;
		var highlow = document.getElementById("hilo");
		highlow.innerHTML = "Running Count = " + HiLo;
	}
	else {
		eights = 0;
	}
}

function nineUpdate() {
	if(nines != 0) {
		nines = nines - 1;
		var nine = document.getElementById("nines");
		nine.innerHTML = "9's == " + nines;
		
		cardsRemaining = cardsRemaining - 1;
		var rem = document.getElementById("cardsRem");
		rem.innerHTML = "Cards Remaining = " + cardsRemaining;
		
		HiLo = HiLo + 0;
		var highlow = document.getElementById("hilo");
		highlow.innerHTML = "Running Count = " + HiLo;
	}
	else {
		nines = 0;
	}
}

function tenUpdate() {
	if(tens != 0) {
		tens = tens - 1;
		var ten = document.getElementById("tens");
		ten.innerHTML = "10's == " + tens;
		
		cardsRemaining = cardsRemaining - 1;
		var rem = document.getElementById("cardsRem");
		rem.innerHTML = "Cards Remaining = " + cardsRemaining;
		
		HiLo = HiLo - 1;
		var highlow = document.getElementById("hilo");
		highlow.innerHTML = "Running Count = " + HiLo;
	}
	else {
		tens = 0;
	}
}

function jackUpdate() {
	if(jacks != 0) {
		jacks = jacks - 1;
		var jack = document.getElementById("jacks");
		jack.innerHTML = "Jacks == " + jacks;
		
		cardsRemaining = cardsRemaining - 1;
		var rem = document.getElementById("cardsRem");
		rem.innerHTML = "Cards Remaining = " + cardsRemaining;
		
		HiLo = HiLo - 1;
		var highlow = document.getElementById("hilo");
		highlow.innerHTML = "Running Count = " + HiLo;
	}
	else {
		jacks = 0;
	}
}

function queenUpdate() {
	if(queens != 0) {
		queens = queens - 1;
		var queen = document.getElementById("queens");
		queen.innerHTML = "Queens == " + queens;
		
		cardsRemaining = cardsRemaining - 1;
		var rem = document.getElementById("cardsRem");
		rem.innerHTML = "Cards Remaining = " + cardsRemaining;
		
		HiLo = HiLo - 1;
		var highlow = document.getElementById("hilo");
		highlow.innerHTML = "Running Count = " + HiLo;
	}
	else {
		queens = 0;
	}
}

function kingUpdate() {
	if(kings != 0) {
		kings = kings - 1;
		var king = document.getElementById("kings");
		king.innerHTML = "Kings == " + kings;
		
		cardsRemaining = cardsRemaining - 1;
		var rem = document.getElementById("cardsRem");
		rem.innerHTML = "Cards Remaining = " + cardsRemaining;
		
		HiLo = HiLo - 1;
		var highlow = document.getElementById("hilo");
		highlow.innerHTML = "Running Count = " + HiLo;
	}
	else {
		kings = 0;
	}
}

function aceUpdate() {
	if(aces != 0) {
		aces = aces - 1;
		var ace = document.getElementById("aces");
		ace.innerHTML = "Aces == " + aces;
		
		cardsRemaining = cardsRemaining - 1;
		var rem = document.getElementById("cardsRem");
		rem.innerHTML = "Cards Remaining = " + cardsRemaining;
		
		HiLo = HiLo - 1;
		var highlow = document.getElementById("hilo");
		highlow.innerHTML = "Running Count = " + HiLo;
	}
	else {
		aces = 0;
	}
}

function odds() {
	
}