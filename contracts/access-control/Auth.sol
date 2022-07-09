// contracts/access-control/Auth.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


// As your project grows, you will begin to create more contracts that interact with each other
// then each one should be stored in its own .sol files

// Let us add a simple access control system to our Box contract
// We will store an administrator address in a contract called Auth 
// We will only let Box used by those accounts that Auth allows

// The hardhad compiler will pick up all files in the contracts directory and subdirectories
// You are free to organize your code as you see fit
contract Auth {
  address private _administrator;

  constructor(address deployer) {
    // Make the deployer of the contract the administrator
    _administrator = deployer;
  }

  function isAdministrator(address user) public view returns (bool) {
    return user == _administrator;
  }
}