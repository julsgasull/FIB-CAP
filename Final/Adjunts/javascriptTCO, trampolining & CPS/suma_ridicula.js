function suma_ridicula(m,n) 
{
	if (n == 0) 
	{
        return m;
	} else 
	{
		return suma_ridicula(m+1,n­1);
	}
} 


// ESQUEMA GENERAL:
// const f = 
// (
//     function () 
//     {
//         function __f(aa1, aa2, ... , aaN) 
//         {
//             if recursiveCase 
//             { 
//                 return function ()
//                 {
//                     return __f(...);
//                 }; 
//             }
//             return baseCase;
//         };
//         return function (a1, a2, ... , aN) 
//         {
//             trampoline(__f(a1, a2, ... , aN));
//         }
//     }
// )();

function trampoline (fun) 
{    
    while (typeof fun == 'function') 
    {
	    fun = fun();
    }
    return fun;
};

const f =
(
	function()
	{
		function suma_ridicula_TCO(m,n)
		{
			if (n != 0)
			{
				return function()
				{
					return suma_ridicula_TCO(m+1,n­1);
				};
			}
			return m;
		}
		return function (m,n)
		{
			trampoline(suma_ridicula_TCO(m,n));
		}
	}
)();