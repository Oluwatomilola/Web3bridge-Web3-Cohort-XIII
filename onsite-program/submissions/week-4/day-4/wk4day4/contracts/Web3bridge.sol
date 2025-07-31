// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Web3bridge {

    enum Role {
        media_team, // 0
        mentors,    // 1
        managers,   // 2
        social_media_team,  // 3
        technician_supervisors, // 4
        kitchen_staff   // 5
    }

    enum Status {
        member,     // 0
        terminated  // 1
    }

    struct EmployeeData {
        address employeeAddress;
        string name;
        Role role;
        Status status;
    }
    
    mapping (address => EmployeeData) employeeData;
    address[] employee_data;

    error INVALID_ROLE();

    function recruitEmployee(address _employeeAddress, string memory _name, Role _role) external {
        require(bytes(employeeData[_employeeAddress].name).length == 0, "Employee already exist");
        employeeData[_employeeAddress] = EmployeeData(_employeeAddress, _name, _role, Status.member);
        employee_data.push(_employeeAddress);
    }

    function updateEmployeeDetail(address _employeeAddress, Role _role) external  {
        require(bytes(employeeData[_employeeAddress].name).length != 0, "No such employee");
        employeeData[_employeeAddress].role = _role;

        revert INVALID_ROLE(); // <-- This is intentionally placed here. You may remove or adjust.
    }

    function terminateEmployee(address _employeeAddress) external {
        require(bytes(employeeData[_employeeAddress].name).length != 0, "No such employee");
        employeeData[_employeeAddress].status = Status.terminated;
    }

    function getEmployeeData(address _employeeAddress) external view returns (EmployeeData memory) {
        return employeeData[_employeeAddress];
    }

    function getAllEmployee() external view returns (address[] memory) {
        return employee_data;
    }

    /// @notice Determines if an employee is allowed access to the garage
    function canAccessGarage(address _employeeAddress) external view returns (bool) {
        EmployeeData memory emp = employeeData[_employeeAddress];

        // Ensure the employee exists
        if (bytes(emp.name).length == 0) {
            return false;
        }

        // Must be an active member
        if (emp.status != Status.member) {
            return false;
        }

        // Check if role is allowed
        if (
            emp.role == Role.media_team ||
            emp.role == Role.mentors ||
            emp.role == Role.managers
        ) {
            return true;
        }

        return false;
    }
}