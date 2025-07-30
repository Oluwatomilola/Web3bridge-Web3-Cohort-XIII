// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract SchoolManagementSystem {
    // Enum to define student status
    enum Status {ACTIVE, DEFERRED, RUSTICATED}
    
    // Struct to store student details
    struct Student {
        uint256 id;
        string name;
        uint256 age;
        Status status;
    }

    // Array to store student details
    Student[] public students;

    //Register a new student
    function registerStudent (uint256 _id, string memory _name, uint256 _age) external {
        require(bytes(_name).length > 0, "Name cannot be empty");
        require(_age > 0 && _age < 20, "Invalid age");
        require(_id >= students.length, "ID must be unique and sequential");

        
        while (students.length <= _id) {
            students.push();
        }

        students[_id] = Student({
            id: _id,
            name: _name,
            age: _age,
            status: Status.ACTIVE
        });
    }

    // Update student details
    function update_student(uint256 _id, string memory _new_name, uint256 _new_age) external {
        require(_id < students.length, "Invalid id");
        require(bytes(_new_name).length > 0, "Name cannot be empty");
        require(_new_age > 0 && _new_age < 150, "Invalid age");

        students[_id].name = _new_name;
        students[_id].age = _new_age;
    }
        

       // Change student status
    function change_student_status(uint256 _id, Status _newStatus) external {
        require(_id < students.length, "Invalid id");

        students[_id].status = _newStatus;
    }
// View all students
    function view_student() external view returns (Student[] memory) {
        return students;
    }

    // Delete a student
    function delete_student(uint256 _id) external {
        require(_id < students.length, "Invalid id");

        delete students[_id];
    }

    }
    


