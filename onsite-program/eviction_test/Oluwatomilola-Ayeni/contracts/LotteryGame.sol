
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract LotteryGame {
    using Counters for Counters.Counter;
    using SafeMath for uint256;

    Counters.Counter private _participantCount;
    address payable[] private _participants;
    address payable public winner;
    uint256 public constant ENTRY_FEE = 0.01 ether;

    event ParticipantJoined(address indexed participant);
    event WinnerChosen(address indexed winner, uint256 amount);

    modifier onlyWhenTenParticipants() {
        require(_participantCount.current() == 10, "Already 10 participants");
        _;
    }

     function joinLottery() public payable {
        require(msg.value == ENTRY_FEE, "Entry fee must be 0.01 ETH");
        require(!isParticipantInCurrentRound(msg.sender), "wait for next round");

        _participants.push(payable(msg.sender));
        _participantCount.increment();
        emit ParticipantJoined(msg.sender);

        if (_participantCount.current() == 10) {
            chooseWinner();
        }
    }

    function chooseWinner() private onlyWhenTenParticipants() {
        uint256 winnerIndex = _getRandomNumber() % 10;
        winner = _participants[winnerIndex];
        uint256 prizePool = address(this).balance;
        winner.transfer(prizePool);
        emit WinnerChosen(winner, prizePool);
        _resetLottery();
    }

    function _getRandomNumber() private view returns (uint256) {
        return uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty, _participants)));
    }

    function _resetLottery() private {
        delete _players;
        _playerCount.reset();
    }

    function isPlayerInCurrentRound(address player) private view returns (bool) {
        for (uint256 i = 0; i < _players.length; i++) {
            if (_players[i] == player) {
                return true;
            }
        }
        return false;
    }
}