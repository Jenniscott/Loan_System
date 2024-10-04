// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./userWallet.sol";

contract LoanSystem is userWallet {
    enum LoanStatus { Pending, Approved, Rejected }

    struct LoanRequest {
        uint amount;
        LoanStatus status;
    }

    mapping(address => LoanRequest) public loanRequests;
    address[] public loanApplicants;

    uint public totalLoans;

    function applyForLoan(uint _amount) public {
        require(accounts[msg.sender].balance >= 1 ether, "You need at least 1 ether in your account to apply for a loan.");
        loanRequests[msg.sender] = LoanRequest(_amount, LoanStatus.Pending);
        loanApplicants.push(msg.sender);
    }

    function processLoans() public {
        for (uint i = 0; i < loanApplicants.length; i++) {
            address applicant = loanApplicants[i];
            LoanRequest storage request = loanRequests[applicant];

            if (accounts[applicant].balance >= request.amount / 2) {
                request.status = LoanStatus.Approved;
                totalLoans++;
            } else {
                request.status = LoanStatus.Rejected;
            }
        }
    }

    function getLoanStatus(address _applicant) public view returns (LoanStatus) {
        return loanRequests[_applicant].status;
    }
}
