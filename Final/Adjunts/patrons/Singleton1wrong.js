function Universe() 
{
	var instance = this;

	this.start_time = 0;
	this.bang = "Big";

	Universe = function Universe () 
	{
		return instance;
	};
}

Universe.prototype.nothing = true;

var uni = new Universe();

Universe.prototype.everything = true;

var uni2 = new Universe();

console.log(uni === uni2); 			// true

console.log(uni.nothing);			// true
console.log(uni.everything);		// undefined
console.log(uni2.everything);		// undefined
console.log(uni2.nothing);			// true

console.log(uni.bang);				// Big
console.log(uni2.bang);				// Big
console.log(uni.start_time);		// 0
console.log(uni2.start_time);		// 0

console.log(uni.constructor === Universe);	// false


/****************
// adding to the prototype
Universe.prototype.nothing = true;
var uni = new Universe();

// again adding to the prototype
// after the initial object is created
Universe.prototype.everything = true;
var uni2 = new Universe();

// only the original prototype was
// linked to the objects
console.log(uni.nothing);
console.log(uni2.nothing);
console.log(uni.everything);
console.log(uni2.everything);

// that sounds right:
console.log(uni.constructor.name); // "Universe"
// but that's odd:
console.log(uni.constructor === Universe); // false
********************/
