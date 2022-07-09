const { expect } = require("chai");
const { ethers } = require("hardhat");

// https://bignerdranch.com/blog/why-do-javascript-test-frameworks-use-describe-and-beforeeach/#:~:text=describe()%20allows%20you%20to,file%2C%20even%20multiple%20nested%20levels.
// Describe() allows you to gather your tests into separate groupings within the same file
//https://stackoverflow.com/questions/12209582/the-describe-keyword-in-javascript
describe("Greeter", function () {
  it("Should return the new greeting once it's changed", async function () {
    const Greeter = await ethers.getContractFactory("Greeter");
    const greeter = await Greeter.deploy("Hello, world!"); // Initialize Smart Contract
    await greeter.deployed(); // Wait for Smart contract to be deployed

    expect(await greeter.greet()).to.equal("Hello, world!");

    const setGreetingTx = await greeter.setGreeting("Hola, mundo!");

    // wait until the transaction is mined
    await setGreetingTx.wait();

    expect(await greeter.greet()).to.equal("Hola, mundo!");
  });
});
