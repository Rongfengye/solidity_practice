# Basic Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, a sample script that deploys that contract, and an example of a task implementation, which simply lists the available accounts.

Try running some of the following tasks:

```shell
npx hardhat accounts
npx hardhat compile
npx hardhat clean
npx hardhat test
npx hardhat node
node scripts/sample-script.js
npx hardhat help
```



This Project will explore the basics of creating a Hardhat project

A Barebones installation with no plugins allows you to create your own tasks, 
compile your Solidity code, run your tests and run Hardhat Network, a local
development network you can deploy your contracts to

I first ran 'npx hardhat' to create my project folder
In this sample project, I installed
  - hardhat-waffle
  - hardhat-ethers

which makes Hardhat compatible with tests built with Waffle

**First** ran 'npx hardhat' in project folder to get a quick sense of what's avilable and what's going on
  - gives the list of built-in tasks, and the sample accounts task
  - Further ahead, when you start using plugins to add more functionality, tasks defined by those will also show up here
  - This is your starting point to ginf out what taks are available to run

  - looking at the 'hardhat.config.js' file gives you the definition of the task 'accounts'
  - running 'npx hardhat accounts' lists out these accounts
      - which are unsafe deterministic accounts that are the same for all hardhat users

**Compliling contracts** 
Then taking a look at 'contracts/' and the corresponding "Greeter.sol'
  - To compile the solidity contracts I just run 'npx hardhat compile'

**Testing your contracts**
The sample project comes with these tests that use Waffle & Ethers.js
You can use other libraries if wanted, check the integrations described in our guides
Taking a look at 'test/' and the corresponding 'sample-test.js', which are unit tests  
  testing the functionalities of the smart contract methods
  - To run tests 'npx hardhat test'

**Deploying your contracts**
Next to deploy the contract we will use a Hardhat script
Inside of 'scripts/' you will find 'sample-script.js'
  - To deploy the contract by using a Hardhat script, 
  run 'npx hardhat run scripts/sample-script.js'

**Connecting a wallet or Dapp to Hardhat Network**
Hardhat will always spin up an in-memory instance of Hardhat Network 
on startup by default
It is also possible to run Hardhat Network in a standalone fashion so that
external clients can connect to it
  - This can be MetaMask, your Dapp front-end, or a script
  - To run Hardhat Network IN A standalone fashion we run 'npx hardhat node'
    - This exposes a JSON-RPC interface to Hardhat Network. 
    - To use it connect your (wallet or application) to http://localhost:8545
    - To connect Hardhat to this node (to potentially run a deployment script),
      you simply need to run it using '--network localhost'
    - To try this, start a node with 'npx hardhat node' & re-run sample script
      by 'npx hardhat run scripts/sample-script.js --network localhost'


#Configuration
When Hardhat is run, it searches for the closest 'hardhat.config.js' file
starting from the current working directory. An empty 'hardhat.config.js' is enough for Hardhat to work

This file normally lives in the ROOT of your project, and contains the entirety of your Hardhat setup (config, plugins, and custom tasks) contained in this file

**Available config options**
To set up your config, you have to export an object from 'hardhat.config.js'

Modify the module.exports object
This object can have entries like defaultNetwork,, networks, solidity, paths, and mocha

- Networks configuration
  - The 'networks' config field is an optional object where network 
    names map to their configuration
  - Two types of networks in Hardat
    - JSON-RPC based networks https://eth.wiki/json-rpc/API
      - These are networks that connect to an external node, which can be running on your complier or remotely
      - This kind of network is configured with objects with the following fields
        - look at fields at https://hardhat.org/config/ 

    - Built in Hardhat network
      - The built in special network called 'hardhat'
      - When using this network, an instance of the Hardhat Network will automatically 
        be created when you run a task, script, or test your smart contracts
      - Hardhat Network has first-class support of Solidity. It will always know 
        which smart conrtacts are being run and exactly what they do and why they fail 
      - To see the configuration options 
      https://hardhat.org/hardhat-network/reference/#config

  - You can customize which network is used by default when running Hardhat
    by setting the config's 'defaultNetwork' field, default value "hardhat"

  - HD Wallet config
    - To use an HD Wallet with Hardhat you shoulder set your network's 'accounts'
        field to an object with the following fields
      - mnemonic: A required string with the mnemonic phrase of the walelt
      - path: The HD parent of all the derived keys
      - initialIndexL the initial index to derive, default 0
      - count: THe number of accounts to derive, defaultt 20
      - passphrase: the passphrase for the wallet, default empty string

- Solidity configuration
  The solidity config is an optional field that can be one of the following:
  - A solc version 
  - An object which describes the configuration for a single complier, it contains 
    the following keys:
    - version: The solc version to use 
    - settings: An object with the same schema as the settings entry as input JSON
  - An object which scribes multiple compliers and their respective configurations
    It contains the following
    - compliers: A list of complier configuration objects like the one above
    - overrides: an optional map of complier configuration ovveride objects, this maps file names to complier configuration objects, to learn more https://hardhat.org/guides/compile-contracts.html 

- Path configuration
  You can customize the different paths that Hardhat uses by providing an object to the paths field with the following keys
  - root: The root of the Hardhat project, which is resolved from hardhat.config.js' directory, the default value is the direcotry containing the config file
  - sources: the directory wher eyour contract are stored. This path is resolved from the project's root. The default value is './contracts'
  - tests: The directory where your tests are located. This path is resolved from the project's root. The default value is './test'
  - cache: The directory used by Hardhat to cache its internal stuff. This path is resolved form the project's root. The Default value is './cache'
  - artifacts: The directory where the compilation artifacts are stored. This path is resolved from the project's root. Default value is './artifacts'

- Mocha Configuration
You can configure how your tests are run using the mocha entry, which accepts the same options as Mocha https://mochajs.org/
Mocha is a testing network that works in conjunction with node.js 

- Quickly integrating other tools from Hardhat's config
Hardhat's config file will always run before any task, so you can use it to integrate with other tools, like importing '@babel/register'

