// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract UpgradeableNFT is ERC721Enumerable, Ownable {
    struct NFTData {
        uint256 level;
        uint256 stakedTimestamp;
        bool staked;
    }

    mapping(uint256 => NFTData) public nftData;
    uint256 public nextTokenId;
    uint256 public upgradeCost = 0.01 ether;

    constructor() ERC721("UpgradeableNFT", "uNFT") {}

    function mint() external payable {
        require(msg.value == 0.05 ether, "Mint costs 0.05 ETH");
        uint256 tokenId = nextTokenId;
        _safeMint(msg.sender, tokenId);
        nftData[tokenId] = NFTData(1, 0, false);
        nextTokenId++;
    }

    function upgrade(uint256 tokenId) external payable {
        require(ownerOf(tokenId) == msg.sender, "Not your NFT");
        require(msg.value == upgradeCost, "Wrong upgrade cost");
        nftData[tokenId].level += 1;
    }

    function stake(uint256 tokenId) external {
        require(ownerOf(tokenId) == msg.sender, "Not your NFT");
        NFTData storage data = nftData[tokenId];
        require(!data.staked, "Already staked");
        data.staked = true;
        data.stakedTimestamp = block.timestamp;
    }

    function unstake(uint256 tokenId) external {
        require(ownerOf(tokenId) == msg.sender, "Not your NFT");
        NFTData storage data = nftData[tokenId];
        require(data.staked, "Not staked");
        data.staked = false;

        uint256 stakingDuration = block.timestamp - data.stakedTimestamp;
        uint256 reward = stakingDuration / 1 days * 0.001 ether;
        payable(msg.sender).transfer(reward);
    }

    function withdraw() external onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }
}
