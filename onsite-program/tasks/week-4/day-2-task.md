# School Management System – Student Status Tracking

## Assignment

The assignment is a basic **School Management System** designed to help you practice working with enums, structs, and functions in Solidity. The main objective is to manage student records and track their status using an enum.

### Objectives

- Understand and implement **enums** in Solidity
- Create and manage **student records** using structs
- Perform basic operations: **Create**, **Read**, **Update**, **Delete** (CRUD)
- Build a simple, non-mapping-based contract architecture

It's called learning objective, ensure you understand whatever it is you are doing. Don't just dub peoples code. Enjoy!

---

## Functional Requirements

You are required to implement the following functionality:

### 1. **Student Registration**

- Register a new student with basic details (e.g., name, age, etc.)
- Each student must be assigned a **unique ID**

### 2. **Update Student Details**

- Allow updating student information (e.g., name or age, or both)

### 3. **Delete Student**

- Provide functionality to remove a student from the system

### 4. **Student Status Management**

- Use an `enum` to define and manage student status:

  ```solidity
  enum Status { ACTIVE, DEFERRED, RUSTICATED }
  ```

- Allow changing a student’s status at any time

### 5. **View Student Data**

- Get the details of a **single student** by their ID
- Get a list of **all registered students**

---

## Constraints

- **Do NOT use `mapping`** for this assignment

## Additional Notes

- Focus on clarity and correct use of enums and arrays
- Do not worry about optimization or gas usage for now
- Think carefully about how you’ll generate and assign unique IDs

---

## Submission

To be submitted by 4am no stories, enjoy!
