// The data bus is an optimization that the backend can use to make recursion more efficient. In order to use it, you must define some inputs of the program entry points (usually the main() function) with the call_data modifier, and the return values with the return_data modifier. These modifiers are incompatible with pub and mut modifiers.

fn data_bus(mut x: u32, y: call_data u32, z: call_data [u32;4] ) -> return_data u32 {
  let a = z[x];
  a+y
}