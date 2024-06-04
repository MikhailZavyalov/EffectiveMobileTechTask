import Foundation

final class TicketsOffersModel {
    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func loadTicketsOffers(completion: @escaping (Result<[TicketsOfferDTO], Error>) -> Void) {
        networkService.fetchTicketsOffers { result in
            switch result {
            case let .failure(error):
                completion(.failure(error))
            case let .success(ticketsOffersDTO):
                completion(.success(ticketsOffersDTO.tickets_offers))
            }
        }
    }
}

