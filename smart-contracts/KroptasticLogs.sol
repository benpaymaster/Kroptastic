// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./src/Ownable.sol";

contract KroptasticLogs is Ownable {
    struct CropEntry {
        string cropName;
        string coloration;
        string notes;
        uint64 soilMoisture;
        uint64 nitrogenContent;
        uint64 carbonContent;
        uint32 harvestReadiness;
        uint32 timestamp;
        address farmer;
    }

    CropEntry[] public crops;
    event CropLogged(uint256 indexed cropId, address indexed farmer, uint256 harvestReadiness);
    event HarvestNotification(uint256 indexed cropId, address indexed recipient, uint256 harvestReadiness);

    mapping(address => bool) public authorizedFarmers;

    modifier onlyFarmer() {
        require(authorizedFarmers[msg.sender], "Not an authorized farmer");
        _;
    }

    function setFarmer(address farmer, bool authorized) external onlyOwner {
        authorizedFarmers[farmer] = authorized;
    }

    function logCrop(
        string calldata cropName,
        string calldata coloration,
        uint64 soilMoisture,
        uint64 nitrogenContent,
        uint64 carbonContent,
        string calldata notes,
        uint32 harvestReadiness
    ) external onlyFarmer {
        require(soilMoisture <= 100, "Soil moisture must be 0-100");
        require(harvestReadiness <= 100, "Harvest readiness must be 0-100");
        crops.push(CropEntry({
            cropName: cropName,
            coloration: coloration,
            notes: notes,
            soilMoisture: soilMoisture,
            nitrogenContent: nitrogenContent,
            carbonContent: carbonContent,
            harvestReadiness: harvestReadiness,
            timestamp: uint32(block.timestamp),
            farmer: msg.sender
        }));
        emit CropLogged(crops.length - 1, msg.sender, harvestReadiness);
    }

    function getCrop(uint256 cropId) public view returns (CropEntry memory) {
        require(cropId < crops.length, "Invalid cropId");
        return crops[cropId];
    }

    function notifyHarvest(uint256 cropId, address recipient) external onlyFarmer {
        require(cropId < crops.length, "Invalid cropId");
        require(msg.sender == crops[cropId].farmer, "Only farmer can notify");
        emit HarvestNotification(cropId, recipient, crops[cropId].harvestReadiness);
    }
}
