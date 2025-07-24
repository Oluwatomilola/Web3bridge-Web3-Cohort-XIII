# Understanding Visibility in Solidity, an Assignment from Ms. Kemi

When you're writing smart contracts, one of the quiet but powerful tools Solidity gives you is *visibility specifiers*. They are the ones that decide who gets access to your variables and functions. You might think it's just "syntax" added to code randomnly, but it can actually break your contract or expose data you didn't mean to if not handled carefully. So, let's break it down .

---

## What Visibility Is All About

Visibility controls **who** can use a variable or function and from **where**. Think of it like door locks in a building:

- `public` — Everyone gets in.
- `external` — Outsiders only.
- `internal` — Family and close friends.
- `private` — Just you.

---

# Explanation in terms of Solidity Functions and Varaibles

### 1. `public`
You can call it **from anywhere** — within the contract, other contracts, your frontend UI, scripts, etc.  
Solidity even creates a free getter function for public variables.

> It is used for functions you *want people to interact with* (like deposit, withdraw, mint and the likes).

---

### 2. `external`
Only outsiders can call it. You can’t use it from inside the contract like a regular functions, you’d have to do `this.myFunction()` which is absurd and expensive.

> It is used if a function is *only meant for external users*, and not for internal logic.

---

### 3. `internal`
Used **inside this contract or any child contract** that inherits from it. This is perfect for reusable logic you don't want  to expose to the pubic.

> It is used when building modular contracts or extending logic without making it public.

---

### 4. `private`
Only available in this contract. Not even child contracts can access it.

> It is used when something is *strictly meant to stay hidden*, like internal calculations or secret flags.

---
**Note:** 

Functions posses 4 visibiity types which are: Public, External, Internal and Private

Variables posses 3 visibility types which are : Public, Internal and Private

> The key difference between `internal` and `private` is that `internal` members can be inherited by child contracts, while `private` ones cannot.

---

Here’s how visibility affects variables:

| Visibility | Readable from outside? | Inherited? | Has automatic getter? |
|------------|------------------------|------------|------------------------|
| `public`   | ✅ Yes                 | ✅ Yes     | ✅ Yes                 |
| `internal` | ❌ No                  | ✅ Yes     | ❌ No                  |
| `private`  | ❌ No                  | ❌ No      | ❌ No                  |


---
 
Let’s say for examle you’re building a token:

- You want `mint()` to be public — so users or other contracts can mint.
- You have a helper `_calculateRewards()` — mark it internal.
- You store `_owner` as private — only the contract itself should use it.
- You use `external` for `buyToken()` that is never called internally.

---

## Imprortance of visibility

Getting visibility wrong could lead to:
- Someone accesses your private logic.
- Child contracts fail because a function is private.

## Author

### Bilal Oyeleke Soliu

