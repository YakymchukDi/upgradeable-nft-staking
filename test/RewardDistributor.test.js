const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("RewardDistributor", function () {
  let contract, owner, addr1;

  beforeEach(async function () {
    [owner, addr1] = await ethers.getSigners();
    const Contract = await ethers.getContractFactory("RewardDistributor");
    contract = await Contract.deploy();
    await contract.deployed();
  });

  it("Should allow owner to add rewards", async function () {
    await contract.addReward(addr1.address, ethers.utils.parseEther("1"));
    expect(await contract.rewards(addr1.address)).to.equal(ethers.utils.parseEther("1"));
  });

  it("Should let user claim rewards", async function () {
    await contract.addReward(addr1.address, ethers.utils.parseEther("1"));

    // Send some ETH to contract so it can pay
    await owner.sendTransaction({
      to: contract.address,
      value: ethers.utils.parseEther("1"),
    });

    await contract.connect(addr1).claimReward();
    expect(await contract.rewards(addr1.address)).to.equal(0);
  });
});
