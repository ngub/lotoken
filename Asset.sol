pragma solidity ^0.4.1;
import "./Token.sol";

contract Asset is Token {
    uint256 public volatilityRate;
    uint256 public price;

    function Asset(uint256 _totalSupply, string _name, string _symbol, uint256 _price, uint256
            _volatilityRate) {

        totalSupply = _totalSupply;
        name = _name;
        symbol = _symbol;
        price = _price;
        volatilityRate = _volatilityRate; // beta
    }

    function dispose();
}
