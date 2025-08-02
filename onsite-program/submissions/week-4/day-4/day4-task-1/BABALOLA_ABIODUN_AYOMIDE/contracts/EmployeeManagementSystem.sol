// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract EmployeeManagementSystem {
    enum Position {MEDIA_TEAM,MENTOR,MANAGER,SOCIAL_MEDIA_TEAM,TECHNICIAN_SUPERVISOR,KITCHEN_STAFF }
    struct Employee{
        string name;
        Position role;
        bool isEmployed;
        address employeeAddress;
    }
    mapping (address=> Employee) private employees;
    Employee[] private allEmployees;
    error INVALID_DATA_PASSED();
    function addEmployee(address employeeAddress ,string memory name, Position role)external {
        Employee memory employee = Employee(name, role, true, employeeAddress);
        employees[employeeAddress]= employee;
        allEmployees.push(employee);
    }

    function updateEmployees(address employeeAddress, string memory name) external {
        for(uint counter; counter< allEmployees.length; counter++){
            if(allEmployees[counter].employeeAddress== employeeAddress){
                allEmployees[counter].name= name;
                employees[employeeAddress].name=name;
                return;
            }
        }
        revert INVALID_DATA_PASSED();
    }
    function toggleEmploymentStatus(address employeeAddress) external {
        for(uint counter; counter< allEmployees.length; counter++){
            if(allEmployees[counter].employeeAddress== employeeAddress){
                bool newStatus = !allEmployees[counter].isEmployed;
                allEmployees[counter].isEmployed = newStatus;
                employees[employeeAddress].isEmployed = newStatus;
                return;
            }
        }
        revert INVALID_DATA_PASSED();
    }

    function updateEmployeeRole(address employeeAddress, Position role) external {
        for(uint counter; counter< allEmployees.length; counter++){
            if(allEmployees[counter].employeeAddress== employeeAddress){
                allEmployees[counter].role= role;
                employees[employeeAddress].role=role;
                return;
            }
        }
        revert INVALID_DATA_PASSED();
    }
    function updateEmployeeData(address employeeAddress , Position role, string memory name)external{
        for(uint counter; counter< allEmployees.length; counter++){
            if(allEmployees[counter].employeeAddress == employeeAddress){
                allEmployees[counter].role= role;
                allEmployees[counter].name= name;
                employees[employeeAddress].role=role;
                employees[employeeAddress].name=name;
                return;
            }
        }
        revert INVALID_DATA_PASSED();
    }

    function canAccessGarage(address employeeAddress)external view returns (bool){
        for(uint counter; counter< allEmployees.length; counter++){
            if(allEmployees[counter].employeeAddress == employeeAddress){
                return allEmployees[counter].isEmployed &&
                    (allEmployees[counter].role == Position.MEDIA_TEAM || allEmployees[counter].role == Position.MENTOR || allEmployees[counter].role == Position.MANAGER);
            }
        }
        return false;
    }
    function getAllEmployees()external view returns(Employee[] memory){
        return allEmployees;
    }

    function getEmployeeByAddress(address employeeAddress) external view returns(Employee memory) {
        for(uint counter; counter< allEmployees.length; counter++){
            if(allEmployees[counter].employeeAddress == employeeAddress){
                return allEmployees[counter];
            }
        }
        revert INVALID_DATA_PASSED();
    }
}
