pragma solidity ^0.4.1;
import "./Asset.sol";

contract Trader {
    uint256 public riskRate = 1; // compound beta of debit and credit
    uint256 public riskLimit;
    Asset[] public debit; // actually assets
    Asset[] public credit; // liabilities

    function Trader(uint256 _riskLimit) {
        riskLimit = _riskLimit;
    }

    function addDebit(Asset _asset) public returns (bool) {
        riskCheck(_asset.volatilityRate(), true);
        debit.push(_asset);
        return true;
    }

    function addCredit(Asset _asset) public returns (bool) {
        riskCheck(_asset.volatilityRate(), true);
        credit.push(_asset);
        return true;
    }

    function removeDebit(Asset _asset) public returns (bool) {
        updateRiskRate(1);
        debit = filterAsset(debit, _asset);
        updateRiskRate(1 / _asset.volatilityRate());
        return true;
    }

    function removeCredit(Asset _asset) public returns (bool) {
        riskCheck(1 / _asset.volatilityRate(), false);
        credit = filterAsset(credit, _asset);
        return true;
    }

    function riskCheck(uint256 newRisk, bool strict) {
        updateRiskRate(newRisk);
        if (strict)
            require(riskRate < riskLimit);
    }

    function updateRiskRate(uint256 newRisk) {
        var debitRiskRate = countAssetsRisk(debit);
        var creditRiskRate = countAssetsRisk(credit);
        riskRate = debitRiskRate * creditRiskRate * newRisk;
    }

    function countAssetsRisk(Asset[] _array) returns (uint256 result) {
        var length = _array.length;
        var i = 0;
        result = 1;
        for (i; i < length; i++) {
            result *= _array[i].volatilityRate();
        }
        return result;
    }

    function filterAsset(Asset[] _assets, Asset _asset) private
            returns (Asset[] result) {

        Asset[] storage _result;
        var l = _assets.length;
        var i = 0;
        for (i; i < l; i++) {
            if (_assets[i] != _asset) {
                _result.push(_asset);
            }
        }
        result = _result;
    }

}
