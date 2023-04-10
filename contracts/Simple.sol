// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Simple {
    address public owner;
    mapping(address => uint256) public balances;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function.");
        _;
    }

    event airdropEvent(address receiver, uint256 number, uint256 balance);
    event buyEvent(address buyer, uint256 value, uint256 balance);
    event transferEvent(address sender, address receiver, uint256 number, uint256 senderBalance, uint256 receiverBalance);

    function airdrop(address receiver, uint256 number)
        public
        payable
        onlyOwner
        returns (uint256)
    {
        balances[receiver] += number;
        emit airdropEvent(receiver, number, balances[receiver]);
        return number;
    }

    function transfer(address receiver, uint256 number)
        public
        payable
        returns (uint256)
    {
        require(balances[msg.sender] >= number, "you don't have enough balance.");
        balances[msg.sender] -= number;
        balances[receiver] += number;
        emit transferEvent(msg.sender, receiver, number, balances[msg.sender], balances[receiver]);
        return balances[receiver];
    }

    function buy() public payable returns(uint256, uint256){
        require(msg.value > 0, "no eth value.");
        balances[msg.sender] += msg.value * 100;
        emit buyEvent(msg.sender, msg.value, balances[msg.sender]);
        return(msg.value, balances[msg.sender]);
    }

    function sayHello() public pure returns (string memory) {
        return "hello wold!";
    }

    function getBalance(address account) public view returns (uint256) {
        return account.balance;
    }


}
