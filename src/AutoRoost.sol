// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;
import "contract/FeedV2.sol";
import "contract/EggV2.sol";
import "contract/ChickenRunV5.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";
import "./AutoRoostFactory.sol";

contract AutoRoost is OwnableUpgradeable {
    using EnumerableSet for EnumerableSet.UintSet;
    event Deposit(uint256 chickenId, address owner);
    event WithdrawFeed(uint256 amount, address owner);
    event WithdrawEggs(uint256 amount, address owner);
    event WithdrawChikn(uint256 chickenId, address owner);
    
    // denominator for fixed-point fee
    // i.e. a value of 5 is 5bps, 500 is 5%
    uint256 private constant FEE_DENOMINATOR = 10000;
    ChickenRunV5 public chikn;
    EggV2 public egg;
    FeedV2 public  feed;
    bool internal staked;
    address public feeReceiver;
    EnumerableSet.UintSet storedChickens;

    function init(address _chikn, address _egg, address _feed) public initializer {
        require(address(chikn) == address(0), "already initialized");
        __Ownable_init();
        chikn = ChickenRunV5(_chikn);
        egg = EggV2(_egg);
        feed = FeedV2(_feed);

        // factory that deployed it
        feeReceiver = msg.sender;
    }

    function deposit(uint256[] calldata chiknIds) external onlyOwner {
        for (uint256 i = 0; i < chiknIds.length; i++) {
            // take control of the chickens
            require(storedChickens.add(chiknIds[i]), "Invalid chiknId");
            chikn.transferFrom(msg.sender, address(this), chiknIds[i]);
            emit Deposit(chiknIds[i], msg.sender);
        }

        egg.stake(chiknIds);
    }

    // withdraw feed, eggs, and chikns
    function withdraw(uint256[] memory chiknIds) public onlyOwner {
        withdrawFeed();
        withdrawEggs(chiknIds);
        withdrawChikns(chiknIds);
    }

    // withdraw chikns without claiming feed or eggs
    function withdrawFeed() public onlyOwner {
        if (staked) {
            // only works if we've made some eggs and staked them
            feed.withdrawAllEggAndClaimFeed();
            staked = false;
        }

        uint256 amount = feed.balanceOf(address(this));
        feed.transfer(msg.sender, amount);
        emit WithdrawFeed(amount, msg.sender);
    }

    // withdraw chikns without claiming feed or eggs
    function withdrawEggs(uint256[] memory chiknIds) public onlyOwner {
        egg.withdrawAllChiknAndClaim(chiknIds);
        uint256 amount = egg.balanceOf(address(this));
        egg.transfer(msg.sender, amount);
        emit WithdrawEggs(amount, msg.sender);
    }

    // withdraw chikns without claiming feed or eggs
    function withdrawChikns(uint256[] memory chiknIds) public onlyOwner {
        for (uint256 i = 0; i < chiknIds.length; i++) {
            // take control of the chickens
            require(storedChickens.remove(chiknIds[i]), "Invalid chiknId");
            chikn.transferFrom(address(this), msg.sender, chiknIds[i]);
            emit WithdrawChikn(chiknIds[i], msg.sender);
        }
    }

    function withdrawAll() external onlyOwner {
        withdraw(storedChickens.values());
    }

    function feedChikns(uint256[] memory chiknIds) public {
        staked = true;
        EggV2 _egg = egg;
        FeedV2 _feed = feed;

        uint256 eggBalanceBefore = _egg.balanceOf(address(this));
        _egg.claimEggs(chiknIds);
        uint256 eggBalanceAfter = _egg.balanceOf(address(this));
        uint256 fee = (eggBalanceAfter - eggBalanceBefore) * getFee() / FEE_DENOMINATOR;
        _egg.transfer(feeReceiver, fee);

        // stake all available eggs
        if (eggBalanceAfter - fee > 0) {
            _feed.staking(eggBalanceAfter - fee);
        }

        if (_feed.claimableView(address(this)) > 0) {
            // claim the feed and evenly spread it among the chickens
            _feed.claimFeed();
        }

        uint256 feedAvailable = _feed.balanceOf(address(this));

        for (uint256 i = 0; i < chiknIds.length && feedAvailable > 1e18; i++) {
            (uint256 kg,,,uint256 eaten,uint256 cooldownTs)= _egg.stakedChikn(chiknIds[i]);
            uint256 feedToLevel = (_egg.feedLevelingRate(kg) - eaten) * 1e18;
            if (feedToLevel == 0 && block.timestamp > cooldownTs) {
                _egg.levelUpChikn(chiknIds[i]);
            } else if (feedAvailable >= feedToLevel && block.timestamp > cooldownTs) {
                _feed.feedChikn(chiknIds[i], feedToLevel);
                _egg.levelUpChikn(chiknIds[i]);
                feedAvailable -= feedToLevel;
            }
            // no reason to feed less than amount to level
            // it might get wasted anyways as anything less than 1e18 gets burned
        }
    }

    function feedAll() external {
        feedChikns(storedChickens.values());
    }

    function getFee() public view returns (uint256) {
        return AutoRoostFactory(feeReceiver).fee();
    }
}
