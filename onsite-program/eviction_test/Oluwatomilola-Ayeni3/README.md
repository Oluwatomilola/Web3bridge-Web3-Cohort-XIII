## README.md

````md
# Ludo Game – Solidity + Hardhat (TypeScript)

This is a minimal, pedagogical Ludo smart contract. Each player has a name, score, and unique color (RED/GREEN/BLUE/YELLOW). Max four players. Players must register before the game starts. Dice rolls determine movement, and moves are validated and applied. The first player to reach HOME scores and wins (simplified).

## Quickstart

```bash
npm i
npm run build
npm test
````

## Key Design Details

* **Custom errors & events** for clear, gas-efficient control flow and traceability.
* **Enums** for colors and game state.
* **Turn order** recorded at registration; first registrant starts.
* **Movement rules (simplified)**

  * Start from base (0). Roll a **6** to enter at **1**.
  * Normal moves add the roll; overshoot of HOME means no movement.
  * Rolling a **6** grants an extra turn.
  * Reaching **HOME (57)** increments score and (in this demo) resets the token to base.
  * First to **score = 1** wins.
* **Dice randomness**: uses `keccak256(block.prevrandao, timestamp, caller, nonce, clientSeed)`. This is **not secure** against manipulation/miner influence; it's used to keep the demo/test deterministic. For production, integrate a verifiable randomness source (e.g., Chainlink VRF v2.5) or a commit–reveal scheme.

## Production Randomness Options

* **Chainlink VRF** (recommended): request randomness and fulfill callback to set `lastRoll`. Requires oracle fees and callback wiring.
* **Commit–reveal**: players commit hashed seeds before rolling; later reveal to derive the random value. Avoids miner control but adds UX complexity.

## Extending This Demo

* Multiple tokens per player + capture/stacking logic.
* Full 52-track + home rows per color.
* Timeouts / auto-advance if a player stalls.
* Pausing / restarting games, or multiple concurrent game rooms.
* Spectator views and off-chain indexers for events.

```
```
