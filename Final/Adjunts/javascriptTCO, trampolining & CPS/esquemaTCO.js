// ESQUEMA GENERAL:
const f = 
(
    function () 
    {
        function __f(aa1, aa2, ... , aaN) 
        {
            if recursiveCase 
            { 
                return function ()
                {
                    return __f(...);
                }; 
            }
            return baseCase;
        };
        return function (a1, a2, ... , aN) 
        {
            trampoline(__f(a1, a2, ... , aN));
        }
    }
)();

function trampoline (fun) 
{    
    while (typeof fun == 'function') 
    {
	      fun = fun();
    }
    return fun;
};