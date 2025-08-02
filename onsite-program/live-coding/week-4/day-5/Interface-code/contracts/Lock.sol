// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import "../interfaces/ITodo.sol";
import "../library/Error.sol";

contract Todo is ITodo {
    address owner;

    constructor() {
        owner = msg.sender;
    }

    Todos[] todo;

    function create(string memory _name, string memory _description) external {
        if (owner != msg.sender) {
            revert Error.NOT_PERMITTED();
        }
        Todos memory _new_todo = Todos(_name, _description);
        todo.push(_new_todo);
    }

    function get_todos() external view returns (Todos[] memory) {
        return todo;
    }
}
