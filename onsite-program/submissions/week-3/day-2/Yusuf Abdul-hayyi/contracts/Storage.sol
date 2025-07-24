// SPDX-License-Identifier: MIT

pragma solidity 0.8.28;

contract Storage {
    uint256 myFavoriteNumber;

    //uint[] listOfFavoriteNumbers;

    struct Person {
        uint256 favoriteNumber;
        string name;
    }

    mapping (string => uint256) public nameToFavoriteNumber;
    // Person public kator = Person({favoriteNumber: 7, name: "Kator"});
    // Person public victor = Person({favoriteNumber: 12, name: "Victor"});
    // Person public yusuf = Person({favoriteNumber: 23, name: "Yusuf"});

    // a dynamic array 
    Person[] public listOfPeople; // [] is an empty array

    // a static array
    //Person[2] public listOfPeople1;

    function store (uint256 _favoriteNumber) public virtual  {
        myFavoriteNumber = _favoriteNumber;
    }

    function retrieve () public view returns (uint256) {
        return myFavoriteNumber;
    }

    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        //Person memory newPerson = Person (_favoriteNumber, _name);
        //listOfPeople.push(newPerson);
        listOfPeople.push( Person (_favoriteNumber, _name) );
        // adding the key to favoriteNumber
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}
//well
