import "hardhat-deploy";
import "@nomiclabs/hardhat-ethers";
import { task } from "hardhat/config";

task("deploy-contracts", "Deploys and verifies Safe contracts").setAction(
  async (_, hre) => {
    await hre.run("deploy");
    await hre.run("local-verify");
    // Disable Etherscan verification
    if (!!process.env.ETHERSCAN_API_KEY) {
      await hre.run("etherscan-verify", {
        forceLicense: true,
        license: "LGPL-3.0",
      });
    }
  }
);

export {};
