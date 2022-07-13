//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

pragma experimental ABIEncoderV2;

import "hardhat/console.sol";

contract EmitTxDetails {
  // Declaring an event
  // https://www.tutorialspoint.com/solidity/solidity_events.htm
  // An event is emitted, it stores the arguments passed in transaction logs. 
  // These logs are stored on blockchain and are accessible using address of the 
  // contract till the contract is present on the blockchain
  // https://betterprogramming.pub/learn-solidity-events-2801d6a99a92
  event Snipe(uint256 _ethAmountToCoinbase, uint amountIn, uint amountOutMin, 
              address[] path, address _to, uint deadline, uint[] amounts);

  event Log(string msg);

  bool fallBackCalled;

  // the hardhat test should see if the tx logs persist

  constructor() {
    console.log("Deploying the EmitTxDetails contract");
    emit Log("Deploying the EmitTxDetails contract");
  }

  receive() external payable {
    console.log("In the receive function of EmittingTxDetails");
    emit Log("In the receive function of EmittingTxDetails");
  }

  fallback() external payable {
    console.log("In the fallback function of EmittingTxDetails");
    emit Log("In the fallback function of EmittingTxDetails");
    fallBackCalled = true;
  }

  // Same arguments as snipeToken 
  function LogTxDetails (uint256 _ethAmountToCoinbase,
                        uint amountIn, uint amountOutMin, 
                        address[] calldata path, address _to, 
                        uint deadline, uint[]memory amounts) 
                        external payable {

  console.log("In the LogTxDetails function of our contract");
  emit Snipe(_ethAmountToCoinbase, amountIn, amountOutMin, 
              path, _to, deadline, amounts);
  }
}