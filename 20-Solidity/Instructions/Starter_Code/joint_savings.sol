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

pragma solidity ^0.8.18;

// Define a new contract named `JointSavings`
contract JointSavings {

    /*
    Inside the new contract define the following variables:
    - Two variables of type `address payable` named `accountOne` and `accountTwo`
    - A variable of type `address public` named `lastToWithdraw`
    - Two variables of type `uint public` named `lastWithdrawAmount` and `contractBalance`.
    */
    
    pragma solidity ^0.5.0;

// Define a new contract named `JointSavings`
contract JointSavings {
    address payable public accountOne;
    address payable public accountTwo;
    address public lastToWithdraw;
    uint public lastWithdrawAmount;
    uint public contractBalance;

    constructor(address payable _accountOne, address payable _accountTwo) public {
        accountOne = _accountOne;
        accountTwo = _accountTwo;
        lastToWithdraw = _accountOne; // Initialize lastToWithdraw with accountOne
        contractBalance = address(this).balance;
    }

    function deposit() public payable {
        // Allow both account owners to deposit funds into the contract
        require(msg.sender == accountOne || msg.sender == accountTwo, "You are not an account owner.");
        contractBalance += msg.value;
    }

    function withdraw(uint amount) public {
        // Allow an account owner to withdraw funds, switching between them
        require(msg.sender == accountOne || msg.sender == accountTwo, "You are not an account owner.");
        require(amount <= contractBalance, "Insufficient funds in the contract.");
        
        // Update the lastToWithdraw and lastWithdrawAmount variables
        lastToWithdraw = msg.sender;
        lastWithdrawAmount = amount;

        // Transfer funds to the account owner
        address payable recipient = msg.sender;
        recipient.transfer(amount);
        contractBalance -= amount;
    }

    function getContractBalance() public view returns (uint) {
        return contractBalance;
    }

    function getLastWithdrawInfo() public view returns (address, uint) {
        return (lastToWithdraw, lastWithdrawAmount);
    }
}


    /*
    Define a function named **withdraw** that will accept two arguments.
    - A `uint` variable named `amount`
    - A `payable address` named `recipient`
    */
    function withdraw(uint amount, address payable recipient) public {

        /*
        Define a `require` statement that checks if the `recipient` is equal to either `accountOne` or `accountTwo`. The `requiere` statement returns the text `"You don't own this account!"` if it does not.
        */
 
function withdraw(uint amount, address payable recipient) public {
    require(recipient == accountOne || recipient == accountTwo, "You don't own this account!");

    require(amount <= contractBalance, "Insufficient funds in the contract.");
    
    lastToWithdraw = recipient;
    lastWithdrawAmount = amount;

    recipient.transfer(amount);
    contractBalance -= amount;
}


        /*
        Define a `require` statement that checks if the `balance` is sufficient to accomplish the withdraw operation. If there are insufficient funds, the text `Insufficient funds!` is returned.
        */
function withdraw(uint amount, address payable recipient) public {
    require(recipient == accountOne || recipient == accountTwo, "You don't own this account!");
    require(contractBalance >= amount, "Insufficient funds!");

        /*
        Add and `if` statement to check if the `lastToWithdraw` is not equal to (`!=`) to `recipient` If `lastToWithdraw` is not equal, then set it to the current value of `recipient`.
        */
  if (lastToWithdraw != recipient) {
        lastToWithdraw = recipient;
    }

        // Call the `transfer` function of the `recipient` and pass it the `amount` to transfer as an argument.
    recipient.transfer(amount);

        // Set  `lastWithdrawAmount` equal to `amount`
    lastWithdrawAmount = amount;

        // Call the `contractBalance` variable and set it equal to the balance of the contract by using `address(this).balance` to reflect the new balance of the contract.

    contractBalance = address(this).balance;
}

    }

    // Define a `public payable` function named `deposit`.
    function deposit() public payable {

        /*
        Call the `contractBalance` variable and set it equal to the balance of the contract by using `address(this).balance`.
        */
function deposit() public payable {
    // Update the contractBalance to reflect the new balance of the contract
    contractBalance = address(this).balance;
}

    }

    /*
    Define a `public` function named `setAccounts` that receive two `address payable` arguments named `account1` and `account2`.
    */
    function setAccounts(address payable account1, address payable account2) public{

        // Set the values of `accountOne` and `accountTwo` to `account1` and `account2` respectively.
 /*
    Define a `public` function named `setAccounts` that receive two `address payable` arguments named `account1` and `account2`.
    */
    function setAccounts(address payable account1, address payable account2) public{

        // Set the values of `accountOne` and `accountTwo` to `account1` and `account2` respectively.
        // YOUR CODE HERE!
    }
    }

    /*
    Finally, add the **default fallback function** so that your contract can store Ether sent from outside the deposit function.
    */
// Default fallback function
function () external payable {
    // This function allows the contract to accept Ether sent from outside
    // You can choose to log this event or perform other actions if needed
}

}

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
