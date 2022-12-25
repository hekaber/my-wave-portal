// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;

    // The variable that will be used to generate a random num
    uint256 private seed;

    // Solidity event
    event NewWave(address indexed from, uint256 timestamp, string message);

    struct Wave {
        address waver; // The address of the user who waved.
        string message; // The message the user sent.
        uint256 timestamp; // The timestamp when the user waved.
    }

    //Store the waves
    Wave[] waves;
    
    mapping(address => uint256) public lastWavedAt;

    constructor() payable {
        // Init seed
        seed = (block.timestamp + block.difficulty) % 100;
    }

    function wave(string memory _message) public {

         /*
         * We need to make sure the current timestamp is at least 15-minutes bigger than the last timestamp we stored
         */
        require(
            lastWavedAt[msg.sender] + 15 minutes < block.timestamp,
            "Wait 15m"
        );

        /*
         * Update the current timestamp we have for the user
         */
        lastWavedAt[msg.sender] = block.timestamp;

        totalWaves += 1;
        console.log("%s waved w/ message %s", msg.sender, _message);

        //Store new wave
        waves.push(Wave(msg.sender, _message, block.timestamp));

        // init new seed for the waver who waves
        seed = (block.difficulty + block.timestamp + seed) % 100;
        console.log("Random # generated: %d", seed);

        // waver has 50% chance to win the price
        if (seed <= 50) {

            console.log("%s won!!!", msg.sender);
            uint256 prizeAmount = 0.0001 ether;
            // check if I have enough in my wallet to afford the prize
            require(
                prizeAmount <= address(this).balance,
                "Trying to withdraw more money than the contract has."
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract.");
        }

        emit NewWave(msg.sender, block.timestamp, _message);
    }

    /*
     * Waves getter
     */
    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }
}
