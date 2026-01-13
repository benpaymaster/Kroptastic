// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/// @title MockSoilMoistureOracle
/// @notice Simulates an oracle for soil moisture data
contract MockSoilMoistureOracle {
    uint64 private soilMoisture;
    address public owner;

    event SoilMoistureUpdated(uint64 newValue);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    constructor(uint64 _initialValue) {
        owner = msg.sender;
        soilMoisture = _initialValue;
    }

    function setSoilMoisture(uint64 _value) external onlyOwner {
        soilMoisture = _value;
        emit SoilMoistureUpdated(_value);
    }

    function getSoilMoisture() external view returns (uint64) {
        return soilMoisture;
    }
}
