import { expect } from "chai";
import { ethers } from "hardhat";

// Ethers v6-style tests

describe("Ludo", function () {
  async function deploy() {
    const [a, b, c, d, e] = await ethers.getSigners();
    const Ludo = await ethers.getContractFactory("Ludo");
    const ludo = await Ludo.deploy();
    await ludo.waitForDeployment();
    return { ludo, a, b, c, d, e };
  }

  it("registers players with unique colors and starts", async () => {
    const { ludo, a, b } = await deploy();

    await expect(ludo.connect(a).registerPlayer("Alice", 0)).to.emit(ludo, "PlayerRegistered");
    await expect(ludo.connect(b).registerPlayer("Bob", 1)).to.emit(ludo, "PlayerRegistered");

    await expect(ludo.startGame()).to.emit(ludo, "GameStarted");

    const current = await ludo.currentPlayer();
    expect(current).to.equal(a.address);
  });

  it("enforces color uniqueness and max players", async () => {
    const { ludo, a, b, c, d, e } = await deploy();

    await ludo.connect(a).registerPlayer("Alice", 0);
    await ludo.connect(b).registerPlayer("Bob", 1);
    await ludo.connect(c).registerPlayer("Carol", 2);
    await ludo.connect(d).registerPlayer("Dan", 3);

    await expect(ludo.connect(e).registerPlayer("Eve", 0)).to.be.revertedWithCustomError(ludo, "MaxPlayersReached");
  });

  it("requires rolling before moving and handles base exit on 6", async () => {
    const { ludo, a, b } = await deploy();

    await ludo.connect(a).registerPlayer("Alice", 0);
    await ludo.connect(b).registerPlayer("Bob", 1);
    await ludo.startGame();

    await expect(ludo.connect(a).moveToken()).to.be.revertedWithCustomError(ludo, "MustRollFirst");

    // Force a non-deterministic roll by giving a seed; we repeat until we hit a 6.
    // In practice, for tests we iterate seeds and try.
    let seed = 1n;
    let rolledSix = false;
    for (let i = 0; i < 30 && !rolledSix; i++) {
      const tx = await ludo.connect(a).rollDice(seed);
      await tx.wait();
      const last = await ludo.lastRoll();
      if (last === 6) {
        rolledSix = true;
        await expect(ludo.connect(a).moveToken()).to.emit(ludo, "Moved");
        const p = await ludo.players(a.address);
        expect(p.position).to.equal(1); // START_ENTRY
      } else {
        // Move attempt should consume turn with no movement (still at base)
        await ludo.connect(a).moveToken();
      }
      seed++;
    }
    expect(rolledSix).to.equal(true);
  });

  it("advances, scores at HOME, and ends game when score threshold met", async () => {
    const { ludo, a, b } = await deploy();

    await ludo.connect(a).registerPlayer("Alice", 0);
    await ludo.connect(b).registerPlayer("Bob", 1);
    await ludo.startGame();

    // Make Alice roll 6 to enter
    let seed = 1n;
    while (true) {
      await (await ludo.connect(a).rollDice(seed)).wait();
      if ((await ludo.lastRoll()) === 6) {
        await (await ludo.connect(a).moveToken()).wait();
        break;
      } else {
        await (await ludo.connect(a).moveToken()).wait();
      }
      seed++;
    }

    // Fast-forward Alice to HOME by repeatedly rolling 6 (extra turns) and then exact moves.
    // NOTE: This is a simplification to keep the test bounded; we loop until finished.
    for (let i = 0; i < 200; i++) {
      if ((await ludo.state()) === 2 /* Finished */) break;
      await (await ludo.connect(a).rollDice(seed)).wait();
      await (await ludo.connect(a).moveToken()).wait();
      seed++;
    }

    expect(await ludo.state()).to.equal(2); // Finished
    const aPlayer = await ludo.players(a.address);
    expect(aPlayer.score).to.equal(1);
  });
});
```

---

## hardhat.config.ts

```ts
import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const config: HardhatUserConfig = {
  solidity: {
    version: "0.8.24",
    settings: {
      optimizer: { enabled: true, runs: 200 },
      viaIR: false,
    },
  },
  paths: {
    sources: "./contracts",
    tests: "./test",
    cache: "./cache",
    artifacts: "./artifacts",
  },
  mocha: { timeout: 120_000 },
};

export default config;
```

---

## package.json

```json
{
  "name": "ludo-solidity",
  "version": "1.0.0",
  "private": true,
  "scripts": {
    "build": "hardhat compile",
    "test": "hardhat test"
  },
  "devDependencies": {
    "@nomicfoundation/hardhat-toolbox": "^5.0.0",
    "hardhat": "^2.22.6",
    "typescript": "^5.6.2"
  }
}
```

---

## tsconfig.json

```json
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "commonjs",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "types": ["node", "mocha"]
  }