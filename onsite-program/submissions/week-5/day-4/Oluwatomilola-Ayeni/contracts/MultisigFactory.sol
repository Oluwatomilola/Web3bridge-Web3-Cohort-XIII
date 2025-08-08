//SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.26;

import "./Multisig.sol";


contract MultisigFactory {
 

    address[] public deployedMultisigs;

    function createMultisig(address[5] memory owners) external returns (address) {
        for (uint i = 0; i < owners.length; i++) {
            require(owners[i] != address(0), "Owner address cannot be zero");
            
            for (uint j = i + 1; j < owners.length; j++) {
                require(owners[i] != owners[j], "Duplicate owner address");
            }
        }

        Multisig newMultisig = new Multisig(owners);
        address multisigAddress = address(newMultisig);
        
        deployedMultisigs.push(multisigAddress);
        
        
        return multisigAddress;
    }

    function getDeployedMultisigs() external view returns (address[] memory) {
        return deployedMultisigs;
    }

    function getDeployedMultisigsCount() external view returns (uint256) {
        return deployedMultisigs.length;
    }
}