// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import "contract/ChickenRunV5.sol";
import "contract/EggV2.sol";
import "contract/FeedV2.sol";
import "@openzeppelin/contracts/proxy/beacon/UpgradeableBeacon.sol";
import "../AutoRoost.sol";
import "../AutoRoostFactory.sol";

contract DeployUpgradeableRoostFactory {
    receive() external payable {}

    constructor(address chicken, address egg, address feed) {
        AutoRoost autoRoostImplementation = new AutoRoost();
        UpgradeableBeacon beacon = new UpgradeableBeacon(address(autoRoostImplementation));
        beacon.transferOwnership(msg.sender);

        AutoRoostFactory factory = new AutoRoostFactory(500, address(chicken), address(egg), address(feed), address(beacon));
        factory.transferOwnership(msg.sender);
    }
}
