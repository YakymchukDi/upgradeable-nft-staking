const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("UpgradeableNFT", function () {
  let contract, owner, addr1;

  beforeEach(async function () {
    [owner, addr1] = await ethers.getSigners();
    const Contract = await ethers.getContractFactory("UpgradeableNFT");
    contract = await Contract.deploy();
    await contract.deployed();
  });

  it("Should mint NFT with correct level", async function () {
    await contract.connect(addr1).mint({ value: ethers.utils.parseEther("0.05") });
    expect(await contract.ownerOf(0)).to.equal(addr1.address);
    const data = await contract.nftData(0);
    expect(data.level).to.equal(1);
  });

  it("Should upgrade NFT level", async function () {
    await contract.connect(addr1).mint({ value: ethers.utils.parseEther("0.05") });
    await contract.connect(addr1).upgrade(0, { value: ethers.utils.parseEther("0.01") });
    const data = await contract.nftData(0);
    expect(data.level).to.equal(2);
  });

  it("Should allow staking and unstaking", async function () {
    await contract.connect(addr1).mint({ value: ethers.utils.parseEther("0.05") });
    await contract.connect(addr1).stake(0);
    let data = await contract.nftData(0);
    expect(data.staked).to.be.true;

    // simulate time passing if needed here

    await contract.connect(addr1).unstake(0);
    data = await contract.nftData(0);
    expect(data.staked).to.be.false;
  });
});
