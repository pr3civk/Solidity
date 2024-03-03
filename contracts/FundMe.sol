// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {
    AggregatorV3Interface internal priceFeed;

    constructor() {

        /**
         * Network: Sepolia
         * Data Feed: ETH/USD
         * Address: 0x694AA1769357215DE4FAC081bf1f309aDC325306
         */

        priceFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
    }

    function fund() public payable {
        // opłata musi być większa niz 0,01Eth = 10^8 gwei
        require(msg.value > 1e16, "Didn't send enough");
    }

function getLatestPrice() public view returns (int) {
        (
            uint80 roundID, 
            int price,
            uint startedAt,
            uint timeStamp,
            uint80 answeredInRound
        ) = priceFeed.latestRoundData();
        return price;
    }
}
