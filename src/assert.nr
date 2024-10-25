fn assertions(x : Field, y : Field) {
    assert(x == y);
    assert(x == y, "x and y are not equal");
    assert(x == y, f"Expected x == y, but got {x} == {y}");
}