// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ShowBalance {
    // function getBalance(address _address) public view returns (uint) {
    //     return _address.balance;
    // }
    function transfer(address _to, uint _amount) public {
        require(_amount <= msg.sender.balance, "Insufficient balance.");
        payable(_to).transfer(_amount);
    }
}