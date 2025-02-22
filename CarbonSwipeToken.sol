// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// OpenZeppelin imports from GitHub
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract CarbonSwipeToken is ERC20, Ownable {
    // Initial supply for the contract owner
    uint256 public initialSupply = 1000000 * 10**18; // 1 million tokens with 18 decimals

    constructor() ERC20("Carbon Swipe", "CST") {
        // Mint initial tokens to the owner (e.g., you as the deployer)
        _mint(msg.sender, initialSupply);
    }

    // Function to allow users to claim tokens based on their credits
    function claimTokens(uint256 credits) public {
        require(credits > 0, "Credits must be greater than 0");
        
        // Calculate the amount of Carbon Swipe tokens to send (0.1 CST for 100 credits)
        uint256 amountToTransfer = (credits * 1 * 10**18) / (100 * 10);


        // Ensure the contract has enough balance to transfer
        require(balanceOf(owner()) >= amountToTransfer, "Not enough tokens in contract");

        // Transfer tokens to the user
        _transfer(owner(), msg.sender, amountToTransfer);
    }
}
