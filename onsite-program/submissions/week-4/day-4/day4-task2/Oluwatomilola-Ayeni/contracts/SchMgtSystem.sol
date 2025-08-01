// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract SchoolManagementSystem {
    error STUDENT_NOT_FOUND();
    error INVALID_ID();
    error INVALID_ADDRESS();

    enum Status {
        ACTIVE,
        DEFERRED,
        RUSTICATED
    }

    struct StudentDetails {
        address studentAddress;
        string name;
        uint256 age;
        Status status;
    }
    mapping (address => StudentDetails) studentDetails;

    StudentDetails[] students;

    function another_registration(StudentDetails memory details) external {

        details = StudentDetails(details.studentAddress, details.name, details.age, Status.ACTIVE);

        students.push(details);
    }

    function register_student(address _studentAddress,string memory _name, uint256 _age) external {

        StudentDetails memory _student_details = StudentDetails(_studentAddress, _name, _age, Status.ACTIVE);

        students.push(_student_details);
    }

    function update_student(address _studentAddress, string memory _new_name) external {
        studentDetails[_studentAddress].name = _new_name;
    }

    function get_student_by_id(address _studentAddress) external view returns (StudentDetails memory) {
        // require(_student_id <= students.length, "invalid id");
        // return students;

        for (uint i; i < students.length; i++) {
            if (students[i].studentAddress == _studentAddress) {
                return students[i];
            }
        }
        revert INVALID_ADDRESS();
        
    }

    function update_students_status(address _studendAddress, Status _status) external {
        // require(_student_id <= students.length, "invalid id");
        studentDetails[_studendAddress].status = _status;

        revert INVALID_ADDRESS();
    }

    function delete_student(address _studentAddress) external {
        for (uint256 i; i < students.length; i++) {
            if (students[i].studentAddress == _studentAddress) {
                students[i] = students[students.length - 1];
                students.pop();

                return;
            }
        }
        revert STUDENT_NOT_FOUND();
    }

    function get_all_students() external view returns (StudentDetails[] memory) {
        return students;
    }
}