# Solidity Visibility Specifiers  

## Overview  
Solidity has 4 visibility types for functions and variables:  
1.  public 
2.  external
3.  internal  
4.  private  

---

### 1. Public Visibility  
**For Variables & Functions**:   
- Accessible anywhere (inside contract, externally, by other contracts/wallets)   


### 2. Private Visibility  
**For Variables & Functions**:  
- Only accessible within the declaring contract  
- Not visible to derived contracts or external calls  
- Most restrictive visibility  


### 3. Internal Visibility  
**For Variables & Functions**:  
- Accessible within contract and  derived contracts (child contracts)  
- Like private but extends to inherited contracts


### 4. External Visibility  
**Only for functions** 
-cannot be used with variables
- cannot be called from inside the contract that declare them unless using this
- Inherited contracts cannot call external functions

