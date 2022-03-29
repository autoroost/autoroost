pragma solidity 0.8.10;

import "contract/ChickenRunV5.sol";
import "contract/EggV2.sol";
import "contract/FeedV2.sol";
import "../../AutoRoost.sol";
import "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";


contract AutoFeedUser is ERC721Holder {
    ChickenRunV5 public chicken;
    EggV2 public egg;
    FeedV2 public feed;
    AutoRoost public autoRoost;

    constructor(address _chicken, address _egg, address _feed, address _autoRoost) {
        chicken = ChickenRunV5(_chicken);
        egg = EggV2(_egg);
        feed = FeedV2(_feed);
        autoRoost = AutoRoost(_autoRoost);
    }

    receive() payable external {
    }

    function mintChickens(uint256 num) external payable {
        chicken.mint{value: msg.value}(num);
    }

    function approveChickens(address to) external payable {
        chicken.setApprovalForAll(to, true);
    }

    function deposit(uint256[] calldata tokenIds) external {
        autoRoost.deposit(tokenIds);
    }

    function withdraw(uint256[] calldata tokenIds) external {
        autoRoost.withdraw(tokenIds);
    }

    function withdrawAll() external {
        autoRoost.withdrawAll();
    }

    function feedChikns(uint256[] calldata tokenIds) external {
        autoRoost.feedChikns(tokenIds);
    }

    function feedAll() external {
        autoRoost.feedAll();
    }

    function transferEgg(address to, uint256 amount) external {
        egg.transfer(to, amount);
    }
}
