// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;
import "contract/FeedV2.sol";
import "contract/EggV2.sol";
import "@openzeppelin/contracts/proxy/beacon/BeaconProxy.sol";
import "../src/AutoRoost.sol";

contract AutoRoostFactory is Ownable {
    event AutoRoostCreated(address roost, address owner);
    event FeeUpdate(uint256 newFee);
    uint256 public fee;
    address public immutable chikn;
    address public immutable egg;
    address public immutable feed;
    address public immutable beacon;

    constructor(uint256 _fee, address _chikn, address _egg, address _feed, address _beacon) {
        fee = _fee;
        chikn = _chikn;
        egg = _egg;
        feed = _feed;
        beacon = _beacon;
        emit FeeUpdate(_fee);
    }
    
    function create() external returns (address) {
        BeaconProxy roostProxy = new BeaconProxy(beacon, "");
        AutoRoost roost = AutoRoost(address(roostProxy));
        roost.init(chikn, egg, feed);
        roost.transferOwnership(msg.sender);
        emit AutoRoostCreated(address(roost), msg.sender);
        return address(roost);
    }

    function claimFees() external onlyOwner {
        EggV2(egg).transfer(msg.sender, EggV2(egg).balanceOf(address(this)));
    }

    function setFee(uint256 _fee) external onlyOwner {
        fee = _fee;
        emit FeeUpdate(_fee);
    }
}
