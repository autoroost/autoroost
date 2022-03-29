// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;
import "./AutoRoost.sol";

contract MultiFeeder {
    function feed(address[] memory roosts) external {
        for (uint256 i = 0; i < roosts.length; i++) {
            AutoRoost(roosts[i]).feedAll();
        }
    }
}
