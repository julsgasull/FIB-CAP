// Decorator Pattern (first example)
// from JavaScript Patterns by Stoyan Stefanov, OReilly 2010 isbn 978-0-596-80675-0

function Sale(price) { 
    this.price = price || 100;
} 

Sale.prototype.getPrice = function () {
    return this.price;
};


Sale.prototype.decorate = function (decorator) { 
    var F = function () {},
        overrides = this.constructor.decorators[decorator], // this és l'objecte que està a l'esquerra del '.'
        i, newobj;                                          // this.constructor seria l'objecte 'Sale'
    
    F.prototype = this; 
    newobj = new F(); 
    newobj.uber = F.prototype;   // newobj.uber === newobj.__proto__ (si existeix __proto__)
    
    for (i in overrides) {
	if (overrides.hasOwnProperty(i)) { 
	    // console.log(decorator + ' ' + i);
	    newobj[i] = overrides[i];  // copiem a newobj totes les propietats del decorador, en aquest cas només 
	}                              // hi ha 'get_price'
    }

    return newobj;
};



// Els objecte decoradors s'implementaran com a propietats d'una propietat del constructor
Sale.decorators = {};

Sale.decorators.fedtax = { 
    getPrice: function () {
	var price = this.uber.getPrice(); 
	price += price * 5 / 100; 
	return price;
    }
};

Sale.decorators.quebec = { 
    getPrice: function () {
	var price = this.uber.getPrice(); 
	price += price * 7.5 / 100; 
	return price;
    }
};

Sale.decorators.money = { 
    getPrice: function () {
	return "$ " + this.uber.getPrice().toFixed(2); 
    }
};

Sale.decorators.cdn = { 
    getPrice: function () {
	return "CDN$ " + this.uber.getPrice().toFixed(2); 
    }
};


var sale = new Sale(100); 
sale = sale.decorate('fedtax'); 
sale = sale.decorate('quebec'); 
sale = sale.decorate('money'); 
console.log(sale.getPrice());

var sale = new Sale(100); 
sale = sale.decorate('fedtax'); 
sale = sale.decorate('cdn'); 
console.log(sale.getPrice());
