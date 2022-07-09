// contracts/Box.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Import Auth from the access-control subdirectory, referring to its relative path
// import "./access-control/Auth.sol";

// Import Ownable from the OpenZeppelin Contracts library
import "@openzeppelin/contracts/access/Ownable.sol";
// To use one of the OpenZeppelin Contracts, import it by prefixing its path with
// "@openzeppelin/contracts"
// For example, in order to replace our own Auth contract we will import Ownable to add access control

// Make Box inherit from the Ownable contract
contract Box is Ownable {
  uint256 private _value;

  // Emitted when stored value changes
  event ValueChanged(uint256 value);
  // Sol events give an abstraction on top of the EVM's logging functionality
  // Applications can subcribed and listen to these events through the RPC interface of an Eth cliient
  // 

  // Events are inheritable members of contracts, when you call them, they cause the arguments to be stored in the transaction's log, a special data struucture in the blockchain
  // These logs are associated with the address of the contract, are incorporated into the blockchain and stay there as long as the block is accessible
  // The log and its event data is not accessible from within the contracts, not even from the contrac tthat created them

  // Topics allow you to search for events, for example when filtering a sequence of blocks for certain events.
  // You can also filter events by the address of the contract that emitted the event

  // events are mitted using emit, followed by the name of the event and the argumnets  (if any) in parentheses
  // Any such invocation can be detected from the Davascript API by filtering for the event name

  

  // Stores a new value in the contract
  function store(uint256 value) public onlyOwner{

    _value = value;
    emit ValueChanged(value);
  }

  // Reads the last stored value
  function retrieve() public view returns (uint256) {
    return _value;
  }
}


// contract Box {
//   uint256 private _value;
//   Auth private _auth;

//   // Emitted when stored value changes
//   event ValueChanged(uint256 value);

//   constructor() {
//     _auth = new Auth(msg.sender);
//   }

//   // Stores a new value in the contract
//   function store(uint256 value) public {
//     // Require that the caller is registered as an administrator in Auth
//     require(_auth.isAdministrator(msg.sender), "Unauthorized");

//     _value = value;
//     emit ValueChanged(value);
//   }

//   // Reads the last stored value
//   function retrieve() public view returns (uint256) {
//     return _value;
//   }
// }

