// ----------------------------------------------------------
// ----------------------------------------------------------
// From http://2ality.com/2015/06/tail-call-optimization.html
// ----------------------------------------------------------
// ----------------------------------------------------------

// The conditional operator (? :)  

const a = x => x ? f() : g();

// Both f() and g() are in tail position.

//-------------------------------------------------------------------------------------

// The logical Or operator (||)  
const a = () => f() || g();

// f() is not in a tail position, but g() is in a tail position. To
// see why, take a look at the following code, which is equivalent to the
// previous code:

const a = () => {
    let fResult = f(); // not a tail call
    if (fResult) {
        return fResult;
    } else {
        return g(); // tail call
    }
};

// The result of the logical Or operator depends on the result of f(),
// which is why that function call is not in a tail position (the caller
// does something with it other than returning it). However, g() is in a
// tail position.

//-------------------------------------------------------------------------------------

// The logical And operator  

const a = () => f() && g();

// f() is not in a tail position, but g() is in a tail position. To
// see why, take a look at the following code, which is equivalent to
// the previous code:

const a = () => {
    let fResult = f(); // not a tail call
    if (!fResult) {
        return fResult;
    } else {
        return g(); // tail call
    }
};

// The result of the logical And operator depends on the result of
// f(), which is why that function call is not in a tail position (the
// caller does something with it other than returning it). However,
// g() is in a tail position.

//-------------------------------------------------------------------------------------

// The comma operator (,)  

const a = () => (f() , g());

// f() is not in a tail position, but g() is in a tail position. To
// see why, take a look at the following code, which is equivalent to
// the previous code:

const a = () => {
    f();
    return g();
}

//Tail calls in statements  
//------------------------

// For statements, the following rules apply.

// Only these compound statements can contain tail calls:

// Blocks (as delimited by {}, with or without a label)

// if: in either the “then” clause or the “else” clause.

// do-while, while, for: in their bodies.

// switch: in its body.

// try-catch: only in the catch clause. The try clause has the catch clause as a context that can’t
// be optimized away.

// try-finally, try-catch-finally: only in the finally clause, which is a context of the other
// clauses that can’t be optimized away.

// Of all the atomic (non-compound) statements,
// only return can contain a tail call. All other statements have
// context that can’t be optimized away. The following statement
// contains a tail call if expr contains a tail call.
// return «expr»;


//-------------------------------------------------------
// Tail call optimization can only be made in strict mode
//-------------------------------------------------------

// In non-strict mode most engines have the following two properties that allow you to
// examine the call stack:

// func.arguments: contains the arguments of the most recent invocation of func.

// func.caller: refers to the function that most recently called func.

// With tail call optimization, these properties don’t work, because
// the information that they rely on may have been removed. Therefore,
// strict mode forbids these properties (as described in the language
// specification) and tail call optimization only works in strict
// mode.


//--------------------------------------------------------
// Pitfall: solo function calls are never in tail position  
// The function call bar() in the following code is not in tail position:

function foo() {
    bar(); // this is not a tail call in JS
}

// The reason is that the last action of foo() is not the function
// call bar(), it is (implicitly) returning undefined. In other words,
// foo() behaves like this:

function foo() {
    bar();
    return undefined;
}

// Callers can rely on foo() always returning undefined. If bar() were
// to return a result for foo(), due to tail call optimization, then
// that would change foo’s behavior.

// Therefore, if we want bar() to be a tail call, we have to change foo() as follows.

function foo() {
    return bar(); // tail call
}
//--------------------------------------------------------

// Tail-recursive functions  
// A function is tail-recursive if the main recursive calls it makes are in tail positions.

// For example, the following function is not tail recursive, because
// the main recursive call in line A is not in a tail position:

function factorial(x) {
    if (x <= 0) {
        return 1;
    } else {
        return x * factorial(x-1); // (A)
    }
}

// factorial() can be implemented via a tail-recursive helper function
// facRec(). The main recursive call in line A is in a tail position.

function factorial(n) {
    return facRec(n, 1);
}
function facRec(x, acc) {
    if (x <= 1) {
        return acc;
    } else {
        return facRec(x-1, x*acc); // (A)
    }
}

// That is, some non-tail-recursive functions can be transformed into
// tail-recursive functions.

// Tail-recursive loops  

// Tail call optimization makes it possible to implement loops via
// recursion without growing the stack. The following are two
// examples.

// ------------forEach()  
function forEach(arr, callback, start = 0) {
    if (0 <= start && start < arr.length) {
        callback(arr[start], start, arr);
        return forEach(arr, callback, start+1); // tail call
    }
}
//forEach(['a', 'b'], (elem, i) => console.log(`${i}. ${elem}`));
//forEach([...Array(100000).keys()],function (elem, i) { console.log(i, elem ) } )

// ------------findIndex()  
function findIndex(arr, predicate, start = 0) {
    if (0 <= start && start < arr.length) {
        if (predicate(arr[start])) {
            return start;
        }
        return findIndex(arr, predicate, start+1); // tail call
    }
}
//findIndex(['a', 'b'], x => x === 'b'); // 1
