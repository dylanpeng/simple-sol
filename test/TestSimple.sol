// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// These files are dynamically created at test time
import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Simple.sol";

contract TestSimple {
    function testInitialBalanceUsingDeployedContract() public {
        Simple meta = Simple(DeployedAddresses.Simple());

        uint256 expected = 0;

        Assert.equal(
            meta.getBalance(tx.origin),
            expected,
            "Owner should have 100 MetaCoin initially"
        );
    }
}
