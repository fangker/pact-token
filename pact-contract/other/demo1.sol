contract SSimplePool is ISPool, Configurable {
    using SafeMath for uint;
    using SafeERC20 for IERC20;

    address public farm;
    address public underlying;
    uint public span;
    uint public end;
    uint public totalStaking;
    mapping(address => uint) public stakingOf;
    mapping(address => uint) public lasttimeOf;

    function initialize(address governor, address _farm, address _underlying) public initializer {
        super.initialize(governor);

        farm     = _farm;
        underlying  = _underlying;

        IFarm(farm).crop();                         // just check
        IERC20(underlying).totalSupply();           // just check
    }

    function setHarvestSpan(uint _span, bool isLinear) virtual override external governance {
        span = _span;
        if(isLinear)
            end = now + _span;
        else
            end = 0;
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
        amounts = harvestCapacity(msg.sender);
        _harvest(to, amounts);

        lasttimeOf[msg.sender] = now;

        emit Harvest(msg.sender, to, amounts);
    }
    function _harvest(address to, uint[] memory amounts) virtual internal {
        if(amounts.length > 0 && amounts[0] > 0) {
            IERC20(IFarm(farm).crop()).safeTransferFrom(farm, to, amounts[0]);
            if(config['teamAddr'] != 0 && config['teamRatio'] != 0)
                IERC20(IFarm(farm).crop()).safeTransferFrom(farm, address(config['teamAddr']), amounts[0].mul(config['teamRatio']).div(1 ether));
        }
    }

    function harvestCapacity(address farmer) virtual override public view returns (uint[] memory amounts) {
        if(span == 0 || totalStaking == 0)
            return amounts;

        uint amount = IERC20(IFarm(farm).crop()).allowance(farm, address(this));
        amount = amount.mul(stakingOf[farmer]).div(totalStaking);

        uint lasttime = lasttimeOf[farmer];
        if(end == 0) {                                                         // isNonLinear, endless
            if(now.sub(lasttime) < span)
                amount = amount.mul(now.sub(lasttime)).div(span);
        }else if(now < end)
            amount = amount.mul(now.sub(lasttime)).div(end.sub(lasttime));
        else if(lasttime >= end)
            amount = 0;

        amounts = new uint[](1);
        amounts[0] = amount;
    }
}
