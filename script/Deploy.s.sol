// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.13;

import { Script } from "forge-std/Script.sol";
import { console2 } from "forge-std/console2.sol";

// import { CREATE3Factory } from "create3-factory/CREATE3Factory.sol";

import { Factory } from "src/core/Factory.sol";
import { LiquidityManager } from "src/periphery/LiquidityManager.sol";
import { SquaredRouter } from "src/periphery/SquaredRouter.sol";

contract Deploy is Script {
  address constant create3Factory = 0x93FEC2C00BfE902F733B57c5a6CeeD7CD1384AE1;

  //Sepolia
  address constant uniV2Factory = 0xB7f907f7A9eBC822a80BD25E224be42Ce0A698A0;
  address constant uniV3Factory = 0x0227628f3F023bb0B980b67D528571c95c6DaC1c;

  //Uniswap deployed WETH
  address constant weth = 0xfFf9976782d46CC05630D1f6eBAb18b2324d6B14;

  function run() external returns (address factory, address liquidityManager, address squaredRouter) {
    // CREATE3Factory create3 = CREATE3Factory(create3Factory);

    uint256 pk = vm.envUint("PRIVATE_KEY");
    vm.startBroadcast(pk);

    factory = address(new Factory());

    liquidityManager = address(new LiquidityManager(factory, weth));

    squaredRouter = address(new SquaredRouter(factory, uniV2Factory, uniV3Factory, weth));

    // factory = create2.deploy(keccak256("SquaredFactory"), type(Factory).creationCode);

    // liquidityManager = create2.deploy(
    //   keccak256("SquaredManager"), bytes.concat(type(LiquidityManager).creationCode, abi.encode(factory, weth))
    // );

    // squaredRouter = create2.deploy(
    //   keccak256("SquaredRouter"),
    //   bytes.concat(type(SquaredRouter).creationCode, abi.encode(factory, uniV2Factory, uniV3Factory, weth))
    // );
  }
}
