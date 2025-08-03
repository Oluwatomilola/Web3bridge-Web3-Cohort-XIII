// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import "../interfaces/ISchool.sol";
// import "../contracts/libraries/Storage.sol";

contract School is ISchool {
    Student[] students;

    mapping(address => Student[]) get_student_by_address_array;

    mapping(address => Student) get_student_by_address;

    function register_student_(string memory _name, uint256 _age) external {
        Student memory new_student_ = Student({name: _name, age: _age});

        get_student_by_address[msg.sender] = new_student_;

        students.push(new_student_);
    }

    function register_student_array_map(string memory _name, uint256 _age) external {
        Student memory new_student_ = Student({name: _name, age: _age});

        get_student_by_address_array[msg.sender].push(new_student_);

        students.push(new_student_);
    }

    function get_students() external view returns (Student[] memory) {
        return students;
    }
}
