
import Foundation

struct AllTicketsDTO: Decodable {
    let tickets: [TicketDTO]
}

struct TicketDTO: Decodable {
    let id: Int
    let badge: String?
    let price: PriceDTO
    let departure: DepartureDTO
    let arrival: ArrivalDTO
    let has_transfer: Bool

    struct PriceDTO: Decodable {
        let value: Int
    }

    struct DepartureDTO: Decodable {
        let date: Date
        let airport: String

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let dateString = try container.decode(String.self, forKey: .date)
            date = try Date(dateString + "Z", strategy: .iso8601)
            airport = try container.decode(String.self, forKey: .airport)
        }

        private enum CodingKeys: String, CodingKey {
            case date
            case airport
        }
    }

    struct ArrivalDTO: Decodable {
        let date: Date
        let airport: String

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let dateString = try container.decode(String.self, forKey: .date)
            date = try Date(dateString + "Z", strategy: .iso8601)
            airport = try container.decode(String.self, forKey: .airport)
        }

        private enum CodingKeys: String, CodingKey {
            case date
            case airport
        }
    }
}

extension TicketDTO {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        badge = try container.decodeIfPresent(String.self, forKey: .badge)
        price = try container.decode(PriceDTO.self, forKey: .price)
        departure = try container.decode(DepartureDTO.self, forKey: .departure)
        arrival = try container.decode(ArrivalDTO.self, forKey: .arrival)
        has_transfer = try container.decode(Bool.self, forKey: .has_transfer)
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case badge
        case price
        case departure
        case arrival
        case has_transfer
    }
}
