
function Subject() 
{ 
	this.observers = [];
}
Subject.prototype.attach = function (observer) 
{ 
	this.observers.push(observer);
}
Subject.prototype.detach = function (observer) 
{ 
	this.observers = this.observers.filter( function (obs) {return (obs !== observer);} )
}
Subject.prototype.notify = function () 
{ 
	this.observers.forEach( function (observer) { observer.update(this); })
}
Subject.prototype.getState = function () 
{ 
	/* . . . */ 
} 

function Observer() { }
Observer.prototype.update = function (subject) 
{
	/* ... fer alguna cosa amb subject.getState() ... */
}
