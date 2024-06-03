import Foundation

final class AllTicketsViewModel {
    @Observable
    var allTicketsModels: [AllTicketsTableViewCellModel] = []

    var fromTextFieldLastValue: String? {
        didSet {
            model.saveFromTextFieldLastValue(fromTextFieldLastValue)
        }
    }

    private let model: AllTicketsModel
    private let router: Router

    init(model: AllTicketsModel, router: Router) {
        self.model = model
        self.router = router
        fromTextFieldLastValue = model.loadCachedFromTextFieldLastValue()
    }

    func loadData() {
        model.loadAllTickets { result in
            DispatchQueue.main.async { [weak self] in
                guard let self else {
                    return
                }

                switch result {
                case let .success(models):
                    self.allTicketsModels = models.map(AllTicketsTableViewCellModel.init(ticketDTO:))
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
}

private extension AllTicketsTableViewCellModel {
    init(ticketDTO: TicketDTO) {
        badge = ticketDTO.badge ?? ""
        price = "\(ticketDTO.price.value)"
        let departure = ticketDTO.departure.date
        let arrival = ticketDTO.arrival.date
        departureTime = dateFormatter.string(from: departure)
        arrivalTime = dateFormatter.string(from: arrival)
        let hours = arrival.timeIntervalSince(departure) / 60 / 60
        flightTime = String(format: "%g", (floor(hours * 10) / 10).round(nearest: 0.5)) + "ч в пути"
        noTransfers = ticketDTO.has_transfer ? "" : "/Без пересадок"
        departureAirport = ticketDTO.departure.airport
        arrivalAirport = ticketDTO.arrival.airport
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .none
    formatter.timeStyle = .short
    return formatter
}()

extension Double {
    func round(nearest: Double) -> Double {
        let n = 1 / nearest
        let numberToRound = self * n
        return numberToRound.rounded() / n
    }
}
