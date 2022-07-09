const { expect } = require("chai");
// Chai https://www.chaijs.com/ is an assertions library
// These asserting functions are called 'matchers' and the ones used below come from Waffle
// This is why we use the hardhat-waffle plugin, which makes it easier to assert values from ETH


const { ethers } = require("hardhat");
// The ethers variable is available in the global scope,
// If you like your code always being explicit, you can add this line at the top

describe("Token contract", function () {
  it("Deployment should assign the total supply of tokens to the owner", async function () {
    const [owner] = await ethers.getSigners();
    // A Signer in ethers.js is an object that represents an Eth account
    // It is used to send transactions to contracts and other accounts
    // Here we're getting a list of the accounts in the node we're connected to to
    //    - In this case is the Hardhat Network, and keeping the FIRST one
    // To read more up on signers https://docs.ethers.io/v5/api/signer/

    const Token = await ethers.getContractFactory("Token");
    // A ContractFactory in ethers.js is an abstraction used to deploy 
    // new smart contracts by the hardhat module
    // Token here is a factory for instances of our token contract

    const hardhatToken = await Token.deploy();
    // Calling deploy() on a ContractFactory will start the deployment
    // and returns a Promise that resolves to a Contract
    // The hardhatToken is the object (returned by the Promise) that has
    // a method for each of your smart contract functions

    const ownerBalance = await hardhatToken.balanceOf(owner.address);
    // Once the contract is deployed, we can call our contract methods on hardhatToken
    // and use them to get the balance of the ownder account by calling balanceOf()

    // Rmmbr that the owner of the token who gets the entire supply 
    // is the account that makes the deployment, and when using the hardhat-ethers 
    // plugin, ContractFactory and Contract instances are connected 
    // to the first signer by default
    // This means that the account in the 'owner' variable executed the deployment
    // and balanceOf() should return the entire supply amount

    expect(await hardhatToken.totalSupply()).to.equal(ownerBalance);
    // Here we're again using our 'Contract' instance to call a 
    // smart contract function in our Solidity code
    // totalSupply() returns the token's supply amount and we're checking that
    // it's equal to ownerBalance, as it should


  });
});