// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "../interface/IERC20.sol";

contract ERC20 is IERC20 {
    uint256 constant _totalSupply = 1000 * 10e18;

    mapping(address => uint256) balance;

    mapping(address => mapping(address => uint256)) set_allowance;

    uint256 constant decimal = 18;

    string constant name = "Token_Name";

    // Set the totalsupply to the deployed contract address
    constructor() {
        balance[msg.sender] = _totalSupply;
    }

    // returns token name
    function token_name() external pure returns (string memory) {
        return name;
    }

    // returns token decimal
    function get_decimals() external pure returns (uint256) {
        return decimal;
    }

    // Allows user to transfer token to other users
    function transfer(address _to, uint256 _amount) external returns (bool) {
        require(balance[msg.sender] > _amount, "You're low on token balance");

        balance[msg.sender] -= _amount;

        balance[_to] += _amount;

        return true;
    }

    // Allows a user to give another user spending power on their behalf
    function allowance(address _owner, address _spender) external view returns (uint256) {
        _owner = msg.sender;

        return set_allowance[_owner][_spender];
    }

    // Get total supply of the minted tokens in existent
    function totalSupply() external pure returns (uint256) {
        return _totalSupply;
    }

    // Get total amount of token in a particular address
    function balanceOf(address _addy) external view returns (uint256) {
        return balance[_addy];
    }

    // Allows a third party to transfer on a user behalf
    function trasferFrom(address _owner, address _receipient, uint256 _amount) external returns (bool) {
        uint256 owner_balance = this.balanceOf(_owner);
        uint256 _spender_allowance = set_allowance[_owner][msg.sender];

        require(owner_balance > _amount && _spender_allowance > _amount, "You don't have enough priviledge");

        balance[_owner] -= _amount;
        set_allowance[_owner][msg.sender] -= _amount;
        balance[_receipient] += _amount;

        return true;
    }

    // check if a specific address holds spending power
    function approve(address _spender, uint256 _amount) external returns (bool) {
        set_allowance[msg.sender][_spender] = _amount;

        return true;
    }
}
