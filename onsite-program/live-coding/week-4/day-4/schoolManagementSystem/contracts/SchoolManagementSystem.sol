// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract SchoolManagementSystem {
    error STUDENT_NOT_FOUND();
    error INVALID_ID();

    enum Status {
        ACTIVE,
        DEFERRED,
        RUSTICATED
    }

    struct StudentDetails {
        uint256 id;
        string name;
        string course;
        uint256 age;
        Status status;
    }

    error INVALID_SENDER();

    uint256 private uid;

    StudentDetails[] public students;

    function another_registration(StudentDetails memory details) external {
        uid = uid + 1;

        details = StudentDetails(uid, details.name, details.course, details.age, Status.ACTIVE);

        students.push(details);
    }

    function register_student(string memory _name, string memory _course, uint256 _age) external {
        uid = uid + 1;

        StudentDetails memory _student_details = StudentDetails(uid, _name, _course, _age, Status.ACTIVE);

        students.push(_student_details);
    }

    function update_student(uint256 _student_id, string memory _new_name) external {
        for (uint256 i; i < students.length; i++) {
            if (students[i].id == _student_id) {
                students[i].name = _new_name;
            }
        }
    }

    function get_student_by_id(uint256 _student_id) external view returns (StudentDetails memory) {
        // require(_student_id <= students.length, "invalid id");

        for (uint256 i; i < students.length; i++) {
            if (students[i].id == _student_id) {
                return students[i];
            }
        }
    }

    function update_students_status(uint256 _student_id, Status _new_status) external {
        require(_student_id <= students.length, "invalid id");

        for (uint256 i; i < students.length; i++) {
            if (students[i].id == _student_id) {
                students[i].status = _new_status;
                return;
            }
        }

        revert INVALID_ID();
    }

    function delete_student(uint256 _student_id) external {
        for (uint256 i; i < students.length; i++) {
            if (students[i].id == _student_id) {
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
