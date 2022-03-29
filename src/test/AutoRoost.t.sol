// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import "solmate/test/utils/DSTestPlus.sol";
import "@openzeppelin/contracts/proxy/beacon/UpgradeableBeacon.sol";
import "contract/ChickenRunV5.sol";
import "contract/EggV2.sol";
import "contract/FeedV2.sol";
import "./mock/AutoFeedUser.sol";
import "../AutoRoost.sol";
import "../AutoRoostFactory.sol";

contract AutoRoostTest is DSTestPlus {
    ChickenRunV5 public chicken;
    EggV2 public egg;
    FeedV2 public feed;
    AutoRoost public autoRoost;
    AutoFeedUser public user;
    AutoRoostFactory public factory;

    receive() payable external {}

    function setUp() public {
        chicken = new ChickenRunV5();
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

        egg = new EggV2(address(chicken));
        feed = new FeedV2(address(chicken), address(egg));
        chicken.addAuthorized(address(egg));
        chicken.addAuthorized(address(feed));
        egg.addAuthorized(address(feed));
        egg.addAuthorized(address(chicken));
        feed.addAuthorized(address(egg));
        feed.addAuthorized(address(chicken));


        AutoRoost autoRoostImplementation = new AutoRoost();
        UpgradeableBeacon beacon = new UpgradeableBeacon(address(autoRoostImplementation));

        factory = new AutoRoostFactory(500, address(chicken), address(egg), address(feed), address(beacon));

        autoRoost = AutoRoost(factory.create());
        user = new AutoFeedUser(address(chicken), address(egg), address(feed), address(autoRoost));
        autoRoost.transferOwnership(address(user));
        payable(address(user)).transfer(5 ether);
        hevm.warp(1648589722);
    }

    function testExample() public {
        assertTrue(true);
    }

    function testMintChickens() public {
        user.mintChickens{value: 5}(5);
        assertEq(chicken.balanceOf(address(user)), 5);
    }

    function testDeposit() public {
        user.mintChickens{value: 5}(5);
        user.approveChickens(address(autoRoost));
        user.deposit(buildTokenIds(5));
        assertEq(chicken.balanceOf(address(autoRoost)), 5);
    }

    function testFailDepositNonOwner() public {
        user.mintChickens{value: 5}(5);
        user.approveChickens(address(autoRoost));
        autoRoost.deposit(buildTokenIds(5));
    }

    function testWithdraw() public {
        user.mintChickens{value: 5}(5);
        user.approveChickens(address(autoRoost));
        user.deposit(buildTokenIds(5));
        assertEq(chicken.balanceOf(address(autoRoost)), 5);

        user.withdraw(buildTokenIds(5));
        assertEq(chicken.balanceOf(address(autoRoost)), 0);
        assertEq(chicken.balanceOf(address(user)), 5);
    }

    function testWithdrawTwoParts() public {
        user.mintChickens{value: 5}(5);
        user.approveChickens(address(autoRoost));
        user.deposit(buildTokenIds(5));
        assertEq(chicken.balanceOf(address(autoRoost)), 5);

        user.withdraw(buildTokenIds(3));
        assertEq(chicken.balanceOf(address(autoRoost)), 2);
        assertEq(chicken.balanceOf(address(user)), 3);

        uint256[] memory tokenIds = new uint256[](2);
        tokenIds[0] = 4;
        tokenIds[1] = 5;
        user.withdraw(tokenIds);
        assertEq(chicken.balanceOf(address(autoRoost)), 0);
        assertEq(chicken.balanceOf(address(user)), 5);
    }

    function testFailWithdrawTooMany() public {
        user.mintChickens{value: 5}(5);
        user.approveChickens(address(autoRoost));
        user.deposit(buildTokenIds(5));
        assertEq(chicken.balanceOf(address(autoRoost)), 5);

        user.withdraw(buildTokenIds(6));
    }

    function testFailWithdrawNonOwnedChikns() public {
        user.mintChickens{value: 5}(5);
        user.approveChickens(address(autoRoost));
        user.deposit(buildTokenIds(5));
        assertEq(chicken.balanceOf(address(autoRoost)), 5);

        uint256[] memory tokenIds = new uint256[](2);
        tokenIds[0] = 7;
        tokenIds[1] = 9;
        user.withdraw(tokenIds);
    }

    function testFailWithdrawNonOwner() public {
        user.mintChickens{value: 5}(5);
        user.approveChickens(address(autoRoost));
        user.deposit(buildTokenIds(5));
        autoRoost.withdraw(buildTokenIds(5));
    }

    function testFailWithdrawFeedNonOwner() public {
        user.mintChickens{value: 5}(5);
        user.approveChickens(address(autoRoost));
        user.deposit(buildTokenIds(5));
        autoRoost.withdrawFeed();
    }

    function testFailWithdrawEggsNonOwner() public {
        user.mintChickens{value: 5}(5);
        user.approveChickens(address(autoRoost));
        user.deposit(buildTokenIds(5));
        autoRoost.withdrawEggs(buildTokenIds(5));
    }

    function testFailWithdrawChiknsNonOwner() public {
        user.mintChickens{value: 5}(5);
        user.approveChickens(address(autoRoost));
        user.deposit(buildTokenIds(5));
        autoRoost.withdrawChikns(buildTokenIds(5));
    }

    function testFailWithdrawAllNonOwner() public {
        user.mintChickens{value: 5}(5);
        user.approveChickens(address(autoRoost));
        user.deposit(buildTokenIds(5));
        autoRoost.withdrawAll();
    }

    function testWithdrawAll() public {
        user.mintChickens{value: 5}(5);
        user.approveChickens(address(autoRoost));
        user.deposit(buildTokenIds(5));
        assertEq(chicken.balanceOf(address(autoRoost)), 5);

        user.withdrawAll();
        assertEq(chicken.balanceOf(address(autoRoost)), 0);
        assertEq(chicken.balanceOf(address(user)), 5);
    }

    function testFeed() public {
        user.mintChickens{value: 5}(5);
        user.approveChickens(address(autoRoost));
        user.deposit(buildTokenIds(5));

        hevm.warp(1648589722 + 86400);
        autoRoost.feedChikns(buildTokenIds(5));
        (,, uint256 stakedAmount) = feed.eggStakeHolders(address(autoRoost));
        assertGt(stakedAmount, 0);
        (uint24 kg, , , , ) = egg.stakedChikn(1);
        assertEq(kg, 100);

        hevm.warp(1648589722 + 86400 * 2);
        autoRoost.feedChikns(buildTokenIds(5));
        (,, uint256 newStakedAmount) = feed.eggStakeHolders(address(autoRoost));
        assertGt(newStakedAmount, stakedAmount);

        (uint256 newKg, , , , ) = egg.stakedChikn(1);
        // not staked long enough to level up
        assertEq(newKg, kg);

        // warp a few more days, now it should level up
        hevm.warp(1648589722 + 86400 * 6);
        autoRoost.feedChikns(buildTokenIds(5));
        (newKg, , , , ) = egg.stakedChikn(1);
        assertGt(newKg, kg);
    }

    function testFeedAll() public {
        user.mintChickens{value: 5}(5);
        user.approveChickens(address(autoRoost));
        user.deposit(buildTokenIds(5));

        hevm.warp(1648589722 + 86400);
        autoRoost.feedAll();
        (,, uint256 stakedAmount) = feed.eggStakeHolders(address(autoRoost));
        assertGt(stakedAmount, 0);
        (uint24 kg, , , , ) = egg.stakedChikn(1);
        assertEq(kg, 100);

        hevm.warp(1648589722 + 86400 * 2);
        autoRoost.feedAll();
        (,, uint256 newStakedAmount) = feed.eggStakeHolders(address(autoRoost));
        assertGt(newStakedAmount, stakedAmount);

        (uint256 newKg, , , , ) = egg.stakedChikn(1);
        // not staked long enough to level up
        assertEq(newKg, kg);

        // warp a few more days, now it should level up
        hevm.warp(1648589722 + 86400 * 6);
        autoRoost.feedAll();
        (newKg, , , , ) = egg.stakedChikn(1);
        assertGt(newKg, kg);
    }

    function testWithdrawAfterFeed() public {
        testFeed();

        hevm.warp(1648589722 + 86400 * 500);
        assertEq(egg.balanceOf(address(user)), 0);
        assertEq(feed.balanceOf(address(user)), 0);
        assertEq(chicken.balanceOf(address(autoRoost)), 5);

        user.withdraw(buildTokenIds(5));

        assertEq(chicken.balanceOf(address(autoRoost)), 0);
        assertEq(chicken.balanceOf(address(user)), 5);
        assertGt(egg.balanceOf(address(user)), 0);
        assertGt(feed.balanceOf(address(user)), 0);
    }

    function testWithdrawThenWithdrawAll() public {
        testFeed();

        hevm.warp(1648589722 + 86400 * 500);
        assertEq(egg.balanceOf(address(user)), 0);
        assertEq(feed.balanceOf(address(user)), 0);
        assertEq(chicken.balanceOf(address(autoRoost)), 5);

        autoRoost.feedAll();
        user.withdraw(buildTokenIds(3));
        assertEq(chicken.balanceOf(address(autoRoost)), 2);
        assertEq(chicken.balanceOf(address(user)), 3);

        uint256[] memory tokenIds = new uint256[](2);
        tokenIds[0] = 4;
        tokenIds[1] = 5;
        user.withdraw(tokenIds);

        assertEq(chicken.balanceOf(address(autoRoost)), 0);
        assertEq(chicken.balanceOf(address(user)), 5);
        assertGt(egg.balanceOf(address(user)), 0);
        assertGt(feed.balanceOf(address(user)), 0);
    }

    function testDontTakeFeesOnDepositedEggs() public {
        testWithdrawAfterFeed();
        uint256 factoryBalanceBefore = egg.balanceOf(address(factory));

        // user now has some eggs
        uint256 eggAmt = egg.balanceOf(address(user));
        assertGt(eggAmt, 0);

        AutoRoost newAutoRoost = AutoRoost(factory.create());
        AutoFeedUser newUser = new AutoFeedUser(address(chicken), address(egg), address(feed), address(newAutoRoost));
        newAutoRoost.transferOwnership(address(newUser));
        user.transferEgg(address(newAutoRoost), eggAmt);

        newAutoRoost.feedAll();
        assertEq(egg.balanceOf(address(factory)) - factoryBalanceBefore, 0);
    }

    function testStakeDepositedEggs() public {
        testWithdrawAfterFeed();

        // user now has some eggs
        uint256 eggAmt = egg.balanceOf(address(user));
        assertGt(eggAmt, 0);

        AutoRoost newAutoRoost = AutoRoost(factory.create());
        AutoFeedUser newUser = new AutoFeedUser(address(chicken), address(egg), address(feed), address(newAutoRoost));
        newAutoRoost.transferOwnership(address(newUser));
        user.transferEgg(address(newAutoRoost), eggAmt);
        (,,uint256 stakedEggs) = feed.eggStakeHolders(address(newAutoRoost));

        newAutoRoost.feedAll();
        (,,uint256 newStakedEggs) = feed.eggStakeHolders(address(newAutoRoost));
        assertGt(newStakedEggs - stakedEggs, 0);
    }

    function testFees() public {
        user.mintChickens{value: 5}(5);
        user.approveChickens(address(autoRoost));
        user.deposit(buildTokenIds(5));

        hevm.warp(1648589722 + 86400);
        assertEq(egg.balanceOf(address(factory)), 0);
        autoRoost.feedChikns(buildTokenIds(5));
        uint256 eggFees = egg.balanceOf(address(factory));
        assertGt(eggFees, 0);

        hevm.warp(1648589722 + 86400 * 2);
        autoRoost.feedChikns(buildTokenIds(5));
        uint256 eggFeesNew = egg.balanceOf(address(factory));
        assertGt(eggFeesNew, eggFees);
    }

    function testFeesAfterUpdate() public {
        user.mintChickens{value: 5}(5);
        user.approveChickens(address(autoRoost));
        user.deposit(buildTokenIds(5));

        factory.setFee(1000);

        hevm.warp(1648589722 + 86400);
        assertEq(egg.balanceOf(address(factory)), 0);
        autoRoost.feedChikns(buildTokenIds(5));
        uint256 eggFees = egg.balanceOf(address(factory));
        assertGt(eggFees, 0);

        hevm.warp(1648589722 + 86400 * 2);
        autoRoost.feedChikns(buildTokenIds(5));
        uint256 eggFeesNew = egg.balanceOf(address(factory));
        assertGt(eggFeesNew, eggFees);
    }

    function testClaimFees() public {
        user.mintChickens{value: 5}(5);
        user.approveChickens(address(autoRoost));
        user.deposit(buildTokenIds(5));

        hevm.warp(1648589722 + 86400);
        autoRoost.feedChikns(buildTokenIds(5));
        hevm.warp(1648589722 + 86400 * 2);
        autoRoost.feedChikns(buildTokenIds(5));

        assertEq(egg.balanceOf(address(this)), 0);
        factory.claimFees();
        assertGt(egg.balanceOf(address(this)), 0);
        assertEq(egg.balanceOf(address(factory)), 0);
    }

    function buildTokenIds(uint256 amt) internal pure returns (uint256[] memory) {
        uint256[] memory tokenIds = new uint256[](amt);
        for (uint256 i = 1; i <= amt; i++) {
            tokenIds[i - 1] = i;
        }
        return tokenIds;
    }
}
