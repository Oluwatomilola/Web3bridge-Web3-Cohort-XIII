# Mapping and Structs in Solidity

## Scenario

You are to build a smart contract system for managing access to the Web3Bridge garage using digital keycards.

---
### Submission Deadline

**11:00pm**

## Requirements

* Determine if an employee can access the Web3Bridge garage using their digital keycard.
* Employees that **can access** the building are:

  * Media Team
  * Mentors
  * Managers
* Other employees who **work at the company** (but do **not** have garage access) include:

  * Social Media Team
  * Technician Supervisors
  * Kitchen Staff
* **Terminated employees** must **never** be able to access the garage, regardless of their role.

## Contract Design Notes

* Use an `enum` to represent all types of employees.
* Use a `struct` to represent each employee. It should include:

  * `name` (string)
  * `role` should (enum type)
  * check if the person is still employed or not. 
* Use a `mapping(address => Employee)` to associate each employee with their wallet address.
* Also maintain an array of all employees that have ever been added to the system.
* Include the following functions:

  * A function to **add and update** an employee, storing them in both the mapping and the array.
  * A function to **check** if an employee can access the garage based on their role and employment status.
  * A function to **return the entire list of employees**.
  * A function to **get details of a specific employee** by address.

---
