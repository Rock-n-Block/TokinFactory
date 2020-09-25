// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "./Tokens/initDouble_B.sol";
import "openzeppelin-solidity/contracts/access/Ownable.sol";

contract TokenFactoryDouble_B is Ownable
{
    address public TokenFactoryMain = address(0);

    constructor() public {
    }

    modifier onlyMain{
        require(TokenFactoryMain != address(0));
        require(msg.sender == TokenFactoryMain);
        _;
    }

    function setTokenFactoryMain(address _TokenFactoryMain) public onlyOwner {
        TokenFactoryMain = _TokenFactoryMain;
    }

    function createToken
    (
        string memory name,
        string memory symbol,
        uint8 decimals,
        bool isBurnable,
        bool isCapped,
        uint256 cap,
        bool isSnapshot,
        bool isPausable
    )
    public
    onlyMain
    returns (address newToken)
    {
        if (isBurnable == true &&
            isCapped   == true)
            return address(new tokenBC(name, symbol, decimals, cap));
        else if (isBurnable == true &&
                 isSnapshot == true)
            return address(new tokenBS(name, symbol, decimals));
        else if (isBurnable == true &&
                 isPausable == true)
            return address(new tokenBP(name, symbol, decimals));
    }
}