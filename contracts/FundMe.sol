// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;
import "./EthToUsdConverter.sol";

// fn specjalne: constructor, receive, fallback, modifier

error NotOwner();

error CallError();

error NotEnoughEthError();

contract FundMe {
    // constant -> nie da się zmienić i jest lżejsze -> mniej gazu kosztuje
    //For constant variables, the value has to be fixed at compile-time, while for immutable ,
    //it can still be assigned at construction time
    uint256 public constant MIN_USD = 2 * 1e18;
    address[] public funders;
    mapping(address => uint256) public addressToAmoutFunded;
    // immutable -> variables that cannot be changed once they have been assigned a
    // value and can only be set during contract deployment
    address public immutable owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        if (msg.sender != owner) {
            revert NotOwner();
        } //lepsze efficiency
        // require(msg.sender == owner, "Sender is not a owner");
        _; // wykonaj reszte kodu
    }
    function fund() public payable {
        // opłata musi być większa niz 0,01Eth = 10^8 gwei
        // require(
        //     EthToUsdConverter.getConversionRate(msg.value) > MIN_USD,
        //     "Didn't send enough"
        // );
        // if (EthToUsdConverter.getConversionRate(msg.value) > MIN_USD) {
        //     revert NotEnoughEthError();
        // }
        assert(EthToUsdConverter.getConversionRate(msg.value) > MIN_USD);
        funders.push(msg.sender);
        addressToAmoutFunded[msg.sender] = msg.value;
    }

    function withdraw() public {
        for (
            uint256 funderIndex = 0;
            funderIndex < funders.length;
            funderIndex++
        ) {
            address funder = funders[funderIndex];
            addressToAmoutFunded[funder] = 0;
        }
        // Czyści arraya
        funders = new address[](0);

        // //transfer do 2300 gazu powyzej error
        // payable(msg.sender).transfer(address(this).balance);
        // //send jak się nie zrobi boola to hajs się zestackuje gdzieś w BC i nie dojdzie
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send Fail");
        //call najlepsza metoda

        (bool callSuccess, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        // require(callSuccess, "Call failed");
        if (!callSuccess) {
            revert CallError();
        }
    }

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }
}
