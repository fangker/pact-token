// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;
//pragma experimental ABIEncoderV2;
import "./Governable.sol";
import "./standard/token/ERC20/SafeERC20.sol";
import "./standard/math/SafeMathUpgradeable.sol";

interface IFarm {
    function crop() external view returns (address);
}

interface ISPool {
    event Farming(address indexed farmer, address indexed from, uint amount);
    event Unfarming(address indexed farmer, address indexed to, uint amount);
    event Harvest(address indexed farmer, address indexed to, uint[] amounts);

    function setHarvestSpan(uint _span, bool isLinear) external;

    function farming(uint amount) external;

    function farming(address from, uint amount) external;

    function unfarming() external returns (uint amount);

    function unfarming(uint amount) external returns (uint);

    function unfarming(address to, uint amount) external returns (uint);

    function harvest() external returns (uint[] memory amounts);

    function harvest(address to) external returns (uint[] memory amounts);

    function harvestCapacity(address farmer) external view returns (uint[] memory amounts);
}

contract SExactPool is ISPool, Configurable {
    using SafeMathUpgradeable  for uint;
    using SafeERC20 for IERC20;

    address public farm;
    address public underlying;
    uint public span;
    uint public end;
    uint public totalStaking;
    mapping(address => uint) public stakingOf;
    mapping(address => uint) public sumRewardPerOf;
    uint public sumRewardPer;
    uint public bufReward;
    uint public lasttime;

    function initialize(address governor, address _farm, address _underlying) public initializer {
        super.initialize(governor);

        farm = _farm;
        underlying = _underlying;

        IFarm(farm).crop();
        // just check
        IERC20(underlying).totalSupply();
        // just check
    }

    function setHarvestSpan(uint _span, bool isLinear) virtual override external governance {
        span = _span;
        if (isLinear)
            end = now + _span;
        else
            end = 0;
        lasttime = now;
    }

    function farming(uint amount) virtual override external {
        farming(msg.sender, amount);
    }

    function farming(address from, uint amount) virtual override public {
        harvest();

        _farming(from, amount);

        stakingOf[msg.sender] = stakingOf[msg.sender].add(amount);
        totalStaking = totalStaking.add(amount);

        emit Farming(msg.sender, from, amount);
    }

    function _farming(address from, uint amount) virtual internal {
        IERC20(underlying).safeTransferFrom(from, address(this), amount);
    }

    function unfarming() virtual override external returns (uint amount){
        return unfarming(msg.sender, stakingOf[msg.sender]);
    }

    function unfarming(uint amount) virtual override external returns (uint){
        return unfarming(msg.sender, amount);
    }

    function unfarming(address to, uint amount) virtual override public returns (uint){
        harvest();

        totalStaking = totalStaking.sub(amount);
        stakingOf[msg.sender] = stakingOf[msg.sender].sub(amount);

        _unfarming(to, amount);

        emit Unfarming(msg.sender, to, amount);
        return amount;
    }

    function _unfarming(address to, uint amount) virtual internal returns (uint){
        IERC20(underlying).safeTransfer(to, amount);
        return amount;
    }

    function harvest() virtual override public returns (uint[] memory amounts) {
        return harvest(msg.sender);
    }

    function harvest(address to) virtual override public returns (uint[] memory amounts) {
        amounts = new uint[](1);
        amounts[0] = 0;
        if (span == 0 || totalStaking == 0)
            return amounts;

        uint delta = _harvestDelta();
        amounts[0] = _harvestCapacity(msg.sender, delta, sumRewardPer, sumRewardPerOf[msg.sender]);

        if (delta != amounts[0])
            bufReward = bufReward.add(delta).sub(amounts[0]);
        if (delta > 0)
            sumRewardPer = sumRewardPer.add(delta.mul(1 ether).div(totalStaking));
        if (sumRewardPerOf[msg.sender] != sumRewardPer)
            sumRewardPerOf[msg.sender] = sumRewardPer;
        lasttime = now;

        _harvest(to, amounts);

        emit Harvest(msg.sender, to, amounts);
    }

    function _harvest(address to, uint[] memory amounts) virtual internal {
        if (amounts.length > 0 && amounts[0] > 0) {
            IERC20(IFarm(farm).crop()).safeTransferFrom(farm, to, amounts[0]);
            if (config['teamAddr'] != 0 && config['teamRatio'] != 0)
                IERC20(IFarm(farm).crop()).safeTransferFrom(farm, address(config['teamAddr']), amounts[0].mul(config['teamRatio']).div(1 ether));
        }
    }

    function harvestCapacity(address farmer) virtual override public view returns (uint[] memory amounts) {
        amounts = new uint[](1);
        amounts[0] = _harvestCapacity(farmer, _harvestDelta(), sumRewardPer, sumRewardPerOf[farmer]);
    }

    function _harvestCapacity(address farmer, uint delta, uint sumPer, uint lastSumPer) virtual internal view returns (uint amount) {
        if (span == 0 || totalStaking == 0)
            return 0;

        amount = sumPer.sub(lastSumPer);
        amount = amount.add(delta.mul(1 ether).div(totalStaking));
        amount = amount.mul(stakingOf[farmer]).div(1 ether);
    }

    function _harvestDelta() virtual internal view returns (uint amount) {
        amount = IERC20(IFarm(farm).crop()).allowance(farm, address(this)).sub(bufReward);

        if (end == 0) {// isNonLinear, endless
            if (now.sub(lasttime) < span)
                amount = amount.mul(now.sub(lasttime)).div(span);
        } else if (now < end)
            amount = amount.mul(now.sub(lasttime)).div(end.sub(lasttime));
        else if (lasttime >= end)
            amount = 0;
    }
}


contract Farm is IFarm, Governable {
    using SafeERC20 for IERC20;

    address _crop;

    function crop() external override view returns (address) {
        return _crop;
    }

    function initialize(address governor, address crop_) public initializer {
        super.initialize(governor);
        _crop = crop_;
    }

    function approvePool(address pool, uint amount) public governance {
        IERC20(_crop).safeApprove(pool, amount);
    }

    function approveToken(address token, address pool, uint amount) public governance {
        IERC20(token).safeApprove(pool, amount);
    }

}
