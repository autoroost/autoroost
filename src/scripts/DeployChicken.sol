// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import "contract/ChickenRunV5.sol";
import "contract/EggV2.sol";
import "contract/FeedV2.sol";
import "../AutoRoost.sol";
import "../AutoRoostFactory.sol";

contract DeployChicken {
    receive() external payable {}

    constructor() {
        ChickenRunV5 chicken = new ChickenRunV5();
        chicken.initialize(
            address(this),
            address(this),
            1,
            1,
            "",
            address(this),
            false,
            true
        );

        EggV2 egg = new EggV2(address(chicken));
        FeedV2 feed = new FeedV2(address(chicken), address(egg));
        chicken.addAuthorized(address(egg));
        chicken.addAuthorized(address(feed));
        egg.addAuthorized(address(feed));
        egg.addAuthorized(address(chicken));
        feed.addAuthorized(address(egg));
        feed.addAuthorized(address(chicken));
    }
}
