// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract DecentralizedSmartBank {
    mapping(address => uint256) public balances;

    event Deposit(address indexed user, uint256 amount);
    event Withdrawal(address indexed user, uint256 amount);

    // Deposit Ether into the smart bank
    function deposit() external payable {
        require(msg.value > 0, "Deposit amount must be greater than zero");
        balances[msg.sender] += msg.value;

        emit Deposit(msg.sender, msg.value);
    }

    // Withdraw Ether from your account
    function withdraw(uint256 amount) external {
        require(amount > 0, "Withdraw amount must be greater than zero");
        require(balances[msg.sender] >= amount, "Insufficient balance");

        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);

        emit Withdrawal(msg.sender, amount);
    }

    // View the total balance held by the contract
    function totalBankBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
