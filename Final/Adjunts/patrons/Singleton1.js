// Singleton Pattern (first example)
// from JavaScript Patterns by Stoyan Stefanov, OReilly 2010 isbn 978-0-596-80675-0

function Universe() {
    var instance;
    
    Universe = function() {
	      return instance;   // si instance = undefined retorna this (si invocat amb new)
    };

    Universe.prototype = this;

    instance = new Universe();

    this.constructor = Universe;

    instance.start_time = 0;
    instance.bang = "Big";

    return instance;
};

Universe.prototype.nothing = true;

var uni = new Universe;

Universe.prototype.everything = true;

var uni2 = new Universe;

console.log(uni === uni2);
console.log(uni.nothing && uni.everything && uni2.everything && uni2.nothing);
console.log(uni.bang);
console.log(uni2.bang);
console.log(uni.start_time);
console.log(uni2.start_time);
console.log(uni.constructor === Universe);

