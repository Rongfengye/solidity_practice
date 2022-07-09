// SPDX-License-Identifier:MIT
pragma solidity ^ 0.8.0;

import "hardhat/console.sol";

contract HelloWorld {
    string public Hi = "Hello World";    // The public here is a keyword when we want to have access to a variable after deploying it

    constructor() {
      console.log('Deploying the Basic Hello World contract');
    }
}