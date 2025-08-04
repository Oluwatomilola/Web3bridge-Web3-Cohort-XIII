// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import "../interfaces/ISchool.sol";
// import "../contracts/libraries/Storage.sol";

contract School is ISchool {
    Student[] public students;
    // address owner;
    //
    // error ONLY_OWNER_CAN_CALL();
    //
    // constructor() {
    //     owner = msg.sender;
    // }
    //
    // modifier OnlyOwner() {
    //     require(owner == msg.sender, ONLY_OWNER_CAN_CALL());
    //     _;
    // }

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

    function get_students_length() external view returns (uint256) {
        return students.length;
    }
}
