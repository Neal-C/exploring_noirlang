// https://noir-lang.org/docs/noir/concepts/functions
// Field Attribute
// The field attribute defines which field the function is compatible for. The function is conditionally compiled, under the condition that the field attribute matches the Noir native field. The field can be defined implicitly, by using the name of the elliptic curve usually associated to it - for instance bn254, bls12_381 - or explicitly by using the field (prime) order, in decimal or hexadecimal form. As a result, it is possible to define multiple versions of a function with each version specialized for a different field attribute. This can be useful when a function requires different parameters depending on the underlying elliptic curve.

// Example: we define the function foo() three times below. Once for the default Noir bn254 curve, once for the field 
// F23, which will normally never be used by Noir, and once again for the bls12_381 curve.

#[field(bn254)]
fn foo() -> u32 {
    1
}

#[field(23)]
fn foo() -> u32 {
    2
}

// This commented code would not compile as foo would be defined twice because it is the same field as bn254
// #[field(21888242871839275222246405745257275088548364400416034343698204186575808495617)]
// fn foo() -> u32 {
//     2
// }

#[field(bls12_381)]
fn foo() -> u32 {
    3
}