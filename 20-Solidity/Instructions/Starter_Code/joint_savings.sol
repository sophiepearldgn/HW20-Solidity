

/*
Joint Savings Account
---------------------

To automate the creation of joint savings accounts, you will create a solidity smart contract that accepts two user addresses that are then able to control a joint savings account. Your smart contract will use ether management functions to implement various requirements from the financial institution to provide the features of the joint savings account.

The Starting file provided for this challenge contains a `pragma` for solidity version `5.0.0`.
You will do the following:

1. Create and work within a local blockchain development environment using the JavaScript VM provided by the Remix IDE.

2. Script and deploy a **JointSavings** smart contract.

3. Interact with your deployed smart contract to transfer and withdraw funds.

*/

// SPDX-License-Identifier: UNLICENSED


pragma solidity ^0.8.0;

// Define a new contract named `JointSavings`
contract JointSavings {
    address payable public accountOne;
    address payable public accountTwo;
    address public lastToWithdraw;
    uint public lastWithdrawAmount;
    uint public contractBalance;

    constructor(address payable _accountOne, address payable _accountTwo) {
        accountOne = _accountOne;
        accountTwo = _accountTwo;
        lastToWithdraw = _accountOne;
        contractBalance = address(this).balance;
    }

    function deposit() public payable {
        require(msg.sender == accountOne || msg.sender == accountTwo, "You are not an account owner.");
        contractBalance += msg.value;
    }

    function withdraw(uint amount, address payable recipient) public {
        require(recipient == accountOne || recipient == accountTwo, "You don't own this account!");
        require(contractBalance >= amount, "Insufficient funds!");

        if (lastToWithdraw != recipient) {
            lastToWithdraw = recipient;
        }

        recipient.transfer(amount);
        lastWithdrawAmount = amount;
        contractBalance = address(this).balance;
    }

    function setAccounts(address payable account1, address payable account2) public {
        accountOne = account1;
        accountTwo = account2;
    }

    // Fallback function to receive Ether
    receive() external payable {
        // This function allows the contract to store Ether sent from outside the deposit function.
        contractBalance += msg.value;
    }
}
