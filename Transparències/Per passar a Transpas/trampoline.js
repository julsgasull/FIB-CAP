// esquema general TRAMPOLINE

const f =
(
	function()
	{
		function_f(aa1, aa2, ..., aaN)
		{
			if (recursiveCase)
			{
				return function() { return __f(...);};
			}
			return baseCase;
		};

		return function (a1, a2, ..., aN)
		{
			trampoline (__f(a1, a2, ..., aN));
		}
	}
)();