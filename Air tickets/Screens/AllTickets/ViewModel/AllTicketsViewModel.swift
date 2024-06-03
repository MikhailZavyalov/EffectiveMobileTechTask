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
        badge = ticketDTO.badge
        price = "\(ticketDTO.price.value)"
        departureTime = ticketDTO.departure.date
        arrivalTime = ticketDTO.arrival.date
        flightTime = "хардкод"
        noTransfers = ticketDTO.has_transfer
        departureAirport = ticketDTO.departure.airport
        arrivalAirport = ticketDTO.arrival.airport
    }
}
