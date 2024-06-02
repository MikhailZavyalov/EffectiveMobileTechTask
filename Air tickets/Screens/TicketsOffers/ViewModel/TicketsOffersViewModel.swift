import Foundation

final class TicketsOffersViewModel {
    @Observable
    var ticketsOffersModels: [TicketsOffersTableViewCellModel] = []

    private let model: TicketsOffersModel
//  private let coordinator: StatisticsNavigation

    init(model: TicketsOffersModel/*, coordinator: StatisticsRouter*/) {
        self.model = model
//        self.coordinator = coordinator
    }

    func loadTicketsOffersData() {
        model.loadTicketsOffers { result in
            DispatchQueue.main.async { [weak self] in
                guard let self else {
                    return
                }

                switch result {
                case let .success(models):
                    self.ticketsOffersModels = models.map(TicketsOffersTableViewCellModel.init(ticketsOfferDTO:))
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
}

private extension TicketsOffersTableViewCellModel {
    init(ticketsOfferDTO: TicketsOfferDTO) {
        image = String(ticketsOfferDTO.id)
        title = ticketsOfferDTO.title
        timeRange = ticketsOfferDTO.time_range
        price = "\(ticketsOfferDTO.price.value)"
    }
}

