// We require the Hardhat Runtime Environment explicitly here. 
// This is optional but useful for running the script in a standalone fashion 
// through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");

async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');

  // We get the contract to deploy
  const Greeter = await hre.ethers.getContractFactory("Greeter");
  const greeter = await Greeter.deploy("Hello, Hardhat!");

  await greeter.deployed();

  console.log("Greeter deployed to:", greeter.address);

  console.log("trying to call Greeter contract's functions");

  const greetResponse = await greeter.functions.greet();  
  console.log("Greet response was: ", greetResponse);

  console.log("CALLING MY FUNCTIONS NOW");

  // Deploy the EchoMessageValue
  const EchoMessageValue = await hre.ethers.getContractFactory("EchoMessageValue");
  const emv = await EchoMessageValue.deploy();

  await emv.deployed();
  console.log("evm deployed to:", emv.address);

  const ereetResponse = await emv.functions.Ereet();
  console.log("EMV response was: ", ereetResponse);

  const receiveREsponse = await emv.functions.receiveAndLog("SHOULD GIVE HIS BACK");
  console.log("receiveREsponse is:", receiveREsponse);

  const SendMessageValue = await hre.ethers.getContractFactory("SendMessageValue");
  const smv = await SendMessageValue.deploy();


  await smv.deployed();
  console.log("smv deployed to:", smv.address);

  // console.log("Calling sendMessage, giving it the addr:", emv.address);
  const X = await smv.functions.SendMessage(emv.address);
  console.log("Called sendMessage, result", X);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0)) // Successful Deployment of contract
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
