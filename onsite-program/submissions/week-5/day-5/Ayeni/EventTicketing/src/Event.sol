// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract EventTicketing is  {
    
    struct Event {
        string name;
        string date;
        string location;
        address organizer;
    }
        enum Name {item1, item2 }
    struct Ticket {
        uint256 id;
        uint256 price;
        string Status; "
        address owner;
    }

    //Event ticketing: 

    //event 
    //details (name, date, location), 

    //tickets_
    //  total number of tickets, number of tickets in order of status, tickets sold, tickets available, ticket price, ticket status (sold, available), //tickets selling and buying (require: addresses, prices, status/enums: silver, gold, premium )
    //payment:ERC20, ERC721
    // sell tickets, refund tickets, check ticket status,
    //tickets, function to update details and price of tickets, 
    //interface , address mapped to ticket. payment reflecting in balance of owner
    //destroying tickets after events, (burn function)


    //organizer details :
    //(name, contact, address)
    //balance of organizer b4 and after txs, 

    //attendee details 
    //(name, contact, address),
    //balance of organizer b4 and after txs, 
    //events details (name, date, location, organizer address, ticket price, total tickets, tickets sold, tickets available),
    //functions to buy tickets: -from buyers address, +sellers address, tickets means of  get event
    //details, get organizer details, get attendee details, update ticket price, update event details
    //and organizer details, events and tickets mapping, events and tickets arrays, event and ticket
    //structs, ticket status enums, events and tickets ownership, events and tickets transfer,
    //, events, organizers, and attendees 
    
    


}
