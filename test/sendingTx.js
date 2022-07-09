// We import Chai to use its asserting functions here.
const { expect } = require("chai");
const { ethers, waffle } = require("hardhat");

const provider = waffle.provider;
// `describe` is a Mocha function that allows you to organize your tests. It's
// not actually needed, but having your tests organized makes debugging them
// easier. All Mocha functions are available in the global scope.

// `describe` receives the name of a section of your test suite, and a callback.
// The callback must define the tests of that section. 
// This callback can't be an async function.

describe("CHECKING BASIC GREETER BEHAVIOR IN TEST FRAMEWORK", function () {
  it("Observing transactions in the EVM", async function () {
    const Greeter = await ethers.getContractFactory("Greeter");
    const greeter = await Greeter.deploy("TEST MSG 1");
    await greeter.deployed();

    console.log("trying to call Greeter contract's functions");
    const greetResponse = await greeter.greet();
    console.log("Greet response was: ", greetResponse);
  })
})

describe("CHECKING BASIC FUNCTIONALITY IN: ", function() {
  it("Observing my echomessage", async function () {
    const EchoMessageValue = await ethers.getContractFactory("EchoMessageValue");
    const emv = await EchoMessageValue.deploy();
    await emv.deployed();
    console.log("evm deployed to:", emv.address);

    const ereetResponse = await emv.Ereet();
    console.log("ereetResponse was: ", ereetResponse);

    const receiveAndLogResponse = await emv.receiveAndLog("FRANK OCEAN");
    console.log("receiveAndLogResponse was: ", receiveAndLogResponse);



    console.log("INITIALIZING THE SEND MESSAGE NOW");
    const SendMessageValue = await ethers.getContractFactory("SendMessageValue");
    const smv = await SendMessageValue.deploy();
    await smv.deployed();
    console.log("smv deployed to:", smv.address);

    // const sendMessageResponse = await smv.SendMessage(emv.address);
    // console.log("sendMessageResponse is: ", sendMessageResponse);

    const testBalance0 = await provider.getBalance(emv.address);

    console.log("The test balance0 is:", testBalance0)

    // trying to send transactions
    const [owner] = await ethers.getSigners()
    // console.log("This is the owner\n", owner)
    // console.log("\n END of owner description")

    const txHash1 = await owner.sendTransaction({
      to: smv.address,
      value: ethers.utils.parseEther("10.0"),
    });

    console.log("This is tx hash:", txHash1)
    const testBalance1 = await provider.getBalance(smv.address);

    console.log("The test balance1 is:", testBalance1);

    // low level call
    console.log("OBSERVING THIS PART C");
    const sendMessageResponse = await smv.SendMessage(emv.address);
    console.log("sendMessageResponse is: ", sendMessageResponse);

    const testBalance2 = await provider.getBalance(smv.address);

    console.log("The test balance2 is:", testBalance2);
    
  })
})
// make contract send back either
// transfer tokens to the contract
// await hardhatToken.transfer(addr1.address, 50);

//https://ethereum.stackexchange.com/questions/3285/how-to-get-return-values-when-a-non-view-function-is-called
//It is not currently possible to return values from functions which modify the blockchain. To receive a return value, you can mark functions as "pure" or "view".

// For state-changing functions, the only way to "return" information is 
// by using Solidity Events, which coalesce as LOG opcodes in the 
// Ethereum Virtual Machine.