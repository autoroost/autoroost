// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import "contract/ChickenRunV5.sol";
import "contract/EggV2.sol";
import "contract/FeedV2.sol";
import "@openzeppelin/contracts/proxy/beacon/UpgradeableBeacon.sol";
import "../AutoRoost.sol";
import "../AutoRoostFactory.sol";

contract UpgradeRoost {
    receive() external payable {}

    constructor(address beacon) {
        AutoRoost newImplementation = new AutoRoost();
        UpgradeableBeacon beaconContract = UpgradeableBeacon(beacon);
        beaconContract.upgradeTo(address(newImplementation));
    }
}
