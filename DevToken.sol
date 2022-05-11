// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <=0.8.10;

//import ERC20 Tokan from oppenzepplin
import '@openzeppelin/contracts/token/ERC20/ERC20.sol';

contract DevToken is ERC20 {

    uint public initialSupply;
    address owner;

    //value the token name and symbol in time deploy
    constructor() ERC20("DevToken", "DTK") {

        //specify the owner
        owner = msg.sender;

        //specify the price of the token
        initialSupply = 6 * (10**6) * (10**uint(decimals()));

         //withdrawal of token price
        _mint(owner, initialSupply);

        //send tokens 
        emit Transfer(address(0), owner, initialSupply);
    }
}