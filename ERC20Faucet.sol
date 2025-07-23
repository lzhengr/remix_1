//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "ERC20.sol";

contract Faucet{

    uint256 public amountAllowed = 100; // the allowed amount for each request is 100
    address public tokenContract;   // contract address of the token
    mapping(address => bool) public requestedAddress;   // a map contains requested address

    // Event SendToken
    event SendToken(address indexed Receiver, uint256 indexed Amount); 

    constructor(address _tokenContract) {
        tokenContract = _tokenContract;
    }

    // Function for users to request tokens
function requestTokens() external {
    require(requestedAddress[msg.sender] == false, "Can't Request Multiple Times!"); // Only one request per address
    IERC20 token = IERC20(tokenContract); // Create an IERC20 contract object
    require(token.balanceOf(address(this)) >= amountAllowed, "Faucet Empty!"); // Faucet is empty

    token.transfer(msg.sender, amountAllowed); // Send token
    requestedAddress[msg.sender] = true; // Record the requested address
    
    emit SendToken(msg.sender, amountAllowed); // Emit SendToken event
}

}