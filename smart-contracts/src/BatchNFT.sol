// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @title BatchNFT
/// @notice NFT representing a harvest batch with custom metadata
contract BatchNFT is ERC721URIStorage, Ownable {
    uint256 public nextTokenId;

    struct BatchMetadata {
        string gps;
        uint256 proteinPercent;
        uint256 nitrogen;
    }

    mapping(uint256 => BatchMetadata) public batchData;

    event BatchMinted(uint256 indexed tokenId, address indexed to, string gps, uint256 proteinPercent, uint256 nitrogen);

    constructor() ERC721("BatchNFT", "BATCH") {}

    function mintBatch(
        address to,
        string memory gps,
        uint256 proteinPercent,
        uint256 nitrogen
    ) external onlyOwner returns (uint256) {
        uint256 tokenId = nextTokenId++;
        _safeMint(to, tokenId);
        batchData[tokenId] = BatchMetadata(gps, proteinPercent, nitrogen);
        emit BatchMinted(tokenId, to, gps, proteinPercent, nitrogen);
        return tokenId;
    }

    function getBatchMetadata(uint256 tokenId) external view returns (BatchMetadata memory) {
        require(_exists(tokenId), "Nonexistent token");
        return batchData[tokenId];
    }

    // Optional: Override tokenURI to return on-chain or off-chain metadata
}
