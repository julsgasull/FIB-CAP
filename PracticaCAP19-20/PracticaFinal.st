alObject subclass: #Coroutine

Instance Variables
	block:		<Object>
	cont:		<Object>
	first:		<Object>

block
	- block that contains the coroutine code

cont
	- continuation where the coroutine stopped execution
!
	"initialize with a block with coroutine code"
	dream := aBlock.
	kick := nil.! !
	^ (kick isNil) 
		ifTrue: 
			dream 
					Continuation callcc: 
							kick := executionFlow.
							coroutine value: value.
					]
			]
		]
		ifFalse: 
			| kickTmp |
			kickTmp := kick.
			kick := nil.
			kickTmp value: aValue.
		]! !
	^ Coroutine new initializeWith: aBlock.
	| res a b c words |
	a := b := c := nil.
	res := OrderedCollection new.
	words := OrderedCollection withAll: #('life' 'death' 'dying' 'all of us').
	
			[ (words size) > 1 ] whileTrue: 
				res add: (resume value: c value: (words first)); add: Character cr asString.
			].
	].
	
			[ true ] whileTrue: 
				res add: (resume value: a value: (words first)).
			].
	].
	
			res add: value; add: ' leads to '.
			[ true ] whileTrue: 
				words removeFirst.
				res add: (resume value: b value: ' leads to ').
			].
	].
	
	
	self assert: philosophyTestResult equals: res.! !
	"setup method"
	enunciatTestResult := 
'This is A
	
	philosophyTestResult := 
'life leads to death
	
	primeTestResult := 

!
	womenRanking := anArray ! !
	^ women ! !
	menRanking := anArray ! !
	^ menRanking ! !
	^ men ! !
	men := anArray ! !
	^ trace ! !
	women := anArray ! !
	^ womenRanking ! !
	trace := aBool ! !
	"prepare paramters to solve the problem"
	maxn := men size.
	
	"engagements for men and women"
	menEngagement := Array new: maxn.
	womenEngagement := Array new: maxn.
	
	"woman preferences by man index"
	womenRankingOrder := 
			| prefs prefsOrd |
			prefs := womenRanking at: i.
			prefsOrd := Array new: maxn.
			(1 to: maxn) do: 
					prefsOrd at: (prefs at: j) put: j.
			].
			prefsOrd.
		].
! !
	"show all the element s of anArray on a line"
	Transcript show: 
	"prepare coroutines to solve the problem"
	menChoice := womenChoice := solver := nil.
	 
	"men's coroutines"
	menChoice := (1 to: maxn) collect: 
			| boy |
			boy := i.
			Coroutine maker: 
					| prefs girl |
					prefs := menRanking at: boy.
							"make boy-girl engagement"
							girl := prefs at: j.
							menEngagement at: boy put: girl.
							trace ifTrue: 
							resume value: (womenChoice at: girl) value: boy.
					].
			].
	].
	
	"women coroutines"
	womenChoice := (1 to: maxn) collect: 
			| girl |
			girl := i.
			Coroutine maker: 
					| prefs boy |
					prefs := womenRankingOrder at: girl.
					boy := value.
					womenEngagement at: girl put: boy.
					trace ifTrue: 
					"first boy accepted: back to main"
					boy := resume value: solver value: nil. 
					[ true ] whileTrue: 
						( 
						ifTrue: 
							| jilt |
							jilt := womenEngagement at: girl. 
							womenEngagement at: girl put: boy.
							trace ifTrue: 
							"new boy accepted: back to jilt"
							boy := resume value: (menChoice at: jilt) value: girl. 
						]
						ifFalse: 
							trace ifTrue: 
							"boy rejected: back to boy"	
							boy := resume value: (menChoice at: boy) value: girl.
						]
				].
		].
	].
	
	"solver coroutine"
	solver := Coroutine maker: 
			(1 to: maxn) do: 
				resume value: (menChoice at: boy) value: nil.
			].
			trace ifTrue: [ self traceResults ].
			menEngagement.
	].

	
	! !
	"print in Transcript the resulting engagements"
	Transcript cr; show: 'Final engagements:'; cr.
	(1 to: maxn) do: 
			self traceOn: 
	].! !
	"solves the problem"
	self prepareParameters.
	self prepareCoroutines.
	^ solver value: nil.
	! !
	"comment stating purpose of message"
	friendsTestResult := #( 3 2 1 4 ).
	statementTestResult := #( 3 1 2 ).
	spidermanTestResult := #( 1 ).! !
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
	self assert: statementTestResult = res.! !
	"stable marriage problem with the Friends characters"
	| solver res boys girls boysRanking girlsRanking |
	
	boys := 	#( 'Joey' 'Chandler' 'Ross' 'Mike' ).
	girls :=	#( 'Rachel' 'Monica' 'Phoebe' 'Julie' ).
	
	boysRanking := 
		"Joey"
		#(
			1 "Rachel, one word: Barbados"
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
	girlsRanking := 
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
	self assert: friendsTestResult equals: res.! !