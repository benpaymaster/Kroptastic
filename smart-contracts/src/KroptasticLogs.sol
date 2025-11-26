// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./Ownable.sol";
import "@openzeppelin/contracts/proxy/utils/UUPSUpgradeable.sol";

/// @title IKroptasticLogs
/// @notice Interface for KroptasticLogs contract
interface IKroptasticLogs {
    function logCrop(
        string calldata cropName,
        string calldata coloration,
        uint64 soilMoisture,
        uint64 nitrogenContent,
        uint64 carbonContent,
        string calldata notes,
        uint32 harvestReadiness
    ) external;

    function getCrop(
        uint256 cropId
    ) external view returns (KroptasticLogs.CropEntry memory);

    function notifyHarvest(uint256 cropId, address recipient) external;
}

/// @title KroptasticLogs
/// @notice Stores crop data and harvest notifications for decentralized farming
/// @dev UUPS upgradeable, gas-optimized, secure, and modular
contract KroptasticLogs is Ownable, UUPSUpgradeable, IKroptasticLogs {
    /// @notice Crop data entry
    /// @dev Packed for gas optimization
    struct CropEntry {
        string cropName; ///< Name of the crop
        string coloration; ///< Coloration/appearance
        string notes; ///< Additional notes
        uint64 soilMoisture; ///< Soil moisture percentage
        uint64 nitrogenContent; ///< Nitrogen content (mg/kg)
        uint64 carbonContent; ///< Carbon content (mg/kg)
        uint32 harvestReadiness; ///< Harvest readiness percentage
        uint32 timestamp; ///< Timestamp of entry
        address farmer; ///< Farmer address
    }

    CropEntry[] public crops;

    /// @notice Emergency pause state
    bool public paused;

    /// @notice Emitted when contract is paused or unpaused
    /// @param isPaused True if paused, false if unpaused
    event Paused(bool isPaused);

    /// @notice Restricts actions when contract is paused
    modifier whenNotPaused() {
        require(!paused, "Contract is paused");
        _;
    }

    /// @notice Pause contract (emergency stop)
    function pause() external onlyOwner {
        require(!paused, "Already paused");
        paused = true;
        emit Paused(true);
    }

    /// @notice Unpause contract
    function unpause() external onlyOwner {
        require(paused, "Not paused");
        paused = false;
        emit Paused(false);
    }

    /// @notice Emitted when an AI consensus proposal is created
    /// @param cropId Crop entry index
    /// @param proposer Address proposing consensus
    /// @param proposalType Type of proposal (e.g., "harvest", "quality")
    event AIConsensusProposed(
        uint256 indexed cropId,
        address indexed proposer,
        string proposalType
    );

    /// @notice Emitted when an AI agent votes on a consensus proposal
    /// @param cropId Crop entry index
    /// @param voter Address of AI agent
    /// @param proposalType Type of proposal
    /// @param voteValue Value of the vote (e.g., readiness %, pass/fail)
    event AIConsensusVoted(
        uint256 indexed cropId,
        address indexed voter,
        string proposalType,
        uint256 voteValue
    );

    /// @notice Emitted when AI consensus is reached
    /// @param cropId Crop entry index
    /// @param proposalType Type of proposal
    /// @param consensusValue Final consensus value
    event AIConsensusResult(
        uint256 indexed cropId,
        string proposalType,
        uint256 consensusValue
    );

    /// @notice Authorized farmers mapping
    mapping(address => bool) public authorizedFarmers;

    /// @notice Authorized AI agents mapping
    mapping(address => bool) public authorizedAIAgents;

    /// @notice Restricts access to authorized farmers
    modifier onlyFarmer() {
        require(authorizedFarmers[msg.sender], "Not an authorized farmer");
        _;
    }

    /// @notice Restricts access to authorized AI agents
    modifier onlyAIAgent() {
        require(authorizedAIAgents[msg.sender], "Not an authorized AI agent");
        _;
    }

    /// @notice Set farmer authorization
    /// @param farmer Farmer address
    /// @param authorized True to authorize, false to revoke
    function setFarmer(address farmer, bool authorized) external onlyOwner {
        authorizedFarmers[farmer] = authorized;
    }

    /// @notice Set AI agent authorization
    /// @param agent AI agent address
    /// @param authorized True to authorize, false to revoke
    function setAIAgent(address agent, bool authorized) external onlyOwner {
        authorizedAIAgents[agent] = authorized;
    }

    /// @notice Propose an AI consensus action (off-chain agents listen for this)
    /// @param cropId Crop entry index
    /// @param proposalType Type of proposal ("harvest", "quality", etc)
    function proposeAIConsensus(
        uint256 cropId,
        string calldata proposalType
    ) external onlyFarmer whenNotPaused {
        require(cropId < crops.length, "Invalid cropId");
        emit AIConsensusProposed(cropId, msg.sender, proposalType);
    }

    /// @notice Emit a vote from an AI agent (off-chain agent calls this)
    /// @param cropId Crop entry index
    /// @param proposalType Type of proposal
    /// @param voteValue Value of the vote (e.g., readiness %, pass/fail)
    function voteAIConsensus(
        uint256 cropId,
        string calldata proposalType,
        uint256 voteValue
    ) external onlyAIAgent whenNotPaused {
        require(cropId < crops.length, "Invalid cropId");
        emit AIConsensusVoted(cropId, msg.sender, proposalType, voteValue);
    }

    /// @notice Emit the result of AI consensus (off-chain agent calls this)
    /// @param cropId Crop entry index
    /// @param proposalType Type of proposal
    /// @param consensusValue Final consensus value
    function emitAIConsensusResult(
        uint256 cropId,
        string calldata proposalType,
        uint256 consensusValue
    ) external onlyAIAgent whenNotPaused {
        require(cropId < crops.length, "Invalid cropId");
        emit AIConsensusResult(cropId, proposalType, consensusValue);
    }

    /// @notice Emitted when a crop is logged
    /// @param cropId Crop entry index
    /// @param farmer Farmer address
    /// @param harvestReadiness Harvest readiness percentage
    event CropLogged(
        uint256 indexed cropId,
        address indexed farmer,
        uint256 harvestReadiness
    );

    /// @notice Emitted when a harvest notification is sent
    /// @param cropId Crop entry index
    /// @param recipient Notification recipient
    /// @param harvestReadiness Harvest readiness percentage
    event HarvestNotification(
        uint256 indexed cropId,
        address indexed recipient,
        uint256 harvestReadiness
    );

    /// @notice Log a new crop entry
    /// @param cropName Name of the crop
    /// @param coloration Coloration/appearance
    /// @param soilMoisture Soil moisture percentage
    /// @param nitrogenContent Nitrogen content (mg/kg)
    /// @param carbonContent Carbon content (mg/kg)
    /// @param notes Additional notes
    /// @param harvestReadiness Harvest readiness percentage
    function logCrop(
        string calldata cropName,
        string calldata coloration,
        uint64 soilMoisture,
        uint64 nitrogenContent,
        uint64 carbonContent,
        string calldata notes,
        uint32 harvestReadiness
    ) external onlyFarmer whenNotPaused {
        require(soilMoisture <= 100, "Soil moisture must be 0-100");
        require(harvestReadiness <= 100, "Harvest readiness must be 0-100");
        crops.push(
            CropEntry({
                cropName: cropName,
                coloration: coloration,
                notes: notes,
                soilMoisture: soilMoisture,
                nitrogenContent: nitrogenContent,
                carbonContent: carbonContent,
                harvestReadiness: harvestReadiness,
                timestamp: uint32(block.timestamp),
                farmer: msg.sender
            })
        );
        emit CropLogged(crops.length - 1, msg.sender, harvestReadiness);
    }

    /// @notice Get crop entry by ID
    /// @param cropId Crop entry index
    /// @return CropEntry struct
    function getCrop(uint256 cropId) public view returns (CropEntry memory) {
        require(cropId < crops.length, "Invalid cropId");
        return crops[cropId];
    }

    /// @notice Notify supply chain of harvest readiness
    /// @param cropId Crop entry index
    /// @param recipient Notification recipient
    function notifyHarvest(
        uint256 cropId,
        address recipient
    ) external onlyFarmer whenNotPaused {
        require(cropId < crops.length, "Invalid cropId");
        require(msg.sender == crops[cropId].farmer, "Only farmer can notify");
        emit HarvestNotification(
            cropId,
            recipient,
            crops[cropId].harvestReadiness
        );
    }

    /// @notice Authorize contract upgrades (UUPS)
    /// @param newImplementation Address of new implementation
    function _authorizeUpgrade(
        address newImplementation
    ) internal override onlyOwner {}
}
