// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract EtherContract {
    address principal;

    constructor() {
        principal == msg.sender };

    fallback() external payable { }

    mapping (address => uint) balances;

    function get_balance external view virtual returns uint256(
        address(this).balance
    )

    function transfer (address payable _to, uint256) external {
    
        if (principal != msg.sender) {
            revert(); NOT PRINCIPAL
     }
        _to.transfer(_amount);
    } 


}

interface IEtherContract {
    function transfer (address payable _to, uint256) external;
    
}

contract SchoolManagement is E {

    enum Status {
       EMPLOYED,
       UNEMPLOYED,
       PROBATION
    }

    struct TeacherData {
        address teacherAddress;
        string name;   
        Status status;

    }

    mapping (address => TeacherData) teacherData;
    address[] teacher_data;

    error INVALID_ROLE();

    function registerTeacher(address _teacherAddress, string memory _name ) external {
        require(bytes(teacherData[_teacherAddress].name).length == 0, "Teacher already exist");
        Data[_teacherAddress] = teacherData(_teacherAddress, _name, Status.member);
        teacher_data.push(_teacherAddress);
    }

    function getteacherData(address _teacherAddress) external view returns (TeacherData memory) {
        return teacherData[_teacherAddress];
    }

    

    function paySalary(address _teacherAddress) external view returns (uint) {
        TeacherData memory tea = teacherData[_teacherAddress];

        if (teach.status != Status.member) {
            return ;
        }
    }
}