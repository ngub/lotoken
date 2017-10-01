pragma solidity ^0.4.1;

import "./erc20-interface.sol";

contract mortal {
    address owner;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function mortal() public {
        owner = msg.sender;
    }

    function kill() onlyOwner public {
        selfdestruct(owner);
    }
}


contract Token is mortal, ERC20Interface {
    mapping (address => uint256) balances;
    mapping (address => mapping (address => uint256)) allowed;
    string public name;
    string public symbol;

    modifier sufficientBalance(address _account, uint256 _amount) {
        require(balances[_account] >= _amount);
        _;
    }

    function Token(uint256 _totalSupply) public {
        totalSupply = _totalSupply;
        balances[owner] = totalSupply;
    }


    function balanceOf(address _owner) public constant returns (uint256 balance) {
        return balances[_owner];
    }

    function transfer(address _to, uint256 _value) public
            sufficientBalance(msg.sender, _value) returns (bool success) {

        balances[msg.sender] -= _value;
        balances[_to] += _value;
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public
            sufficientBalance(_from, _value) returns (bool success) {

        balances[_from] -= _value;
        allowed[_from][_to] -= _value;
        balances[_to] += _value;
        return true;
    }

    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender) public constant returns
            (uint256 remaining) {

        remaining = allowed[_owner][_spender];
    }
}
