pragma solidity ^0.4.1;
import "./Asset.sol";

contract Option is Asset {

    enum Type { CALL, PUT }
    Type optionType;
    Asset baseAsset;
    uint256 createdAt;
    uint256 expiresAt;
    uint256 strikePrice;
    address emitee;

    function Option(uint256 _totalSupply, Type _type, Asset _baseAsset, uint256 _createdAt,
            uint256 _expiresAt, uint256 _strikePrice, address _owner, address
            _emitee, string _name, string _symbol
    ) {

        totalSupply = _totalSupply;
        optionType = _type;
        baseAsset = _baseAsset;
        createdAt = _createdAt;
        expiresAt = _expiresAt;
        strikePrice = _strikePrice;
        owner = _owner;
        emitee = _emitee;
        volatilityRate = _baseAsset.volatilityRate();
        name = _name;
        symbol = _symbol;
    }

    function dispose() {
        require(execute(balanceOf(owner)));
        kill();
    }

    function execute(uint256 _amount) returns (bool) {
        return transfer(emitee, _amount);
    }
}
