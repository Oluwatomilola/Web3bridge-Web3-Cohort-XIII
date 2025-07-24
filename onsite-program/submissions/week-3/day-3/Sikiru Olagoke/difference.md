| **Visibility Specifier** | **Applies To**       | **Description**                                                                                                                                                     | **Access Scope**                                                        |
| ------------------------ | -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------- |
| **`public`**             | Variables, Functions | Automatically generates a getter function for variables. Accessible from everywhere (inside the contract, derived contracts, external calls).                       | Inside contract, derived contracts, external accounts, other contracts. |
| **`private`**            | Variables, Functions | Only accessible within the contract where defined. Not accessible in derived contracts or externally.                                                               | Only inside the defining contract.                                      |
| **`internal`**           | Variables, Functions | Accessible within the contract and its derived contracts. Not accessible externally.                                                                                | Inside the contract and derived contracts.                              |
| **`external`**           | Functions only       | Only accessible via external calls (e.g., through transactions or by other contracts). Not callable directly within the contract or derived contracts using `this`. | External accounts, other contracts (via contract address).              |

### Notes:

- **Variables**:
- Cannot be `external`.
- Default visibility is `internal` if not specified.
- `public` variables automatically get a getter function, making their values readable externally.
- **Functions**:
  - Default visibility is `public` if not specified (pre-Solidity 0.5.0; now must be explicit).
  - `external` functions are optimized for external calls and cannot be called internally using `this`.
