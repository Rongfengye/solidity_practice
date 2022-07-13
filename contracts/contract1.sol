// //SPDX-License-Identifier: Unlicense
// pragma solidity ^0.8.0;

// pragma experimental ABIEncoderV2;

// import "hardhat/console.sol";

// interface IERC20 {
//     event Approval(address indexed owner, address indexed spender, uint value);
//     event Transfer(address indexed from, address indexed to, uint value);

//     function name() external view returns (string memory);
//     function symbol() external view returns (string memory);
//     function decimals() external view returns (uint8);
//     function totalSupply() external view returns (uint);
//     function balanceOf(address owner) external view returns (uint);
//     function allowance(address owner, address spender) external view returns (uint);

//     function approve(address spender, uint value) external returns (bool);
//     function transfer(address to, uint value) external returns (bool);
//     function transferFrom(address from, address to, uint value) external returns (bool);
// }

// interface IWETH is IERC20 {
//     function deposit() external payable;
//     function withdraw(uint) external;
// }

// interface IUniswapV2Router02 {
//     function factory() external pure returns (address);
//     function WETH() external pure returns (address);

//     function swapETHForExactTokens(uint amountOut, address[] calldata path, 
//                                     address to, uint deadline)
//                         external payable returns (uint[] memory amounts);
// }

// // This contract simply attempts to snipe the token at liquidity pool
// function swapExactTokensForTokens(
//   uint amountIn,
//   uint amountOutMin,
//   address[] calldata path,
//   address to,
//   uint deadline
// ) external returns (uint[] memory amounts);

// function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)
//   external
//   payable
//   returns (uint[] memory amounts);



// contract FlashbotsSubmitBundle {
//   address private immutable owner;
//     address private immutable executor;
//     IWETH private constant WETH = IWETH(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
//     address UniswapV2Router02Addr = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;

//     modifier onlyExecutor() {
//         require(msg.sender == executor);
//         _;
//     }

//     modifier onlyOwner() {
//         require(msg.sender == owner);
//         _;
//     }

//     // An example of this is supposing you have a receive() function with the payable modifier
//     // this means that this function can receive money in the contract
//     //  now imagine there is a function send() without a payable modifier 
//     // it will reject the transaction when you want to send money out of the contract.
//     receive() external payable {
//     }

//     // Payable 
//     // When writing a smart contract, you need to ensure that money is being 
//     // sent to the contract and out of the contract as well. 
//     // Payable does this for you, any function in Solidity with the modifier 
//     // Payable ensures that the function can send and receive Ether

//     // It can process transactions with non-zero Ether values and rejects any transactions with a zero Ether value. 
//     // Additionally, if you want a function to process transactions and 
//     // have not included the payable keyword in them the transaction will be automatically rejected.
//     constructor(address _executor) payable {
//         console.log("Deploying FlashbotsSubmitBundle contract with msg", msg.sender);
//         owner = msg.sender;
//         executor = _executor;
//         if (msg.value > 0) {
//             WETH.deposit{value: msg.value}();
//         }
//     }
//     // // gonna be swapExactTokensForTokens for simplicity first
//     // function snipeToken(uint256 _ethAmountToCoinbase,
//     //                     uint amountIn, uint amountOutMin, 
//     //                     address[] calldata path, address to, 
//     //                     uint deadline, uint[]memory amounts) {
    
//     //     //start here
//     //     require(true);
//     //     uint256 _wethBalanceBefore = WETH.balanceOf(address(this));
//     //     WETH
//     //     block.coinbase.transfer(_ethAmountToCoinbase);
//     // }

//     // gonna be swapExactETHForTokens for simplicity first
//     function snipeToken(uint256 _ethAmountToCoinbase,
//                         uint amountIn, uint amountOutMin, 
//                         address[] calldata path, address _to, 
//                         uint deadline, uint[]memory amounts) {
    
//         //start here
//         require(true);

//         IUniswapV2Router02(UniswapV2Router02Addr).
//         swapETHForExactTokens{value: amountIn, gas: 0}(amountOut, path, _to, deadline)

//         // Some sort of check here

//         uint256 _ethBalance = address(this).balance
//         if (_ethBalance < _ethAmountToCoinbase) {
//             WETH.withdraw(_ethAmountToCoinbase - _ethBalance);
//         }

//         block.coinbase.transfer(_ethAmountToCoinbase);
//     }
// }

// // WRITE 2 FUNCTIONS TO TEST ON HARDHAT CALLING FUNCTIONS LIKE SUCH, and then console logging it to check if syntax all works out

// //https://consensys.github.io/smart-contract-best-practices/development-recommendations/general/external-calls/
// //https://medium.com/@blockchain101/calling-the-function-of-another-contract-in-solidity-f9edfa921f4c