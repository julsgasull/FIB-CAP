function current_continuation() {
    print("Agafem la continuacio");
    return new Continuation();
}


(function () {
	  let value = 0;
//    let kont = current_continuation();
    let kont = new Continuation();
    
	  print(value);
	  if (value === 5)
    		print("Ha arribat a 5 gracies a la continuacio");
	  else {
    		value++;
    		kont(kont);
	  }
})();



