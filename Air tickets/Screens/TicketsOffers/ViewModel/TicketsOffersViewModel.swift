import Foundation

final class TicketsOffersViewModel {
    @Observable
    var ticketsOffersModels: [TicketsOffersTableViewCellModel] = []

    private let model: TicketsOffersModel
    private let router: Router

    let fromTextFieldText: String
    var fromTextFieldLastValue: String?

    weak var ticketsOffersViewController: TicketsOffersViewController?

    init(model: TicketsOffersModel, router: Router, fromTextFieldText: String) {
        self.model = model
        self.router = router
        self.fromTextFieldText = fromTextFieldText
        fromTextFieldLastValue = model.loadCachedFromTextFieldLastValue()
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

    func seeAllTicketsButtonTap() {
        guard
            let ticketsOffersViewController,
            let fromTextFieldLastValue,
            !fromTextFieldLastValue.isEmpty
        else { return }
        router.presentAllTicketsViewController(from: ticketsOffersViewController, fromTextFieldText: fromTextFieldLastValue)
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

