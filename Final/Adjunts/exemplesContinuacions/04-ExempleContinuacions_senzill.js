function current_continuation() {
    print("Agafem la continuacio");
    return new Continuation();
}

let value = 0,
    kont = current_continuation();

print(value);
if (value === 5)
    print("Ha arribat a 5 gracies a la continuacio");
else {
    value++;
    kont(kont);
}


