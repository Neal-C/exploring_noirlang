comptime fn quote_one() -> Quoted {
        quote { 1 }
    }

    #[test]
    fn returning_versus_macro_insertion() {
        comptime {
            // let _a: Quoted = quote { 1 };
            let _a: Quoted = quote_one();

            // let _b: Field = 1;
            let _b: Field = quote_one!();

            // Since integers default to fields, if we
            // want a different type we have to explicitly cast
            // let _c: i32 = 1 as i32;
            let _c: i32 = quote_one!() as i32;
        }
    }