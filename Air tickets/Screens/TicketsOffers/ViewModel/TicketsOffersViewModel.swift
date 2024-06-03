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
        color = colorsMap[ticketsOfferDTO.id, default: "FFFFFF"]
        title = ticketsOfferDTO.title
        timeRange = ticketsOfferDTO.time_range.joined(separator: " ")
        price = "\(ticketsOfferDTO.price.value)"
    }
}

private let colorsMap: [Int: String] = [
    1: "FF5E5E",
    10: "2261BC",
    30: "FFFFFF"
]
