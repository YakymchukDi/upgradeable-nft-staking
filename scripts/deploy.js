// scripts/deploy.js
async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contract with account:", deployer.address);

  const UpgradeableNFT = await ethers.getContractFactory("UpgradeableNFT");
  const contract = await UpgradeableNFT.deploy();

  await contract.deployed();

  console.log("UpgradeableNFT deployed to:", contract.address);
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
