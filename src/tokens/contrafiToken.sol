//SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

/**
 * @title CCC Token
 * @author Sandip Ghimire
 */
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Capped} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import {ContrafiAuthRegistryChecker} from "../auth/contrafiAuthRegistryChecker.sol";

contract CCCToken is ERC20Capped, ContrafiAuthRegistryChecker {
    constructor(uint256 _cap, uint256 _initialSupply, address _authorizationRegistryAddress)
        ERC20("CToken", "CCC")
        ERC20Capped(_cap)
        ContrafiAuthRegistryChecker(_authorizationRegistryAddress)
    {
        _mint(msg.sender, _initialSupply);
    }

    function mint(address _to, uint256 _amount) public onlyAuthorized {
        _mint(_to, _amount);
    }
}
