// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Tombird is ERC1155, Ownable {
    
    uint256 public token_id;
    IERC20 public USDC;
    constructor(IERC20 USDC_address) ERC1155("") {
        USDC = USDC_address;
    }
    

    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

    function mint(uint256 id, uint256 amount) public
    {
        require(amount == 1, "Wrong Mint function");
        uint256 userBalance = USDC.balanceOf(msg.sender);
        require(1000000 <= userBalance, "User balance is not enough");
        USDC.safeTransferFrom(msg.sender, address(this), 1000000);
        _mint(msg.sender, id, amount, "");
        token_id = id;
    }

    function gift(address account, uint256 id, uint256 amount) public onlyOwner 
    {
        _mint(account, id, amount, "");
        token_id = id;
    }

    function mintBatch(uint256[] memory ids, uint256[] memory amounts) public
    {
        if(amounts == 15){
            uint256 userBalance = USDC.balanceOf(msg.sender);
            require(10000000 <= userBalance, "User balance is not enough");
            USDC.safeTransferFrom(msg.sender, address(this), 10000000);
            _mintBatch(msg.sender, ids, amounts, "");
        }
        else if(amounts == 100){
            uint256 userBalance = USDC.balanceOf(msg.sender);
            require(50000000 <= userBalance, "User balance is not enough");
            USDC.safeTransferFrom(msg.sender, address(this), 50000000);
            _mintBatch(msg.sender, ids, amounts, "");
        }
        token_id = ids[ids.length - 1];
    }
}