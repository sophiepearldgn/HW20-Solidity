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

    // Fallback function to receive Ether
    receive() external payable {
        // This function allows the contract to store Ether sent from outside the deposit function.
        contractBalance += msg.value;
    }
}

// Define a new contract named `MyContract`
contract MyContract {
    address public accountOne;
    address public accountTwo;
    address public lastToWithdraw;
    uint public lastWithdrawAmount;
    uint public contractBalance;

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