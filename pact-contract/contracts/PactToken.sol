pragma solidity ^0.6.0;

import "./Governable.sol";
import "./standard/token/ERC20/ERC20Upgradeable.sol";

contract PactToken is ERC20Upgradeable, Governable {
    function initialize(address governor_, address locked, address farm, address eco, address lp) public initializer {
        Governable.initialize(governor_);
        ERC20Upgradeable.__ERC20_init("Pact Token", "PACT");

        uint8 decimals = 18;
        _setupDecimals(decimals);

        _mint(locked, 50000000 * 10 ** uint256(decimals));
        // 50.0%
        _mint(farm, 30500000 * 10 ** uint256(decimals));
        // 30.5%
        _mint(eco, 7500000 * 10 ** uint256(decimals));
        //  9.5%
        _mint(lp, 10000000 * 10 ** uint256(decimals));
        // 10.0%
    }

}
