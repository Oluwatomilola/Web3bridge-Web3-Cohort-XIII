
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/// @title Ludo Game (single-token-per-player)
/// @notice Demo implementation with up to 4 registered players, turn order,
///         pseudo-random dice, and basic move rules. Not for mainnet production.
contract Ludo {
    // ===== Types =====
    enum Color { RED, GREEN, BLUE, YELLOW }
    enum GameState { Waiting, InProgress, Finished }

    struct Player {
        address addr;
        string name;
        uint8 score;        // increments when reaching HOME
        Color color;
        uint8 position;     // 0 = base; 1..57 path; 57 = HOME
        bool inGame;
    }

    // ===== Constants =====
    uint8 public constant MAX_PLAYERS = 4;
    uint8 public constant HOME = 57;      // finish square
    uint8 public constant START_ENTRY = 1; // first square when leaving base on a 6
    uint8 public constant WIN_SCORE = 1;  // first to finish once wins (simplified)

    // ===== Storage =====
    GameState public state = GameState.Waiting;
    address[] public turnOrder;               // order of player addresses
    uint256 public currentTurn;               // index into turnOrder

    mapping(address => Player) public players; // address => Player
    mapping(Color => bool) public colorTaken;  // ensure unique color

    // last dice result for the player whose turn it is
    uint8 public lastRoll;                    // 0 = none / consumed
    uint256 private rollNonce;                // mixes into pseudo-randomness

    // ===== Custom Errors =====
    error NameEmpty();
    error AlreadyRegistered();
    error ColorTakenErr();
    error MaxPlayersReached();
    error GameAlreadyStarted();
    error NotInGame();
    error NotYourTurn();
    error GameNotStarted();
    error GameFinished();
    error MustRollFirst();

    // ===== Events =====
    event PlayerRegistered(address indexed player, string name, Color color);
    event GameStarted(address[] turnOrder);
    event DiceRolled(address indexed player, uint8 value);
    event Moved(address indexed player, uint8 fromPos, uint8 toPos, uint8 roll);
    event TurnAdvanced(address indexed nextPlayer);
    event PlayerScored(address indexed player, uint8 newScore);
    event GameEnded(address indexed winner);

    // ===== Modifiers =====
    modifier onlyInGame() {
        if (!players[msg.sender].inGame) revert NotInGame();
        _;
    }

    modifier onlyTurn() {
        if (turnOrder.length == 0) revert GameNotStarted();
        if (turnOrder[currentTurn] != msg.sender) revert NotYourTurn();
        _;
    }

    // ===== Registration & Lifecycle =====
    function registerPlayer(string calldata name, Color color) external {
        if (state != GameState.Waiting) revert GameAlreadyStarted();
        if (bytes(name).length == 0) revert NameEmpty();
        if (players[msg.sender].inGame) revert AlreadyRegistered();
        if (colorTaken[color]) revert ColorTakenErr();
        if (turnOrder.length >= MAX_PLAYERS) revert MaxPlayersReached();

        players[msg.sender] = Player({
            addr: msg.sender,
            name: name,
            score: 0,
            color: color,
            position: 0,
            inGame: true
        });
        colorTaken[color] = true;
        turnOrder.push(msg.sender);

        emit PlayerRegistered(msg.sender, name, color);
    }

    function startGame() external {
        if (state != GameState.Waiting) revert GameAlreadyStarted();
        require(turnOrder.length >= 2, "Need at least 2 players");
        state = GameState.InProgress;
        currentTurn = 0; // start from first registered
        emit GameStarted(turnOrder);
        emit TurnAdvanced(turnOrder[currentTurn]);
    }

    // ===== Dice (demo) =====
    /// @notice Rolls the dice for the current player. Pseudo-random and predictable on-chain.
    /// @dev Mixes in a caller-supplied seed to make testing deterministic. Not secure.
    function rollDice(uint256 clientSeed) external onlyInGame onlyTurn {
        if (state != GameState.InProgress) revert GameNotStarted();
        // Very weak randomness – for demo/testing only.
        unchecked {
            rollNonce++;
        }
        uint256 rand = uint256(
            keccak256(
                abi.encodePacked(block.prevrandao, block.timestamp, msg.sender, rollNonce, clientSeed)
            )
        );
        uint8 value = uint8((rand % 6) + 1);
        lastRoll = value;
        emit DiceRolled(msg.sender, value);
    }

    // ===== Movement =====
    /// @notice Consumes lastRoll and applies the move for the current player.
    /// Rules (simplified Ludo, single token):
    /// - Token starts in base (position=0). A roll of 6 is required to enter at position=1.
    /// - Normal advancement adds the roll to position.
    /// - If move would overshoot HOME, the token does not move (turn still consumed).
    /// - Rolling a 6 grants an extra turn (currentTurn does not advance).
    function moveToken() external onlyInGame onlyTurn {
        if (state != GameState.InProgress) revert GameNotStarted();
        uint8 roll = lastRoll;
        if (roll == 0) revert MustRollFirst();

        Player storage p = players[msg.sender];
        uint8 fromPos = p.position;
        uint8 toPos = fromPos;

        if (fromPos == 0) {
            // Leaving base requires a 6
            if (roll == 6) {
                toPos = START_ENTRY; // enter track
            } else {
                // cannot move; consume turn
                _consumeRollAndAdvanceTurn(roll, fromPos, toPos, /*extraTurn*/ false);
                return;
            }
        } else {
            // Regular movement; prevent overshoot
            uint16 maybe = uint16(fromPos) + uint16(roll); // avoid overflow in theory
            if (maybe == HOME) {
                toPos = HOME;
            } else if (maybe < HOME) {
                toPos = uint8(maybe);
            } else {
                // overshoot: stay in place, consume turn
                _consumeRollAndAdvanceTurn(roll, fromPos, toPos, /*extraTurn*/ false);
                return;
            }
        }

        // Apply move
        p.position = toPos;
        emit Moved(msg.sender, fromPos, toPos, roll);

        // Scoring & win condition
        if (toPos == HOME) {
            p.score += 1;
            emit PlayerScored(msg.sender, p.score);
            // Reset token to base for this simplified variant
            p.position = 0;
            if (p.score >= WIN_SCORE) {
                state = GameState.Finished;
                emit GameEnded(msg.sender);
                // lastRoll is considered consumed
                lastRoll = 0;
                return;
            }
        }

        bool extraTurn = (roll == 6);
        _consumeRollAndAdvanceTurn(roll, fromPos, p.position, extraTurn);
    }

    // ===== View Helpers =====
    function currentPlayer() public view returns (address) {
        if (state == GameState.Waiting || turnOrder.length == 0) return address(0);
        return turnOrder[currentTurn];
    }

    function getPlayers() external view returns (Player[] memory list) {
        list = new Player[](turnOrder.length);
        for (uint256 i = 0; i < turnOrder.length; i++) {
            list[i] = players[turnOrder[i]];
        }
    }

    // ===== Internal =====
    function _consumeRollAndAdvanceTurn(
        uint8 roll,
        uint8 fromPos,
        uint8 toPos,
        bool extraTurn
    ) internal {
        lastRoll = 0; // consume roll
        if (!extraTurn) {
            currentTurn = (currentTurn + 1) % turnOrder.length;
        }
        emit Moved(msg.sender, fromPos, toPos, roll);
        emit TurnAdvanced(turnOrder[currentTurn]);
    }
}

