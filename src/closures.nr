// Errors

// The reason is that the closure's capture environment affects its type - we have a closure that captures two Fields and foo expects a regular function as an argument - those are incompatible.

// Variables contained within the || are the closure's parameters, and the expression that follows it is the closure's body. The capture environment is comprised of any variables used in the closure's body that are not parameters.

// E.g. in |x| x + y, y would be a captured variable, but x would not be, since it is a parameter of the closure.

fn foo_errors(f: fn () -> Field) -> Field {
 f()
}

fn test_foo_errors() {
  let (x, y) = (50, 50);
  assert(foo_errors(|| x + y) == 100); // error :(
}

// The syntax for the type of a closure is fn[env](args) -> ret_type, where env is the capture environment of the closure - in this example that's (Field, Field).

// The best solution in our case is to make foo generic over the environment type of its parameter, so that it can be called with closures with any environment, as well as with regular functions:

fn foo<Env>(f: fn[Env]() -> Field) -> Field {
 f()
}

fn test_foo() {
  let (x, y) = (50, 50);
  assert(foo(|| x + y) == 100); // compiles fine
  assert(foo(|| 60) == 60);     // compiles fine
}