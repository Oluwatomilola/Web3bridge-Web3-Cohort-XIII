// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract PiggyBankSavings {
    enum LockDuration { ThreeMonths, SixMonths, TwelveMonths }

    address public immutable factory;
    address public immutable owner;
    string public name;
    uint256 public immutable unlockTime;
    LockDuration public lockPeriod;
    bool public isETH; // true for ETH, false for ERC20
    IERC20 public token; // ERC20 token address if isETH is false
    uint256 public balance;
    uint256 public constant BREAKING_FEE_PERCENTAGE = 3;
    uint256 public constant BREAKING_FEE_DIVISOR = 100;
    uint256 public constant MINIMUM_LOCK_AMOUNT = 0.01 ether;

    event Withdrawal(uint256 amount, uint256 when, bool penaltyApplied);

    constructor(
        address _owner,
        string memory _name,
        LockDuration _lockPeriod,
        bool _isETH,
        address _token
    ) {
        require(block.timestamp < getUnlockTime(_lockPeriod), "Unlock time must be in the future");
        factory = msg.sender;
        owner = _owner;
        name = _name;
        lockPeriod = _lockPeriod;
        unlockTime = getUnlockTime(_lockPeriod);
        isETH = _isETH;
        if (!_isETH) {
            token = IERC20(_token);
        }
    }

    function getUnlockTime(LockDuration _lockPeriod) private view returns (uint256) {
        if (_lockPeriod == LockDuration.ThreeMonths) {
            return block.timestamp + 90 days;
        } else if (_lockPeriod == LockDuration.SixMonths) {
            return block.timestamp + 180 days;
        } else {
            return block.timestamp + 360 days;
        }
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You aren't the owner");
        _;
    }

    function deposit(uint256 amount) external payable {
        if (isETH) {
            require(msg.value >= MINIMUM_LOCK_AMOUNT, "Deposit below minimum");
            balance += msg.value;
        } else {
            require(amount >= MINIMUM_LOCK_AMOUNT / 1e18, "Amount below minimum");
            require(token.transferFrom(msg.sender, address(this), amount), "Transfer failed");
            balance += amount;
        }
    }

    function withdraw(uint256 amount) external onlyOwner {
        require(amount <= balance, "Insufficient balance");
        balance -= amount;

        bool penaltyApplied = block.timestamp < unlockTime;
        uint256 penalty = penaltyApplied ? (amount * BREAKING_FEE_PERCENTAGE) / BREAKING_FEE_DIVISOR : 0;
        uint256 amountToSend = amount - penalty;

        if (penalty > 0) {
            if (isETH) {
                payable(factory).transfer(penalty);
            } else {
                token.transfer(factory, penalty);
            }
        }

        if (isETH) {
            payable(owner).transfer(amountToSend);
        } else {
            require(token.transfer(owner, amountToSend), "Transfer failed");
        }

        emit Withdrawal(amountToSend, block.timestamp, penaltyApplied);
    }

    function getBalance() external view returns (uint256) {
        return balance;
    }
}

contract PiggyBankFactory is Ownable {
    address public immutable admin;
    mapping(address => PiggyBankSavings[]) public userSavings;
    mapping(address => uint256) public savingsCount;

    event SavingsCreated(
        address indexed owner,
        address savingsContract,
        string name,
        PiggyBankSavings.LockDuration lockPeriod,
        bool isETH,
        address token
    );

    constructor() Ownable(msg.sender) {
        admin = msg.sender;
    }

    function createSavings(
        string memory name,
        PiggyBankSavings.LockDuration lockPeriod,
        bool isETH,
        address token
    ) external returns (address) {
        if (!isETH) {
            require(token != address(0), "Invalid token address");
        }

        PiggyBankSavings savings = new PiggyBankSavings(
            msg.sender,
            name,
            lockPeriod,
            isETH,
            token
        );

        userSavings[msg.sender].push(savings);
        savingsCount[msg.sender]++;

        emit SavingsCreated(
            msg.sender,
            address(savings),
            name,
            lockPeriod,
            isETH,
            token
        );

        return address(savings);
    }

    function getUserSavings(address user) external view returns (PiggyBankSavings[] memory) {
        return userSavings[user];
    }

    function getUserSavingsCount(address user) external view returns (uint256) {
        return savingsCount[user];
    }

    function getSavingsDetails(address savingsContract)
        external
        view
        returns (
            address owner,
            string memory name,
            uint256 unlockTime,
            PiggyBankSavings.LockDuration lockPeriod,
            bool isETH,
            address token,
            uint256 balance
        )
    {
        PiggyBankSavings savings = PiggyBankSavings(savingsContract);
        return (
            savings.owner(),
            savings.name(),
            savings.unlockTime(),
            savings.lockPeriod(),
            savings.isETH(),
            address(savings.token()),
            savings.getBalance()
        );
    }

    receive() external payable {}
}