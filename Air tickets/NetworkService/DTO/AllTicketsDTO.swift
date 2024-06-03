
import Foundation

struct AllTicketsDTO: Decodable {
    let tickets: [TicketDTO]
}

struct TicketDTO: Decodable {
    let id: Int
    let badge: String
    let price: PriceDTO
    let departure: DepartureDTO
    let arrival: ArrivalDTO
    let has_transfer: Bool

    struct PriceDTO: Decodable {
        let value: Int
    }

    struct DepartureDTO: Decodable {
        let date: String
        let airport: String
    }

    struct ArrivalDTO: Decodable {
        let date: String
        let airport: String
    }
}
