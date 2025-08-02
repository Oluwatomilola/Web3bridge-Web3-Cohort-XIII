// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

interface ITodo {
    struct Todos {
        string name;
        string description;
    }

    // enum Hello {
    //     Active,
    //     Inactive
    // }

    function create(string memory _name, string memory _description) external;

    function get_todos() external view returns (Todos[] memory);
}
