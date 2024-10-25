fn main(x: Field, y: pub Field) {
    assert(x != y);
    println("Flex. 😎");
    println("Let the records show that I was coding in noir before it was cool & maintsream. 😏");
}

#[test]
fn test_main() {
    main(1, 2);

    // Uncomment to make test fail
    // main(1, 1);
}
