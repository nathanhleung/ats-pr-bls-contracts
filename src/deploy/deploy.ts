import { DeployFunction } from "hardhat-deploy/types";
import { HardhatRuntimeEnvironment } from "hardhat/types";

const deploy: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deployments, getNamedAccounts } = hre;
  const { deployer } = await getNamedAccounts();
  const { deploy } = deployments;

  // await deploy("GnosisSafeL2", {
  //   from: deployer,
  //   args: [],
  //   log: true,
  //   // deterministicDeployment: true,
  // });

  await deploy("GnosisSafeZetachainClient", {
    from: deployer,
    args: [],
    log: true,
    // deterministicDeployment: true,
  });
};

export default deploy;
