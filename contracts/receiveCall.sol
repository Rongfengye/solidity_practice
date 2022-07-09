//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

pragma experimental ABIEncoderV2;
// One of the things that this allows is for an external function to accept a multi-d array as an input parameter

import "hardhat/console.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract EchoMessageValue {
    // View functions ensure that they will not modify the state.
    uint public count;
    // Complier automatically creates getter functions for all public state variables
    // For the contract here, the complier will generate a function with external visibility called 
    // count that does not take any argumnets and returns a uint, the value of the state variable

    // For public state variables that are arrays, the getter argumnets only return an element at a time for gas purposes

    event Received(address caller, uint amount, string message);
    //https://blog.cryptostars.is/solidity-call-and-delegatecall-function-17b483a3c538

    constructor() payable {
      console.log('Deploying My EchoMessageValue contract');
      count = 54321;
    }

    receive() external payable {
      emit Received(msg.sender, msg.value, "Fallback was called");
    }

    //https://ethereum.stackexchange.com/questions/31399/get-the-return-value-of-payable-function
    // function Ereet() external view returns (string memory) {
      // function Ereet() external payable returns (string memory) {

    // Making a function payable causes it to return solely a tx object? -> YES
    // You cannot return some types from non-internal functions, notably multi-d dynamic arrays and structs
    function Ereet() public payable returns (string memory) {
      return "EREET FUNCTION RETURNS A STRING";
    }

    // *NOTE external functions can only be called from outside the contract, whereas public can be called externally and internally

    //https://ethereum.stackexchange.com/questions/77211/data-location-must-be-calldata-for-parameter-in-external-function-but-none-wa
    // In Solidity, all reference types, such as string, bytes, or struct, 
    // should always be accompanied with explicit specifier telling the compiler what “memory” the reference actually refers to
    // While, basically, “external” is just syntactic sugar for “public“
    // for some reason Solidity compiler disallows “memory” references in “external“ function parameters. The documentation just says:
    // function receiveAndLog(string calldata arg1) external payable returns (string memory) {
    function receiveAndLog(string memory arg1) external payable returns (string memory) {
      console.log("Receive and log received the string: ", arg1);
      console.log("msgval, sender, ", msg.value, msg.sender);
      // console.log("In EchoMessageValue's receiveAndLog function");
      // console.log("Message value received: ", msg.value);
      // console.log("Argment received of: ", arg1);
      // string memory response = "In EchoMessageValue's receiveAndLog function";
      // response += Message value receivedmsg.value
      // return 12345;
      // return msg.value;
      // return arg1;
      return "REGULAR STRING is returned";
    }
}
// https://codebeautify.org/hex-string-converter use to parse value

// https://piyolab.github.io/playground/ethereum/getEncodedFunctionSignature/
// Use to double check the function hash 

// https://ethereum.stackexchange.com/questions/19380/external-vs-public-best-practices
// As for best practices, you should use external if you expect that the 
// function will only ever be called externally, and use public if you need to call the function internally