//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./IRC20.sol";

contract ERC20 is IERC20 {

    mapping(address => uint256) private _balanceOf;

    mapping(address => mapping(address => uint256)) private _allowed;

    uint256 public _totalSupply;

    string public name;

    string public symbol;

    uint8 public decimal = 18;

    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
    }

    function totalSupply() external view returns (uint256){
        return _totalSupply;
    }

    function balanceOf(address who) external view returns (uint256){
        return _balanceOf[who];
    }

    function allowance(address owner, address spender) external view returns (uint256){
        return _allowed[owner][spender];
    }

    function transfer(address to, uint256 value) external returns (bool){
        require(_balanceOf[msg.sender] >= value, "balance is not enough");
        require(to != address(0),"address is not 0");
        _balanceOf[to] += value;
        _balanceOf[msg.sender] -= value;
        emit Transfer(msg.sender,to, value);
        return true;
    }

    function approve(address spender, uint256 value) external returns (bool) {
        _allowed[msg.sender][spender] = value;
        emit Approval(msg.sender,spender,value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value) external returns (bool) {
        _allowed[from][msg.sender] -= value;
        _balanceOf[to] += value;
        _balanceOf[from] -= value;
        emit Transfer(from,to,value);
        return true;
    }

    function mint(uint256 value) external {
        _balanceOf[msg.sender] += value;
        _totalSupply += value;
        emit Transfer(address(0),msg.sender,value);
    }

    function burn(uint256 value) external  {
        _balanceOf[msg.sender] -= value;
        _totalSupply -= value;
        emit Transfer(msg.sender, address(0), value);
    }
}