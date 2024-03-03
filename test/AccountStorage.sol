// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AccountStorage {
    struct User {
        string username;
        uint8 id;
        uint32 accountNumber;
    }
    User[] public users;

    mapping(string => uint8) usernameToId;
    mapping(string => uint32) usernameToAccountNumber;

    function addUser(
        string calldata _username,
        uint8 _id,
        uint32 _accountNumber
    ) public {
        users.push(User(_username, _id, _accountNumber));
        usernameToId[_username] = _id;
        usernameToAccountNumber[_username] = _accountNumber;
    }

    function getUser(uint _index) public view virtual returns (User memory) {
        if (users.length > 0) {
            return users[_index];
        } else {
            // Obsłuż sytuację, gdy tablica users jest pusta
            revert("No users in the array");
        }
    }
    function getUserUsernameById(
        uint8 _id
    ) public view returns (string memory) {
        for (uint i = 0; i < users.length; i++) {
            if (users[i].id == _id) {
                return users[i].username;
            }
        }
        return "";
    }
}
