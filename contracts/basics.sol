// SPDX-License-Identifier: MIT
pragma solidity >=0.8.20; // version of solidity

//class w OOP -> contract

//types: boolean
//uint -> unsigned INT czyli same dodatkie liczby jak w C
//int
//address = address na BC
//bytes
//uint256
//string
// bool hasFavouriteNumber = false;
// uint myNumber = 123123;
// int myNextNumber = -199;
// uint256 num256 = 4;
// uint8 num8 = 255;
// string hello = "Hello";
// // address myAddress = 0xe9822f18f2654e606a8dff9d75edd98367e7c0ae;
// bytes10 stringByte = "call";

contract NumberStorage {
    uint64 public myNumber;
    // func wykonujaca operackje
    function storeMyNumber(uint64 _myNumber) public {
        myNumber = _myNumber;
        retreiver();
    }
    // view ma dostep do stanów w kontrakcie i reaguje na operacje matm
    function retreiver() public view returns (uint72) {
        return myNumber + 41;
    }
    // pure nie ma dostep do stanów w kontrakcie używane tylko do operacji matm

    function add() public pure returns (uint8) {
        return (21 + 10);
    }

    struct Person {
        uint8 age;
        string name;
        string username;
    }

    Person public Maciej = Person({age: 22, name: "Maciej", username: "mxd33"});

    struct Users {
        string username;
        string accountNumber;
    }

    Users[] public users;

    function addPerson(string memory _username, string memory _accountNumber) public {
        users.push(Users(_username, _accountNumber));
    }
}
