# API Documentation for UpgradeableNFT

## Smart Contract: UpgradeableNFT

### Functions

- `mint() payable`  
  Mint a new NFT by paying the mint price (default 0.05 ETH).  
  Example: `contract.mint({ value: ethers.utils.parseEther("0.05") })`

- `upgrade(uint256 tokenId) payable`  
  Upgrade the NFT level by paying the upgrade price (default 0.01 ETH).  
  Example: `contract.upgrade(tokenId, { value: ethers.utils.parseEther("0.01") })`

- `stake(uint256 tokenId)`  
  Stake your NFT to start earning rewards. NFT must be owned and unstaked.  
  Example: `contract.stake(tokenId)`

- `unstake(uint256 tokenId)`  
  Unstake your NFT to stop earning rewards.  
  Example: `contract.unstake(tokenId)`

- `claimRewards(uint256 tokenId)`  
  Claim accrued rewards for the staked NFT.  
  Example: `contract.claimRewards(tokenId)`

- `nftData(uint256 tokenId)` (view)  
  Returns struct with NFT info: level, stake status, rewards, etc.  
  Example: `const data = await contract.nftData(tokenId)`

---

## Deployment Script (`scripts/deploy.js`)

Run this script to deploy the contract:

```bash
npx hardhat run scripts/deploy.js --network <network-name>
