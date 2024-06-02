
import Foundation

struct OffersDTO: Decodable {
    let offers: [OfferDTO]
}

struct OfferDTO: Decodable {
    let id: Int
    let title: String
    let town: String
    let price: PriceDTO

    struct PriceDTO: Decodable {
        let value: Int
    }
}
