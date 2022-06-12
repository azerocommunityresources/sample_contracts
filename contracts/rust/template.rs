#![cfg_attr(not(feature = "std"), no_std)]
#![allow(non_snake_case)]

use ink_lang as ink;
const PRECISION: u128 = 1_000_000_000; // Precision of 9 digits


#[ink::contract]
mod TemplateContract {

  // Using default ink types for contract defition
  #[ink(storage)]
  pub struct TemplateContract {
    // Some account ID for the contract
    my_account: AccountId,
    // Some balance
    my_balance: Balance,
  }

}