// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Greeter {
    string private greeting;

    constructor(string memory _greeting) {
        greeting = _greeting;
    }

    function setGreeting(string memory _greeting) public {
        greeting = _greeting;
    }

    function greet() public view returns (string memory) {
        return greeting;
    }

    function getBalance(address _address) public view returns (uint) {
        return _address.balance;
    }

    function sendEth(address payable _to) public payable {
        _to.transfer(msg.value);
    }
}
