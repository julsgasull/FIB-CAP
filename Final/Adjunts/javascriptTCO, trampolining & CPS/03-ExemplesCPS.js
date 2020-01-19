function id(x) {
    console.log(x);
    return x;
}

//------------------------------------------------------------------------------

function remove(arr,e) {
    if (arr.length == 0) {
	      return [];
    } else {
	      var [car,...cdr] = arr;
	      var rem = remove(cdr,e)
	      if (car != e) {
	          rem.unshift(car)
	      }
	      return rem;
    }
}

function remove_cps1(arr,e,ret) {
    if (arr.length === 0) {
	      return ret([]);
    } else {
	      var [car,...cdr] = arr;
	      if (car === e) {
	          return remove_cps1(cdr,e,ret)
	      } else {
	          return remove_cps1(cdr,e,function(v) {
		            v.unshift(car);
		            return ret(v) })}}}

function remove_cps2(arr,e,ret) {
    if (arr.length === 0) {
	      return ret([]);
    } else {
	      var [car,...cdr] = arr;
	      return remove_cps2(cdr,e, function (rcdr) {
	          if (car != e) {
		            rcdr.unshift(car);
	          }	
	          return ret(rcdr)})}}

/**
var arr = [1,2,3,4,5,4,3,2,1];

console.log(remove_cps1(arr,2,id));
console.log(remove_cps1(arr,5,id));
console.log(remove_cps1(arr,8,id));

console.log('---------------------------------');

console.log(remove_cps2(arr,2,id));
console.log(remove_cps2(arr,5,id));
console.log(remove_cps2(arr,8,id));
**/

//------------------------------------------------------------------------------

function forEach(arr, body, start) {
    if (0 <= start && start < arr.length) {
	      body(arr[start], start, arr);
	      return forEach(arr, body, start+1);
    }
}

// forEach(arr, function (e,i,a) { console.log(e) }, 0)

//------------------------------------------------------------------------------

var kont;

function callcc (f, cc) {
    return f( function (x, ret) { cc(x) },
	            cc );
}

function fact_cps(n, ret) {
    if (n <= 1) {
	      return callcc( function (cc, ret) {
	          kont = cc;
	          return ret(1);
	      }, ret);
    }
    else {
	      return fact_cps (n-1, function (v) {
            return ret(v*n)
	      })
    }
}


/****
fact_cps(5,id)
console.log('-----------------');
kont(1,id);
kont(2,id);
kont(3,id);
****/

//------------------------------------------------------------------------------

function f(x) {
    return x
}

function g(x,y) {
    return x+y
}

function h(x,y,z) {
    return x+y+z
}

function demo (x, y) {
    return ((x === 0) ?
	          17 :
	          (x === 1) ?
	          f(x) :
	          (x === 2) ?
	          22 + f(x) :
	          (x === 3) ?	
	          g(22,f(x)):
	          (x === 4) ?	
	          f(x) + 33 + g(y,y) :
	          h(f(x), 44-y, g(y,y)))
}

function f_cps(x,cont) {
    return cont(x)
}

function g_cps(x,y,cont) {
    return cont(x+y)
}

function h_cps(x,y,z,cont) {
    return cont(x+y+z)
}

function demo_cps (x, y, cont) {
    return ((x === 0) ?
	          cont(17) :
	          (x === 1) ?
	          f_cps(x,cont) :
	          (x === 2) ?
	          f_cps(x, function (v) { return cont(22 + v) }) :
	          (x === 3) ?	
	          f_cps(x, function (v) { return g_cps(22,v,cont) }):
	          (x === 4) ?	
	          f_cps(x, function (v1) {
		            return g_cps(y, y, function (v2) {
		                return cont(33 + v1 + v2) })}) :
	          f_cps(x, function (v1) {
		            return g_cps(y, y, function (v2) {
		                return h_cps(v1, 44-y, v2, cont) } )} ))
}
