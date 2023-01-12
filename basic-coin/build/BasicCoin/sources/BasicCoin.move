// This is defining a Move module. Modules are the building blocks of Move code, and // are defined with a specific address -- the address that the module can be published // under. In this case, the BasicCoin module can only be published under 0xCAFE.
module 0xCAFE::BasicCoin {
    // Only included in compilation for testing. Similar to #[cfg(testing)]
    // in Rust. Imports the `Signer` module from the MoveStdlib package.
    #[test_only]
    use std::signer;
 
    // Let's now take a look at the next part of this file where we define a struct to
    // represent a Coin with a given value. Looking at the rest of the file, we see a
    // function definition that creates a Coin struct and stores it under an account:
    struct Coin has key {
        value: u64,
    }
 
    // Let's take a look at this function and what it's saying:
    // 1. It takes a signer -- an unforgeable token that represents control over a particular address, and a value to mint.
    // 2. It creates a Coin with the given value and stores it under the account using the move_to operator.
    public fun mint(account: signer, value: u64) {
        move_to(&account, Coin { value })
    }
 
    // Declare a unit test. It takes a signer called `account` with an
    // address value of `0xC0FFEE`.
    #[test(account = @0xC0FFEE)]
    fun test_mint_10(account: signer) acquires Coin {
        let addr = signer::address_of(&account);
        mint(account, 10);
        // Make sure there is a `Coin` resource under `addr` with a value of `10`.
        // We can access this resource and its value since we are in the
        // same module that defined the `Coin` resource.
        assert!(borrow_global<Coin>(addr).value == 10, 0);
    }
}
