//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

pragma experimental ABIEncoderV2;

import "hardhat/console.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

interface IEchoMessageValue {
  function count() external view returns (uint);
  function receiveAndLog(string calldata arg1) external payable returns (string memory);
}

// Contracts need to be marked as abstract when at least oen of their functions is not implemented
// Contracts may be marked as abstract even though all functions are implemented
// Such abstract contracts can not be instantiated directly
contract SendMessageValue {
  event Response(bool success, bytes data);

  constructor() {
    console.log("Deploying the SendMessageValue contract");
  }

  //https://codebeautify.org/hex-string-converter

  // Fall back function for transactions (call send transfer)
  // Excuted on a call to contract with empty call data (.send() or .transfer())
  //    - If no such function exists but a payable fallback function exists, the fallback function will be called ona plain Ether transfer
  //    - If neither of these contracts are available, the contract cannot receive Ether through regular tx and throws an exception

  // In the worst case, the receive function can only rely on 2300 gas being available (when send/transfer used)
  // leaving little room to perform other operations other than basic logging

  // A contract can have at most one receive function
  // - Cannot 
  //    - have arguments
  //    - return anything
  // - Must have 
  //    - external visiblity
  //    - payable state mutablity
  // - Can be 
  //    - virtual
  //    - override
  //    - have modifiers
  receive() external payable {
    console.log("in SMV receive function, msg value is", msg.value);
  }

  // A payable fallback function is also executed for pplain Ether transfers
  // if no receive Ether function is present
  // It is recommended to always define a receive Ether function as well
  // If you define a payable fallback function to distinguish Ether transfers from interface confusions

  // https://ethereum.stackexchange.com/questions/28898/when-to-use-view-and-pure-in-place-of-constant
  // https://cryptomarketpool.com/pure-and-view-in-solidity-smart-contracts/
  // At the end of the day, view pure payable are return types


  // MSG global variables, sender, value, data
  // https://medium.com/upstate-interactive/what-you-need-to-know-about-msg-global-variables-in-solidity-566f1e83cc69
  // function SendMessage(address payable _addr) external returns (bytes memory) {
    function SendMessage(address payable _addr) external payable returns (address) {
    console.log("within the SendMessage function, addr is ", _addr);
    console.log("msg value is", msg.value);
    console.log("msg sender is:", msg.sender);
    console.log("Before calling external function");
    // uint returnedVal = IEchoMessageValue(_addr).receiveAndLog("HELLO DUDE").send({ value : 10});
    // calling contract and sending ether
    // call contract adn send ether solidity
    // https://ethereum.stackexchange.com/questions/6665/call-contract-and-send-value-from-solidity
    // by default if no units its wei
    (bool success, bytes memory data) = _addr.call{value : 1 ether}(abi.encodeWithSignature("receiveAndLog(string)", "DRAAAAKKEEEE"));
    // (bool success, bytes memory data) = _addr.call(abi.encodeWithSignature("receiveAndLog(string)", "DRAAAAKKEEEE"));
    // (bool success, bytes memory data) = address(_addr).call{value : 10}(abi.encodeWithSignature("receiveAndLog(string)", "DRAAAAKKEEEE"));

    if (success) {
      console.log("successfully called external function, calling the response event");
      emit Response(success, data);
      // return data;
    } else {
      console.log("Could not call the external function");
      emit Response(success, data);
      // return data;
    }
    // console.log("finished calling external function, returned: ", data);

    return _addr;
    //https://blog.cryptostars.is/solidity-call-and-delegatecall-function-17b483a3c538
    // https://solidity-by-example.org/call
  }
}

// https://ethereum.stackexchange.com/questions/92502/is-it-possible-to-predefine-msg-value-when-calling-a-function-in-an-external-c
//https://www.quicknode.com/guides/solidity/how-to-call-another-smart-contract-from-your-solidity-code

// fall back functions
// https://www.geeksforgeeks.org/solidity-fall-back-function/
// https://medium.datadriveninvestor.com/fall-back-function-in-solidity-d618254efc8e
// https://ethereum.stackexchange.com/questions/81994/what-is-the-receive-keyword-in-solidity