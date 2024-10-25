// static_assert runs at compile_time
fn main(xs: [Field; 3]) {
    let x = 2 + 2;
    let y = 4;
    static_assert(x == y, "expected 2 + 2 to equal 4");

    // This passes since the length of `xs` is known at compile-time
    static_assert(xs.len() == 3, "expected the input to have 3 elements");
}