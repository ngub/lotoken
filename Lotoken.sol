pragma solidity ^0.4.1;
import "./Token.sol";
import "./Option.sol";
import "./Trader.sol";
import "./Asset.sol";

contract LOToken is Token(100000) {

    Trader[] traders;

    function LOToken() {

    }


    function emitOption(Option.Type _type, Asset _baseAsset, uint256 _createdAt,
            uint256 _expiresAt, uint256 _strikePrice, string _name, string
            _symbol) {

        var _option = new Option(1, _type, _baseAsset, _createdAt, _expiresAt,
                                _strikePrice, msg.sender, msg.sender, _name,
                                symbol);
    }

}

