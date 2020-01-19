// Needs Rhino (https://developer.mozilla.org/es/docs/Rhino)
// *MUST* be called:
// java -cp rhino1.7.9/lib/rhino-1.7.9.jar org.mozilla.javascript.tools.shell.Main -opt -2 amb-01.js
// (this adds tail-call optimization, among other things)

function current_continuation() {
    return new Continuation();
}

var { amb_reset, fail, amb, assert } =
    ( function () {

      let fail_stack = [];

      function amb_reset() {
        fail_stack = [];
      }
      
      function fail() {
        if (fail_stack.length > 0) {
          let back_track_point = fail_stack.pop();
          back_track_point(back_track_point);
        } else {
          throw 'Ja no hi ha mes pila!';
        }
      }
      
      function amb(choices) {
        let cc = current_continuation();
        if (choices && choices.length > 0) {
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
          fail();
        }
      }
      
      return { amb_reset: amb_reset, fail: fail, amb: amb, assert: assert }
    }());

/**

Els Kalotan són una tribu desconeguda amb una característica peculiar: Els mascles sempre 
diuen la veritat. Les femelles no fan mai dues sentencies vertaderes consecutives, ni dues 
sentències falses consecutives.
Un antropòleg, anomenem-lo Worf, ha començat a estudiar els Kalotan, que parlen el llenguatge 
Kalotan. Un dia, es troba una parella (heterosexual) i el seu fill/filla Kibi. Worf pregunta 
en Kibi: "Ets un noi?" i Kibi respon en Kalotan, que l'antropòleg no entén.
Worf pregunta els pares (que entenien el català) que què ha dit en Kibi. Un dels pares respon:
"Kibi ha dit: 'sóc un noi'". L'altre afegeix: "Kibi és noia. Kibi ha mentit"
Resol el sexe de Kibi i els seus pares.

**/

function XOR(a,b) {
  return (!a != !b);
}

var progenitor1    = amb(['m','f']);
var progenitor2    = amb(['m','f']);
var kibi           = amb(['m','f']);
var kibi_va_dir    = amb(['m','f']);
var kibi_va_mentir = amb([true,false]);

// els pares han de ser de sexe diferent
assert((progenitor1 != progenitor2));

// ara el que venen són implicacions. En Javascript tenim l'operador
// ternari que ens permet implementar-les fàcilment:
// Recordem que P => Q és el mateix que !P v Q, per tant si P és 'fals'
// el resultat de P => Q és 'cert'
// Així doncs P => Q serà equivalent a [ P ? Q : true ]

// kibi és mascle => no va mentir
assert((       (kibi === 'm') ? (!kibi_va_mentir) : (true)));
// kibi va mentir => o bé va dir que era mascle i és femella o a l'inrevés
assert((     (kibi_va_mentir) ? (XOR((kibi_va_dir === 'm' && kibi === 'f'),
                                     (kibi_va_dir === 'f' && kibi === 'm'))) : (true)));
// kibi no va mentir => o bé va dir que era mascle i ho és, o va dir que era femella i ho és.
assert((    (!kibi_va_mentir) ? (XOR((kibi_va_dir === 'm' && kibi === 'm'),
                                      (kibi_va_dir === 'f' && kibi === 'f'))) : (true)));
// el primer progenitor és mascle => kibi va dir que era mascle i
// i com el segon progenitor és femella va mentir en una sentencia i va dir
// la veritat en l'altre
assert(((progenitor1 === 'm') ? (kibi_va_dir === 'm' && 
                                 XOR((kibi === 'f' && !kibi_va_mentir), 
                                     (kibi === 'm' &&  kibi_va_mentir))) : (true)));
// el primer progenitor és femella => no sabem si el que va dir
// és cert o fals, però sabem que el segon progenitor és mascle i no va mentir.
assert(((progenitor1 === 'f') ? (kibi === 'f' && kibi_va_mentir) : (true)));

print('Progenitor1 -> ', progenitor1, ' Progenitor2 -> ', progenitor2, ' Kibi -> ', kibi);
