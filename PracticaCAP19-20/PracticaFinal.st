alObject subclass: #Coroutine	instanceVariableNames: 'dream kick'	classVariableNames: ''	poolDictionaries: ''	category: 'Practica'!!Coroutine commentStamp: '<historical>' prior: 0!A CoroutineCont is a coroutine.

Instance Variables
	block:		<Object>
	cont:		<Object>
	first:		<Object>

block
	- block that contains the coroutine code

cont
	- continuation where the coroutine stopped execution
!!Coroutine methodsFor: 'initialization' stamp: 'Juls 1/13/2020 16:13'!initializeWith: aBlock 
	"initialize with a block with coroutine code"
	dream := aBlock.
	kick := nil.! !!Coroutine methodsFor: 'accessing' stamp: 'Juls 1/13/2020 16:13'!reset	kick := nil.	! !!Coroutine methodsFor: 'accessing' stamp: 'Juls 1/13/2020 16:13'!value: aValue
	^ (kick isNil) 
		ifTrue: 		[ 
			dream 			value: 			[ 				:coroutine :value | 
					Continuation callcc: 					[ 						:executionFlow |
							kick := executionFlow.
							coroutine value: value.
					]
			]			value: aValue.
		]
		ifFalse: 		[ 
			| kickTmp |
			kickTmp := kick.
			kick := nil.
			kickTmp value: aValue.
		]! !"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!Coroutine class	instanceVariableNames: ''!!Coroutine class methodsFor: 'instance creation' stamp: 'Juls 1/13/2020 16:13'!maker: aBlock 
	^ Coroutine new initializeWith: aBlock.! !TestCase subclass: #CoroutineTest	instanceVariableNames: 'sumOneToNTestResult1 sumOneToNTestResult2 sumOneToNTestResult3 enunciatTestResult philosophyTestResult primeTestResult greaseTestResult'	classVariableNames: ''	poolDictionaries: ''	category: 'Practica'!!CoroutineTest methodsFor: 'tests' stamp: 'Juls 1/13/2020 16:33'!testPhilosophy
	| res a b c words |
	a := b := c := nil.
	res := OrderedCollection new.
	words := OrderedCollection withAll: #('life' 'death' 'dying' 'all of us').
		a := Coroutine maker: 	[ 		:resume :value |
			[ (words size) > 1 ] whileTrue: 			[ 
				res add: (resume value: c value: (words first)); add: Character cr asString.
			].
	].
		b := Coroutine maker: 	[ 		:resume :value |
			[ true ] whileTrue: 			[ 
				res add: (resume value: a value: (words first)).
			].
	].
		c := Coroutine maker: 	[ 		:resume :value |
			res add: value; add: ' leads to '.
			[ true ] whileTrue: 			[ 
				words removeFirst.
				res add: (resume value: b value: ' leads to ').
			].
	].
		a value: nil.
		res := res joinUsing: ''.
	self assert: philosophyTestResult equals: res.! !!CoroutineTest methodsFor: 'tests' stamp: 'Juls 1/13/2020 16:33'!testGrease	"test reset function from Coroutine"	| res singer chorus |	res := OrderedCollection new.	singer := Coroutine maker: 	[ 		:resume :value | 			res add: '- Go, grease lightnin'', you''re burnin'' up the quarter mile'.			res add: (resume value: chorus value: nil).			chorus reset.			res add: '- Go, grease lightnin'', you''re coastin'' through the heat lap trials'.			res add: (resume value: chorus value: nil).			res add: (resume value: chorus value: nil) 	].	chorus := Coroutine maker: 	[ 		:resume :value | 			resume				value: singer				value: '	- Grease lightnin'', go grease lightnin'''.			resume				value: singer				value:'...Can we go home now?' 	].		singer value: nil.		res := res joinUsing: Character cr asString.	self assert: greaseTestResult equals: res! !!CoroutineTest methodsFor: 'tests' stamp: 'Juls 1/13/2020 16:34'!testSum	"Utilitza corrutines per fer el sumatori"	| sum res1 res2 res3 |	sum := nil.		sum := Coroutine maker: 	[ 		:resume :value |			| total remanent |			total := 0.			remanent := value.			[ remanent > 0 ] whileTrue: 			[ 				total := total + remanent.				remanent := (resume value: sum value: (remanent - 1)).			].		total.	].	res1 := sum value: 200.	res2 := sum value: 5.	res3 := sum value: 0.		self assert: res1 equals: sumOneToNTestResult1.	self assert: res2 equals: sumOneToNTestResult2.	self assert: res3 equals: sumOneToNTestResult3.! !!CoroutineTest methodsFor: 'tests' stamp: 'Juls 1/13/2020 16:34'!testPrimes	| main res gen returnIfPrime |	main := nil.	gen := nil.		returnIfPrime := 	[ 		:n |			| ret |			ret := n.			(n < 2)				ifTrue: [ ret := nil ]				ifFalse: 				[ 					(2 to: (n sqrtFloor)) do: 					[ 						:each |							( (n \\ each) = 0 ) ifTrue: [ ret := nil ]					]				].			ret.	].		gen := 		Coroutine maker: 		[ 			:resume :value |				| index | 				index := 1.				[ true ] whileTrue: 				[ 					resume value: main value: (returnIfPrime value: index).					index := index + 1.				].	].	main := 		Coroutine maker: 		[  			:resume :value |				| num |				(1 to: value) do: 				[ 					:i |						num := (resume value: gen value: nil).						num ifNotNil: [ res add: num ].				].		].	res := OrderedCollection new.	main value: 25.		res := res joinUsing: Character cr asString.	self assert: primeTestResult equals: res.! !!CoroutineTest methodsFor: 'tests' stamp: 'Juls 1/13/2020 16:32'!testEnunciat	"test given with the problem statement"	| res a b c |	a := b := c := 0.	res := OrderedCollection new.	a := Coroutine maker: 	[ 		:resume :value | 			res add: 'This is A'.			res add: 'Came from ' , (resume value: b value: 'A').			res add: 'Back in A'.			res add: 'Came from ' , (resume value: c value: 'A') 	].	b := Coroutine maker: 	[ 		:resume :value | 			res add: '       This is B'.			res add: '       Came from ' , (resume value: c value: 'B').			res add: '       Back in B'.			res add: '       Came from ' , (resume value: a value: 'B') 	].	c := Coroutine maker: 	[ 		:resume :value | 			res add: '           This is C'.			res add: '           Came from ' , (resume value: a value: 'C').			res add: '           Back in C'.			res add: '           Came from ' , (resume value: b value: 'C') 	].		a value: nil.		res := res joinUsing: Character cr asString.	self assert: enunciatTestResult equals: res! !!CoroutineTest methodsFor: 'initialization' stamp: 'Juls 1/13/2020 16:17'!setUp
	"setup method"
	enunciatTestResult := 
'This is A       This is B           This is CCame from CBack in A           Came from A           Back in C       Came from C       Back in BCame from B'.	sumOneToNTestResult1 := 20100.	sumOneToNTestResult2 := 15.	sumOneToNTestResult3 := 0.
	
	philosophyTestResult := 
'life leads to deathdeath leads to dyingdying leads to all of us'.
	
	primeTestResult := '23571113171923'.
	greaseTestResult :='- Go, grease lightnin'', you''re burnin'' up the quarter mile	- Grease lightnin'', go grease lightnin''- Go, grease lightnin'', you''re coastin'' through the heat lap trials	- Grease lightnin'', go grease lightnin''...Can we go home now?'.! !Object subclass: #StableMarriage	instanceVariableNames: 'solver trace maxn men women menRanking womenRanking menChoice womenChoice menEngagement womenEngagement womenRankingOrder'	classVariableNames: ''	poolDictionaries: ''	category: 'Practica'!!StableMarriage commentStamp: '<historical>' prior: 0!A StableMarriage solves the 'stable marriage' problem using coroutines.
!!StableMarriage methodsFor: 'accessing' stamp: 'Juls 1/13/2020 16:25'!womenRanking: anArray
	womenRanking := anArray ! !!StableMarriage methodsFor: 'accessing' stamp: 'Juls 1/13/2020 16:25'!women
	^ women ! !!StableMarriage methodsFor: 'accessing' stamp: 'Juls 1/13/2020 16:25'!solver: anObject	^ solver := anObject ! !!StableMarriage methodsFor: 'accessing' stamp: 'Juls 1/13/2020 16:24'!menRanking: anArray
	menRanking := anArray ! !!StableMarriage methodsFor: 'accessing' stamp: 'Juls 1/13/2020 16:24'!menRanking
	^ menRanking ! !!StableMarriage methodsFor: 'accessing' stamp: 'Juls 1/13/2020 16:23'!men
	^ men ! !!StableMarriage methodsFor: 'accessing' stamp: 'Juls 1/13/2020 16:23'!maxn	^ maxn ! !!StableMarriage methodsFor: 'accessing' stamp: 'Juls 1/13/2020 16:23'!men: anArray
	men := anArray ! !!StableMarriage methodsFor: 'accessing' stamp: 'Juls 1/13/2020 16:23'!maxn: anObject	maxn := anObject	! !!StableMarriage methodsFor: 'accessing' stamp: 'Juls 1/13/2020 16:25'!trace
	^ trace ! !!StableMarriage methodsFor: 'accessing' stamp: 'Juls 1/13/2020 16:25'!women: anArray
	women := anArray ! !!StableMarriage methodsFor: 'accessing' stamp: 'Juls 1/13/2020 16:25'!womenRanking
	^ womenRanking ! !!StableMarriage methodsFor: 'accessing' stamp: 'Juls 1/13/2020 16:25'!trace: aBool
	trace := aBool ! !!StableMarriage methodsFor: 'accessing' stamp: 'Juls 1/13/2020 16:25'!solver	^ solver ! !!StableMarriage methodsFor: 'others' stamp: 'Juls 1/13/2020 16:50'!prepareParameters
	"prepare paramters to solve the problem"
	maxn := men size.
	
	"engagements for men and women"
	menEngagement := Array new: maxn.
	womenEngagement := Array new: maxn.
	
	"woman preferences by man index"
	womenRankingOrder := 		(1 to: maxn) collect: 		[ 			:i |
			| prefs prefsOrd |
			prefs := womenRanking at: i.
			prefsOrd := Array new: maxn.
			(1 to: maxn) do: 			[ 				:j | 
					prefsOrd at: (prefs at: j) put: j.
			].
			prefsOrd.
		].
! !!StableMarriage methodsFor: 'others' stamp: 'Juls 1/13/2020 16:51'!traceOn: anArray
	"show all the element s of anArray on a line"
	Transcript show: 		(anArray joinUsing: ' '); 		cr. ! !!StableMarriage methodsFor: 'others' stamp: 'Juls 1/13/2020 16:44'!prepareCoroutines
	"prepare coroutines to solve the problem"
	menChoice := womenChoice := solver := nil.
	 
	"men's coroutines"
	menChoice := (1 to: maxn) collect: 	[ 		:i |
			| boy |
			boy := i.
			Coroutine maker: 			[ 				:resume :value |
					| prefs girl |
					prefs := menRanking at: boy.					(1 to: maxn) do: 					[ 						:j |
							"make boy-girl engagement"
							girl := prefs at: j.
							menEngagement at: boy put: girl.
							trace ifTrue: 							[ 								self traceOn: 								{ 									(men at: boy). 'proposes'. (women at: girl) 								} 							].
							resume value: (womenChoice at: girl) value: boy.
					].
			].
	].
	
	"women coroutines"
	womenChoice := (1 to: maxn) collect: 	[ 		:i |
			| girl |
			girl := i.
			Coroutine maker: 			[ 				:resume :value |
					| prefs boy |
					prefs := womenRankingOrder at: girl.
					boy := value.
					womenEngagement at: girl put: boy.
					trace ifTrue: 					[ 						self traceOn: 						{ 							(women at: girl). 'accepts initial'. (men at: boy) 						} 					].
					"first boy accepted: back to main"
					boy := resume value: solver value: nil. 
					[ true ] whileTrue: 					[ 
						( 							(prefs at: (womenEngagement at: girl)) > (prefs at: boy) 						)
						ifTrue: 						[ 
							| jilt |
							jilt := womenEngagement at: girl. 
							womenEngagement at: girl put: boy.
							trace ifTrue: 							[ 								self traceOn: 									{ 										(women at: girl). 'prefers'. (men at: boy). 'over'. (men at: jilt) 									}							].
							"new boy accepted: back to jilt"
							boy := resume value: (menChoice at: jilt) value: girl. 
						]
						ifFalse: 						[ 
							trace ifTrue: 							[ 								self traceOn: 								{ 									(women at: girl). 'rejects'. (men at: boy) 								} 							].	
							"boy rejected: back to boy"	
							boy := resume value: (menChoice at: boy) value: girl.
						]
				].
		].
	].
	
	"solver coroutine"
	solver := Coroutine maker: 	[ 		:resume :value |
			(1 to: maxn) do: 			[ :boy |
				resume value: (menChoice at: boy) value: nil.
			].
			trace ifTrue: [ self traceResults ].
			menEngagement.
	].

	
	! !!StableMarriage methodsFor: 'others' stamp: 'Juls 1/13/2020 16:51'!traceResults
	"print in Transcript the resulting engagements"
	Transcript cr; show: 'Final engagements:'; cr.
	(1 to: maxn) do: 	[ 		:i |
			self traceOn: 			{ 				(men at: i). 'marries'. (women at: (menEngagement at: i)) 			}. 
	].! !!StableMarriage methodsFor: 'action' stamp: 'Juls 1/13/2020 16:51'!solve
	"solves the problem"
	self prepareParameters.
	self prepareCoroutines.
	^ solver value: nil.
	! !"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!StableMarriage class	instanceVariableNames: ''!!StableMarriage class methodsFor: 'action' stamp: 'Juls 1/13/2020 16:26'!solve: aValue
	"comment stating purpose of message"	! !TestCase subclass: #StableMarriageTest	instanceVariableNames: 'statementTestResult friendsTestResult spidermanTestResult'	classVariableNames: ''	poolDictionaries: ''	category: 'Practica'!!StableMarriageTest methodsFor: 'initialization' stamp: 'Juls 1/13/2020 16:28'!setUp
	friendsTestResult := #( 3 2 1 4 ).
	statementTestResult := #( 3 1 2 ).
	spidermanTestResult := #( 1 ).! !!StableMarriageTest methodsFor: 'test' stamp: 'Juls 1/2/2020 16:55'!testArticle
	"prova l'exemple del PDF 'allison-1983'"
	| solver res guys gals guyPrefs galPrefs |
	"names"
	guys := #(
		'1'
		'2'
		'3'
	).
	gals := #(
		'A'
		'B'
		'C'
	).
	"preferences"
	guyPrefs := #(
		"1"
		#(
			1 "A"
			2 "B"
			3 "C"
		)
		"2"
		#(
			1 "A"
			3 "C"
			2 "B"
		)
		"3"
		#(
			2 "B"
			3 "C"
			1 "A"
		)
	).
	galPrefs := #(
		"A"
		#(
			2 "2"
			1 "1"
			3 "3"
		)
		"B"
		#(
			2 "2"
			3 "3"
			1 "1"
		)
		"C"
		#(
			1 "1"
			2 "2"
			3 "3"
		)
	).
	"init solver"
	solver := StableMarriage new.
	solver men: guys.
	solver women: gals.
	solver menRanking: guyPrefs.
	solver womenRanking: galPrefs.
	solver trace: true.
	res := solver solve.
	self assert: statementTestResult = res.! !!StableMarriageTest methodsFor: 'test' stamp: 'Juls 1/13/2020 16:36'!testFriends
	"stable marriage problem with the Friends characters"
	| solver res boys girls boysRanking girlsRanking |
		"names"
	boys := 	#( 'Joey' 'Chandler' 'Ross' 'Mike' ).
	girls :=	#( 'Rachel' 'Monica' 'Phoebe' 'Julie' ).
		"preferences"
	boysRanking := 	#(
		"Joey"
		#(
			1 "Rachel, one word: Barbados"			3 "Phoebe, oh, come on, everyone knows it"
			2 "Monica, remember the day he arrived to the building? do you want lemonade?"
			4 "Julie, ñe, the one that's left"
		)
		"Chandler"
		#(
			2 "Monica, what can I say? they are soulmates"
			1 "Rachel, remember when central perk was only a pub?"
			4 "Julie, nothing to say here"
			3 "Phoebe, still afraid of her triplets"
		)
		"Ross"
		#(
			1 "Rachel, she's his lobster!!"
			4 "Julie, yeah, but she's not rachel"
			3 "Phoebe, wanna play some billiards?"
			2 "Monica, ew"
		)
		"Mike"
		#(
			3 "Phoebe, I mean, they end up getting married"
			1 "Rachel, that's always a good choice"
			2 "Monica, nothing to say here"
			4 "Julie, they don't even know each other"
		)
	).
	girlsRanking := 	#(
		"Rachel"
		#(
			3 "Ross, he's her lobster!!"
			1 "Joey, one word again: Barbados"
			4 "Mike, didn't you watch Wanderlust? a great film"
			2 "Chandler, ñe"
		)
		"Monica"
		#(
			2 "Chandler, there's a reason why girls don't propose"
			1 "Joey, want some lemonade?"
			4 "Mike, nothing to say here"
			3 "Ross, I know he was her first kis but..., no please"
		)
		"Phoebe"
		#(
			1 "Joey, don't be so surprised, everybody knows that Phoebe prefers Joey"
			4 "Mike, if there is no other option..."
			3 "Ross, wanna play some billiards again?"
			2 "Chandler, no one wants Chandler (except for me)"
		)
		"Julie"
		#(
			3 "Ross, or Russ?"
			4 "Mike, they don't even know each other, but well, let's try it"
			1 "Joey, seems cute"
			2 "Chandler, same as before :( "
		)
	).
	"init solver"
	solver := StableMarriage new.
	solver men: boys.
	solver women: girls.
	solver menRanking: boysRanking .
	solver womenRanking: girlsRanking .
	solver trace: true.
	res := solver solve.
	self assert: friendsTestResult equals: res.! !!StableMarriageTest methodsFor: 'test' stamp: 'Juls 1/13/2020 16:36'!testSpiderman"nomes una parella possible actualment"	| solver res boys girls boysRanking girlsRanking |		"names"	boys := #( 'Peter Parker' ).	girls := #( 'Mary Jane Watson'	).		"preferences"	boysRanking := #( #( 1 ) ).	girlsRanking := #( #( 1 ) ).		"init solver"	solver := StableMarriage new.	solver men: boys.	solver women: girls.	solver menRanking: boysRanking.	solver womenRanking: girlsRanking.	solver trace: true.	res := solver solve.	self assert: spidermanTestResult equals: res.! !