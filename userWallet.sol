// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract userWallet{
    struct userAccount {
        string name;
        uint balance;
    }

    mapping(address => userAccount) public accounts;

    function createAccount(string memory _name) public {
        accounts[msg.sender] = userAccount(_name, 0);
    }

    function deposit() public payable {
        require(msg.value > 0, "Deposit amount must be greater than zero.");
        accounts[msg.sender].balance += msg.value;
    }

    function getBalance() public view returns (uint) {
        return accounts[msg.sender].balance;
    }
}
