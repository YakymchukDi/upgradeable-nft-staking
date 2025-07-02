# Upgradeable NFT Staking

A demo project showcasing upgradeable NFTs with staking and rewards on Ethereum-compatible blockchains.

---

## 🚀 Project Overview

This smart contract allows users to:

- **Mint NFTs** with an initial level of 1 by paying a mint fee.  
- **Upgrade NFTs** by paying an upgrade fee to increase their level.  
- **Stake NFTs** to earn ETH rewards based on staking duration.  
- **Unstake NFTs** to receive earned rewards.  
- **Contract owner** can withdraw accumulated funds.

---

## 📋 Features

| Feature                 | Description                                  |
|-------------------------|----------------------------------------------|
| Minting                 | Pay 0.05 ETH to mint a new NFT (level 1)     |
| Upgrading               | Pay 0.01 ETH to increase NFT level by 1      |
| Staking                 | Stake NFT to start earning ETH rewards       |
| Unstaking               | Stop staking and claim rewards                |
| Rewards Calculation     | 0.001 ETH per day of staking duration         |
| Owner Withdrawal        | Owner can withdraw contract balance           |

---

## 💡 How It Works

1. **Mint NFT**: Call `mint()` with 0.05 ETH to receive a new NFT at level 1.  
2. **Upgrade NFT**: Call `upgrade(tokenId)` with 0.01 ETH to increase the NFT’s level.  
3. **Stake NFT**: Call `stake(tokenId)` to start earning rewards.  
4. **Unstake NFT**: Call `unstake(tokenId)` to stop staking and get rewards based on staking time.  
5. **Withdraw funds**: Owner calls `withdraw()` to transfer all collected ETH to their wallet.

---

## 🛠️ Contract Functions

| Function       | Description                          | Inputs                 | Payable  |
|----------------|------------------------------------|------------------------|----------|
| `mint()`       | Mint a new NFT                     | None                   | Yes (0.05 ETH) |
| `upgrade()`    | Upgrade NFT level                  | `tokenId` (uint256)    | Yes (0.01 ETH) |
| `stake()`      | Stake your NFT                    | `tokenId` (uint256)    | No       |
| `unstake()`    | Unstake NFT and claim rewards      | `tokenId` (uint256)    | No       |
| `withdraw()`   | Withdraw collected funds (owner only) | None               | No       |

---

## 📖 Example Usage

```solidity
// Mint a new NFT
await contract.mint({ value: ethers.utils.parseEther("0.05") });

// Upgrade NFT with tokenId 1
await contract.upgrade(1, { value: ethers.utils.parseEther("0.01") });

// Stake NFT with tokenId 1
await contract.stake(1);

// After some time, unstake NFT to claim rewards
await contract.unstake(1);
