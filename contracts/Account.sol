// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Account {
    uint256 public accId;
    event msgInfoEvent(
        address msgSender,
        uint256 msgValue,
        uint256 msgBalance,
        uint256 num
    );
    event accountInfo(
        address accountAddr,
        uint256 accountId,
        uint256 accountBalance
    );

    //construction?
    constructor(uint256 accountId) payable {
        accId = accountId;
    }

    function getInfo(uint256 num) public payable returns(uint256){
        emit msgInfoEvent(address(msg.sender), msg.value, msg.sender.balance, num);
        emit accountInfo(address(this), accId, address(this).balance);
        return num;
    }
}

contract Initialize {
    // 合约构造函数
    constructor() payable {}

    // 回退函数
    fallback() external payable {}

    // 以太币收发函数
    receive() external payable {}

    Account public account = new Account(10);

    // 事件
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

    function getAccountId() public view returns (uint256) {
        return account.accId();
    }

    function getThisAddr() public view returns (address) {
        return address(this);
    }

    function callAccountInfo(address _contractAddress) public payable {
        (bool success1, bytes memory result1) = address(_contractAddress).call(
            abi.encodeWithSignature("getInfo(uint256)", 2)
        );
        require(success1, "call fail");
        emit accountEvent(abi.decode(result1, (uint256)));

        (bool success2, bytes memory result2) = address(_contractAddress).delegatecall(
            abi.encodeWithSignature("getInfo(uint256)", 3)
        );
        require(success2, "delegatecall fail");
        emit accountEvent(abi.decode(result2, (uint256)));
    }
}
