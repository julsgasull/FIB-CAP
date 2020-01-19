function A() 
{
	this.a = 0;
	this.b = 1; 
}

A.prototype.retornaA = function() 
{ 
	return this.a 
} 

A.prototype.retornaB = function() 
{ 
	return this.b 
}

var aa = new A();
aa.a = aa.a + 1;
aa.b = aa.b + 1; 
console.log(aa.retornaA()); 
console.log(aa.retornaB());

function inherit(p) 
{
	if (p == null) 
	{
		throw TypeError(); // p no ha de ser null 
	}
	var t = typeof p;
	if (t !== "object" && t !== "function") 
	{
		throw TypeError(); 
	}
	function f() {};
	f.prototype = p;
	return new f();
}

function B() 
{ 
	A.call(this);
	this.a = 100; 
	this.c = 101;
}

B.prototype = inherit(A.prototype);
B.prototype.constructor = B;

B.prototype.retornaC = function() 
{ 
	return this.c 
}
// provem...
var bb = new B(); 
console.log(bb.retornaA()); 
console.log(bb.retornaB()); 
console.log(bb.retornaC());