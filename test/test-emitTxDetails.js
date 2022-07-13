// We import Chai to use its asserting functions here.
const { expect } = require("chai");
const { ethers, waffle } = require("hardhat");
// const abiDecoder = require('abi-decoder');
// 

const provider = waffle.provider;
// `describe` is a Mocha function that allows you to organize your tests. It's
// not actually needed, but having your tests organized makes debugging them
// easier. All Mocha functions are available in the global scope.

// `describe` receives the name of a section of your test suite, and a callback.
// The callback must define the tests of that section. 
// This callback can't be an async function.

describe("CHECKING BASIC LogTxDetails BEHAVIOR", function () {
  // start using before each for tests
  it("TEST: deploying and utilizing the contract", async function () {
    const ETD = await ethers.getContractFactory("EmitTxDetails");
    const etd = await ETD.deploy();
    await etd.deployed();

    console.log("etd deployed at", etd.address);

    console.log("TEST: Making function calls to the contract");
    const shibAddr = '0x95ad61b0a150d79219dcf64e1e6cc01f0b64c4ce';
    const WETHaddr = '0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2';
    const UniswapV2Router02Addr = '0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D';
    const txResponse = await etd.LogTxDetails(1, 2, 3, [shibAddr, WETHaddr], UniswapV2Router02Addr, 4, [5, 6]);
    
    console.log("TEST: Finished making one function call");
    // expect(txResponse).to.emit(etd, 'Snipe');
    console.log("this is txResponse object\n", txResponse);
    const waitObject = await txResponse.wait();

    console.log("this is txResponse.wait() object\n", waitObject);
    console.log("this is the data", waitObject.events[0].data, "this is the signature", waitObject.events[0].eventSignature);
 
    console.log("checking if we can view our emitted events");


    const decodedData = ethers.utils.defaultAbiCoder.decode(['uint256','uint256','uint256','address[]','address','uint256','uint256[]'], waitObject.events[0].data);
    console.log(decodedData);
   
    console.log("TEST: Checking the transaction logs");

    
  })

  // finish testing then deploy
})