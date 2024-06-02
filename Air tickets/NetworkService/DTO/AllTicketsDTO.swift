
import Foundation

struct AllTicketsDTO: Decodable {
    let tickets: [Ticket]
}

struct Ticket: Decodable {
    let id: Int
    let badge: String
    
}
