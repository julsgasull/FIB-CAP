// Decorator Pattern (second example)
// from JavaScript Patterns by Stoyan Stefanov, OReilly 2010 isbn 978-0-596-80675-0

function Sale(price) { 
    this.price = price || 100;
    this.decorators_list = [];
} 

Sale.prototype.getPrice = function () {
    var price = this.price,
    i,
    max = this.decorators_list.length,
    name;

    for (i=0; i < max; i += 1) {     // això s'ha de fer per a tots els mètodes "decorables"
	name = this.decorators_list[i];
	price = Sale.decorators[name].getPrice(price);
    }

    return price;
};


Sale.prototype.decorate = function (decorator) { 
    this.decorators_list.push(decorator);
};

// Els objecte decoradors s'implementaran com a propietats d'una propietat del constructor
Sale.decorators = {};

Sale.decorators.fedtax = { 
    getPrice: function (price) {
	return price + price * 5 / 100; 
    }
};

Sale.decorators.quebec = { 
    getPrice: function (price) {
	return price + price * 7.5 / 100; 
    }
};

Sale.decorators.money = { 
    getPrice: function (price) {
	return "$ " + price.toFixed(2); 
    }
};

Sale.decorators.cdn = { 
    getPrice: function (price) {
	return "CDN$ " + price.toFixed(2); 
    }
};



var sale = new Sale(100); 
sale.decorate('fedtax'); 
sale.decorate('quebec');
sale.decorate('money'); 
console.log(sale.getPrice());

var sale = new Sale(100); 
sale.decorate('fedtax'); 
sale.decorate('cdn'); 
console.log(sale.getPrice());
