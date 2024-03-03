// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./AccountStorage.sol";
contract StorageFactory {
    // AccountStorage public accountStorage; //typ -> warstwa kontraktu -> zmienna
    AccountStorage[] public accountStorageArray; //typ -> warstwa kontraktu -> zmienna

    //tworze nowy obiekt kontraktu i dodaje go do array kontraków
    function createAccountStorageContract() public {
        AccountStorage contractAddress = new AccountStorage(); //zadeklrowana zmienna = nowy Obiekt kontraktu
        accountStorageArray.push(contractAddress);
    }
    //Po dodaniu obiektu można uruchamiać funkcje
    function asAddUser(
        string memory _username,
        uint8 _id,
        uint32 _accountNumber
    ) public {
        AccountStorage accountStorage = accountStorageArray[
            accountStorageArray.length - 1
        ];
        accountStorage.addUser(_username, _id, _accountNumber);
    }
    function getUserUsername(
        uint256 accountStorageIndex,
        uint256 userIndex
    ) public view returns (string memory) {
        AccountStorage accountStorage = accountStorageArray[
            accountStorageIndex
        ];
        AccountStorage.User memory user = accountStorage.getUser(userIndex);
        return user.username;
    }
}

//Inheritance = contract name is parent class fuction w parent class musi mieć virtual żeby można było dodać override do funkcji z tą samą nazwą

contract InheritAccStorage is AccountStorage {
    function getUser(uint _index) public view override returns (User memory) {
        // return smth added
    }
}
