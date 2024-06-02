import Foundation

final class FirstEntryModel {
    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func loadOffers(completion: @escaping (Result<[OfferDTO], Error>) -> Void) {
        networkService.fetchOffers { result in
            switch result {
            case let .failure(error):
                completion(.failure(error))
            case let .success(offersDTO):
                completion(.success(offersDTO.offers))
            }
        }
    }

    func saveFromTextFieldLastValue(_ value: String?) {
        UserDefaultsManager.setString(value, key: .fromTextFieldLastValue)
    }

    func loadCachedFromTextFieldLastValue() -> String? {
        UserDefaultsManager.getString(key: .fromTextFieldLastValue)
    }
}
