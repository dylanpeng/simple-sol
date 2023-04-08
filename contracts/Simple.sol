// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Simple {
    address public owner;
    mapping(address => uint256) public balance;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function.");
        _;
    }

    function airdrop(address receiver, uint256 number)
        public
        payable
        onlyOwner
        returns (uint256)
    {
        balance[receiver] += number;
        return balance[receiver];
    }

    function getBalance(address addr) public view returns (uint256) {
        return balance[addr];
    }

    function getOwner() public view returns (address) {
        return owner;
    }

    function sayHello() public pure returns (string memory) {
        return "hello wold!";
    }
}
