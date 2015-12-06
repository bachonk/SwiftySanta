//
//  SecretSanta.swift
//
//
//  Created by Tom Bachant on 12/5/15.
//
//

import Foundation

class Friend {
    var name: String
    var phone: String
    
    init(name: String, phone: String) {
        self.name   = name
        self.phone  = phone
    }
}

class Assignment {
    var santa: Friend
    var recipient: Friend
    
    init(santa: Friend, recipient: Friend) {
        self.santa      = santa
        self.recipient  = recipient
    }
}

// Add your list of all friends here
let friends = [
    Friend(name: "Tom",         phone: "2223334444"),
    Friend(name: "Calo",        phone: "3334445555"),
    Friend(name: "Danielle",    phone: "4445556666"),
    Friend(name: "Carolyn",     phone: "5556667777")
];

// Keep track of friends who haven't been selected yet
var availableFriends = [Friend](friends)

// Keep track of all santa/recipient matches
var matches = [Assignment]()

for santa in friends {
    var recipIndex = Int(arc4random_uniform(UInt32(availableFriends.count)))
    
    // Don't let a santa be assigned him or her self
    while availableFriends[recipIndex].phone == santa.phone {
        recipIndex = Int(arc4random_uniform(UInt32(availableFriends.count)))
    }
    
    // We'll need to prevent the case where the last recipient available is the last santa
    if availableFriends.count == 2 {
        let remainingIndex = recipIndex == 1 ? 0 : 1
        if availableFriends[remainingIndex].phone == friends.last!.phone {
            recipIndex = remainingIndex
        }
    }
    
    let recipient = availableFriends[recipIndex]
    
    matches.append(Assignment(santa: santa, recipient: availableFriends[recipIndex]))
    print("\(santa.name) (\(santa.phone)) will be giving a gift to \(recipient.name) (\(recipient.phone))")
    
    availableFriends.removeAtIndex(recipIndex)
}
