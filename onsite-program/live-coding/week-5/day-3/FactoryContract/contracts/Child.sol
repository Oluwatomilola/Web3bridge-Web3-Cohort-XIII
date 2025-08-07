// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract Child {
    address owner;

    struct Details {
        string name;
        uint256 age;
    }

    Details[] details;

    constructor(address _owner) {
        owner = _owner;
    }

    function create_new_detail(string memory _name, uint256 _age) external {
        Details memory new_details = Details(_name, _age);

        details.push(new_details);
    }
}
