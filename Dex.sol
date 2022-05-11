// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <=0.8.10;

//import oppenzappelin for token ERC20
import '@openzeppelin/contracts/token/ERC20/IERC20.sol';
import '@openzeppelin/contracts/token/ERC20/ERC20.sol';

contract Dex {

    // liquidity Pool
    address public devToken;
    address public worldTolken;

    //set tokens for exchanges at the time of deploy
    constructor(address _devToken, address _worldTolken) {
        devToken = _devToken;
        worldTolken = _worldTolken;
    }

    //start an exchange with tokens
    function addLiquidity(address tokenAdr, uint amount) public {
        //add cash to start the dex by selecting a token  And pay tokens
        IERC20(tokenAdr).transferFrom(msg.sender, address(this), amount);
    }

    //invest in Dex
    function swap(address from, address to, uint amount) public {   
        require((from == devToken && to == worldTolken) || (from == worldTolken && to == devToken), "Tokens are invalid!");
        require( IERC20(from).balanceOf(msg.sender) >= amount, "The balance is not enough to swap!");

        uint swapAmount = getSwapRate(from, to, amount);

        // transfer of origin tokens from the applicant's account to the Dex account
        IERC20(from).transferFrom(msg.sender, address(this), amount);
        
        // we deposit the specified amount of the destination token from the Dex account to the applicant's account
        IERC20(to).transfer(msg.sender, swapAmount);
    }

    // get exchange rates
    function getSwapRate(address from, address to, uint amount) public view returns(uint) {
        return amount * IERC20(to).balanceOf(address(this)) / IERC20(from).balanceOf(address(this));
    }

    //the amount of capital 
    function balanceOf(address tokenAdr, address accountAdr) public view returns(uint) {
        return IERC20(tokenAdr).balanceOf(accountAdr);
    }

    //address Dex
    function dexAddress() public view returns(address) {
        return address(this);
    }
}
