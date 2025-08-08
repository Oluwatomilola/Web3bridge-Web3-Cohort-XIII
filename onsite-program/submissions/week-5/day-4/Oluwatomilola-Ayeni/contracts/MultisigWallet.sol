// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract MultisigWallet {
    address[] public owners;
    mapping(address => bool) public isOwner;
    uint public required; // number of confirmations required

    struct Transaction {
        address to;
        uint value;
        bytes data;
        bool executed;
        uint numConfirmations;
    }

    Transaction[] public transactions;

    // txId => owner => confirmed
    mapping(uint => mapping(address => bool)) public confirmations;

    modifier onlyOwner() {
        require(isOwner[msg.sender], "Not owner");
        _;
    }

    modifier txExists(uint _txId) {
        require(_txId < transactions.length, "Tx does not exist");
        _;
    }

    modifier notExecuted(uint _txId) {
        require(!transactions[_txId].executed, "Tx already executed");
        _;
    }

    modifier notConfirmed(uint _txId) {
        require(!confirmations[_txId][msg.sender], "Tx already confirmed");
        _;
    }

    constructor(address[] memory _owners, uint _required) {
        require(_owners.length > 0, "Owners required");
        require(_required > 0 && _required <= _owners.length, "Invalid required number of confirmations");

        for (uint i = 0; i < _owners.length; i++) {
            address owner = _owners[i];
            require(owner != address(0), "Invalid owner");
            require(!isOwner[owner], "Owner not unique");

            isOwner[owner] = true;
            owners.push(owner);
        }

        required = _required;
    }

    // Allow contract to receive Ether
    receive() external payable {
        // intentionally no event
    }

    function submitTransaction(address _to, uint _value, bytes calldata _data) external onlyOwner returns (uint) {
        uint txId = transactions.length;

        transactions.push(Transaction({
            to: _to,
            value: _value,
            data: _data,
            executed: false,
            numConfirmations: 0
        }));

        // Auto-confirm by the submitter
        _confirm(txId);

        return txId;
    }

    function confirmTransaction(uint _txId) external onlyOwner txExists(_txId) notExecuted(_txId) notConfirmed(_txId) {
        _confirm(_txId);
    }

    function _confirm(uint _txId) internal {
        confirmations[_txId][msg.sender] = true;
        transactions[_txId].numConfirmations += 1;
        // intentionally no event
    }

    function executeTransaction(uint _txId) external onlyOwner txExists(_txId) notExecuted(_txId) {
        Transaction storage transaction_ = transactions[_txId];

        require(transaction_.numConfirmations >= required, "Not enough confirmations");

        transaction_.executed = true;

        (bool success, ) = transaction_.to.call{value: transaction_.value}(transaction_.data);

        if (!success) {
            // If it failed, revert the executed flag so it can be retried or handled
            transaction_.executed = false;
        }
        // intentionally no event emitted on success/failure
    }

    // Read helpers
    function getOwners() external view returns (address[] memory) {
        return owners;
    }

    function getTransactionCount() external view returns (uint) {
        return transactions.length;
    }

    function getTransaction(uint _txId) external view returns (address to, uint value, bytes memory data, bool executed, uint numConfirmations) {
        Transaction storage transaction_ = transactions[_txId];
        return (transaction_.to, transaction_.value, transaction_.data, transaction_.executed, transaction_.numConfirmations);
    }
}