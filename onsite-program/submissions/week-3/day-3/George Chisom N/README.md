# Beginners Guide on Solidity Visibility Specifiers

The evolution of web3 have help our generation in many diverse ways. This web3 help us to own our work and give us more access. it involve smart contracts which are written in solidity and other languages. 

Solidity is a programming language that helps us build smart contracts, it enables us to interact with the Ethereum virtual machine and many others layer 2. To fully understand Solidity we would look at its visible specifiers.

This guide explains visibility specifiers in Solidity, which control who can access variables and functions in a smart contract.

# Overview

Visibility Specifiers determine who we can see and interact with, inside a smart contracts. It involves the variables and functions which set a simple way about where and how different parts of the smart contract can be accessed or used. Think of them as defining the boundaries or borders of your smart contract’s data and actions, making sure that only the right people or other parts of the contract can access or change certain information. This helps keep your contract secure and organized, so it works exactly as intended.

Visibility specifiers define how data (variables) and actions (functions) in a smart contract can be accessed. There are four types which are Public, Private, Internal, and External.

# Visibility Types

1.	Public: It is open to everyone, even external users, other contracts, and the contract itself can access and use it. Like a water borne hole in a community, anyone can read public variables or call public functions.

2.	Private: It is personalized, only the contract itself can access. Like a locked safe to keep your items when entering a bank, private variables and functions are hidden from external users and inherited contracts.

3.	Internal: Accessible by the contract and its children (inherited contracts). Like a family room, only the contract and its derived contracts can use internal variables or functions.

4.	External: Only for functions, accessible only by external users or contracts. Like a hotel front desk, external functions can’t be called by the contract itself.

# Importance Points to Note

•	Variables: Can be public, private, or internal (not external).

•	Functions: Can use all four specifiers.

•	Security: Use private or internal for sensitive data or logic. 
kindly Note: Information on the blockchain data is public at a low level, so it don’t store secrets without encryption.

•	Inheritance: Use internal to share with child contracts.

•	Gas Optimization: external functions can save gas for external calls.

# Real Used Practices to help Beginners

When working with visibility specifiers in Solidity, think of your smart contract as a house where you decide who gets access to each room.

•	Start with private or internal for better security: By default, make variables and functions private or internal to limit who can access them. This is like keeping most rooms in your house locked to protect your belongings. Only open up access when you are sure it’s needed. For example, keep sensitive data like user balances or internal calculations private to prevent unauthorized access.

•	Use public sparingly, only when external access is necessary: Think of public as putting a signboard outside your house that anyone can read or interact with. Use it for things like a token’s total supply or a function that lets users check their account details. Avoid making everything public, as it can expose your contract to unintended interactions or attacks.

•	Choose external for functions designed for outsiders: If a function is meant to be an entry point for users or other contracts, like depositing funds into a bank, the contract will mark it as external. This is like having a front desk that only serves visitors, not family members inside the house. It also saves gas (transaction costs) for external calls, making your contract more efficient.

•	Always specify visibility explicitly: Don’t over rely on the programming Solidity default settings, as they can lead to mistakes. For example, older versions of Solidity made functions public by default, which could accidentally expose them. Always declare whether a variable or function is public, private, internal, or external to make your intentions clear and avoid surprises.

•	Plan for inheritance with internal: If you’re building contracts that inherit from each other (like a base contract for a bank and child contracts for savings accounts), use internal for variables and functions you want to share with those child contracts. This is like sharing a family recipe with your kids but not with strangers.

This readMe is to help beginners in the web3 space to have bed rock knowledge about visibity specifiers and what it contains. Although there are others involve that are not mentioned here.