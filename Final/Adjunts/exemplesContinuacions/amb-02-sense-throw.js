// Needs Rhino (https://developer.mozilla.org/es/docs/Rhino)
// *MUST* be called:
// java -cp rhino1.7.9/lib/rhino-1.7.9.jar org.mozilla.javascript.tools.shell.Main -opt -2 amb-02-sense-throw.js
// (this adds tail-call optimization, among other things)

function current_continuation() {
    return new Continuation();
}

var aturat = new Continuation();

var { fail, amb, assert } =
    ( function () {
        
        let fail_stack = [];
        
        function fail() {
            if (fail_stack.length > 0) {
                let back_track_point = fail_stack.pop();
                back_track_point(back_track_point);
            } else {
                print('Ja no hi ha mes pila');
                aturat();
            }
        }
        
        function amb(c) {
            let choices = c.slice();
            let cc = current_continuation();
            if (choices.length > 0) {
                let choice = choices.shift();
                fail_stack.push(cc);
                return choice;
            } else {
                return fail();
            }
        }
        
        // assert(condition) will cause
        // condition to be true, and if there
        // is no way to make it true, then
        // it signals and error in the program.
        
        function assert(condition) {
            if (condition) {
                return true;
            } else {
                return fail();
            }
        }
        
        return { fail: fail, amb: amb, assert: assert }
    }());

var arr = [1,2,3,4,5];

var a = amb(arr);
var b = amb(arr);
var c = amb(arr);

print(a,' -- ',b,' -- ', c);

fail();
