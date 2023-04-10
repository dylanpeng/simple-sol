// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Account {
    uint256 public accId;

    //construction?
    constructor(uint256 accountId) payable {
        accId = accountId;
    }
}

contract Initialize {
    constructor() payable{}

    Account public account = new Account(10);

    event accountEvent(uint256 accountId);

    function newAccount(uint256 accountId) public {
        account = new Account(accountId);
        emit accountEvent(accountId);
    }

    function newAccountWithEther(uint256 accountId, uint256 amount)
        public
        payable
    {
        account = new Account{value: amount}(accountId);
        emit accountEvent(accountId);
    }

    function getBalance(address addr) public view returns (uint256) {
        return addr.balance;
    }

    function getAccountId() public view returns(uint256){
        return account.accId();
    }

    function getThisAddr() public view returns(address){
        return address(this);
    }
}
