import Foundation

final class AllTicketsModel {
    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func loadAllTickets(completion: @escaping (Result<[TicketDTO], Error>) -> Void) {
        networkService.fetchTickets { result in
            switch result {
            case let .failure(error):
                completion(.failure(error))
            case let .success(allTicketsDTO):
                completion(.success(allTicketsDTO.tickets))
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
