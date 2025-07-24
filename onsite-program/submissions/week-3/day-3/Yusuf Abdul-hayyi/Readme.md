Function and Variable Visibility Specifiers in Solidity

Function or variable visibility in Solidity defines the visibility of the function or variable to other functions within the contract, or in other contracts. This is usually specified by the smart contract developer as this is crucial for security, gas optimization, and proper contract design.

Functions visibility modifiers and their usability
Function visibility has 4 visibility specifiers, which are public, private, internal and external. The default visibility Specifier for functions is public in Solidity.

1. Public 
If a function’s visibility specifier is made public, it can be called both internally (from within the same contract) and externally (by other contracts or users). 

contract PublicExample {
    uint public value;  // Auto-generated getter function

    // Public function: can be called internally and externally
    function setValue(uint _value) public {
        value = _value;
    }
}

2. Private 
If a function’s visibility specifier is private, it can only be called within the same contract where it is defined. Neither external contracts nor derived (inherited) contracts can call or access a private function.

contract PrivateExample {
    uint private secret;

    // Private function: can only be called inside this contract
    function setSecret(uint _secret) private {
        secret = _secret;
    }


3. Internal 
When a function is marked as internal, it can be accessed within the same contract and by any contract that inherits from it. It is similar to private, but with the added capability of being accessible by derived contracts. The default visibility Specifier for the State variable is internal in Solidity.

contract InternalExample {
    uint internal data;

    // Internal function: can be called in this contract or derived contracts
    function setData(uint _data) internal {
        data = _data;
    }

4. External 
If a function is marked as external, it can be called only by external contracts or accounts (EOAs). The current contract cannot call this function directly by name. However, it can still call it internally using this.functionName(), but this is treated as an external call and costs more gas.

contract ExternalExample {
    uint public value;

    // External function: can be called by external contracts or users
    function setValue(uint _val) external {
        value = _val;
    }

Variable visibility specifiers and their usability

Variable visibility specifiers are just 3 unlike the function specifiers, they are public, private, and internal.

1. Public 
A state variable declared as public can be read by all contracts and external accounts. Solidity automatically creates a getter function for every public state variable.

contract PublicVariableExample {
    uint public value = 10;  // Auto-generated getter function

    function setValue(uint _val) public {
        value = _val;  // Anyone can modify via this function
    }
}

2. Private 
A state variable declared as private can only be accessed and modified within the same contract where it is defined. Neither external contracts nor derived (inherited) contracts can access a private variable directly.

contract PrivateVariableExample {
    uint private secret = 42;  // Accessible only in this contract

    function getSecret() public view returns (uint) {
        return secret;  // Controlled access via public function
    }
3. Internal 
A state variable declared as internal can be accessed and modified within the same contract and by any contract that inherits from it. It cannot be accessed directly by external contracts or users.

contract InternalVariableExample {
    uint internal data = 100;  // Accessible here and in child contracts

    function setData(uint _data) public {
        data = _data;
    }

