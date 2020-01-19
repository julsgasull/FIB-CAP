// Factory Pattern
// from JavaScript Patterns by Stoyan Stefanov, OReilly 2010 isbn 978-0-596-80675-0

// constructor
function CarMaker() {}

// Mètode  de la classe pare
CarMaker.prototype.drive = function () {
    return "Vroom, Tinc " + this.doors + " portes";
};

// el mètode estàtic de la fàbrica

CarMaker.factory = function (type) {
    var constr = type, 
        newcar;
    
    if (typeof CarMaker[constr] !== "function") {  // error si el constructor no existeix
	throw { name: "Error",
		message: constr + " doesn't exist"
	      };
    }

    if (typeof CarMaker[constr].prototype.drive !== "function") { // el constructor existeix,
	CarMaker[constr].prototype =  new CarMaker();              // hereda el pare, només 1 cop
	if (CarMaker[constr].prototype.hasOwnProperty('constructor'))
	    console.log(CarMaker[constr].prototype.constructor);
	CarMaker[constr].prototype.constructor = CarMaker[constr];	
    }

    newcar = new CarMaker[constr](); // crea una nova instància 
 
    // aqui podriem fer més feina i en acabar retornem...

    return newcar;
}

// defineix objectes que pot fabricar, en forma de constructors associats a propietats de la fàbrica
CarMaker.Compact = function () {
    this.doors = 4;
}; 
CarMaker.Convertible = function () {
    this.doors = 2;
}; 
CarMaker.SUV = function () {
    this.doors = 24;
};

var corolla = CarMaker.factory('Compact'); 
var solstice = CarMaker.factory('Convertible'); 
var cherokee = CarMaker.factory('SUV'); 
console.log(corolla.drive()); 
console.log(solstice.drive());
console.log(cherokee.drive());
