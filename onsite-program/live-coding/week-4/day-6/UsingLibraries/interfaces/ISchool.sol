// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

interface ISchool {
    struct Student {
        string name;
        uint256 age;
    }

    function register_student_array_map(string memory _name, uint256 _age) external;

    function get_students() external view returns (Student[] memory);

    function register_student_(string memory _name, uint256 _age) external;
}
