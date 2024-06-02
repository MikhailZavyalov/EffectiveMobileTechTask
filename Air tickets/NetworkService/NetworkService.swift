import Foundation

protocol NetworkService {
    func fetchOffers(completion: @escaping (Result<OffersDTO, Error>) -> Void)
    func fetchTicketsOffers(completion: @escaping (Result<TicketsOffersDTO, Error>) -> Void)
//    func fetchTickets(completion: @escaping (Result<TicketDTO, Error>) -> Void)
}

final class NetworkServiceImplementation: NetworkService {
    static let offersURL = URL(string: "https://run.mocky.io/v3/214a1713-bac0-4853-907c-a1dfc3cd05fd")
    static let ticketsOffersURL = URL(string: "https://run.mocky.io/v3/7e55bf02-89ff-4847-9eb7-7d83ef884017")

    enum NetworkError: Error {
        case httpError(Int)
        case noDataReceived
    }

    func fetchOffers(completion: @escaping (Result<OffersDTO, Error>) -> Void) {
        guard let offersURL = NetworkServiceImplementation.offersURL else { return }
        fetchData(url: offersURL, completion: completion)
    }

    func fetchTicketsOffers(completion: @escaping (Result<TicketsOffersDTO, Error>) -> Void) {
        guard let ticketsOffersURL = NetworkServiceImplementation.ticketsOffersURL else { return }
        fetchData(url: ticketsOffersURL, completion: completion)
    }
//
//    func fetchTickets(completion: @escaping (Result<TicketDTO, Error>) -> Void) {
//
//    }

    private func fetchData<DTO: Decodable>(url: URL, completion: @escaping (Result<DTO, Error>) -> Void) {
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                return completion(.failure(error))
            }

            if let httpResponse = response as? HTTPURLResponse,
                !(200..<300).contains(httpResponse.statusCode) {
                return completion(.failure(NetworkError.httpError(httpResponse.statusCode)))
            }
            
            guard let data else {
                return completion(.failure(NetworkError.noDataReceived))
            }

            do {
                let dto = try JSONDecoder().decode(DTO.self, from: data)
                completion(.success(dto))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
