// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract TodoList {
    struct Todo {
        string title;
        string description;
        bool status;
    }

    mapping(address => Todo[]) private userTodos;

    function newTodo(string memory _title,string memory _description) external {
        Todo memory _newTodo = Todo(_title, _description, false);
        userTodos[msg.sender].push(_newTodo);
    }

    function updateTodo(
        uint256 _index,
        string memory _title,
        string memory _description
    ) external {
        require(_index < userTodos[msg.sender].length, "Invalid index");
        userTodos[msg.sender][_index].title = _title;
        userTodos[msg.sender][_index].description = _description;
    }

    function updateStatus(uint256 _index) external {
        require(_index < userTodos[msg.sender].length, "Invalid index");
        userTodos[msg.sender][_index].status = !userTodos[msg.sender][_index]
            .status;
    }

    function getAllTodos() external view returns (Todo[] memory) {
        return userTodos[msg.sender];
    }

    function deleteTodo(uint256 _index) external {
        require(_index < userTodos[msg.sender].length, "Invalid index");
        uint256 lastIndex = userTodos[msg.sender].length - 1;
        if (_index != lastIndex) {
            userTodos[msg.sender][_index] = userTodos[msg.sender][lastIndex];
        }
        userTodos[msg.sender].pop();
    }
}
