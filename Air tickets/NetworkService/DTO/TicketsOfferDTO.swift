
import Foundation

struct TicketsOffersDTO: Decodable {
    let tickets_offers: [TicketsOfferDTO]
}

struct TicketsOfferDTO: Decodable {
    let id: Int
    let title: String
    let time_range: [String]
    let price: PriceDTO

    struct PriceDTO: Decodable {
        let value: Int
    }
}
