// SPDX-License-Identifier: GPL-3.0
// .idea: To let the creator mint new coins 
// anyone can send the coins to each other without registering with uname and passwd

contract Coin {
    // public identifier
    // the main address responsible to create the currency
    address public minter;

    // define a hash map that stores balances of the addresses
    // address is a data type in solidity
    // keeps a track of what address holds how much (Coin)
    mapping (address => uint) public balances;

    // constructor code, only runs when the code is called for the first time
    // msg.sender is basically the address that deploys the smart contract
    constructor() {
        minter = msg.sender;
    }

    // function mint
    // function to create new tokens and send it to a requesting address
    function mint(address receiver, uint amount) {
        // check if the message is initiated by the minter or not
        require(msg.sender == minter);
        balances[receiver] += amount;
    }

    // functions for transactions
    // start with possible errors
    // insufficient funds is the most prominent error
    // This would also help counter double spending

    error InsufficientBalance(uint requested, uint available);

    // function call to send the amount from one address to another
    function send(address receiver, uint amount) {
        // check if the msg sender has enough balance
        if (amount > balances[msg.sender]) {
            revert InsufficientBalance({
                requested: amount,
                available: balances[msg.sender]
            });
        }

        // if the check is passed, send it
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }   
}