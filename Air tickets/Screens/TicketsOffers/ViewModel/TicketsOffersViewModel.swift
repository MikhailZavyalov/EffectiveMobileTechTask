import Foundation

final class TicketsOffersViewModel {
    @Observable
    var ticketsOffersModels: [TicketsOffersTableViewCellModel] = []

    private let model: TicketsOffersModel
    private let router: Router

    var fromTextFieldLastValue: String?
    var toTextFieldLastValue: String?

    weak var ticketsOffersViewController: TicketsOffersViewController?

    init(model: TicketsOffersModel, router: Router, fromTextFieldText: String, toTextFieldText: String) {
        self.model = model
        self.router = router
        fromTextFieldLastValue = fromTextFieldText
        toTextFieldLastValue = toTextFieldText
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
            !fromTextFieldLastValue.isEmpty,
            let toTextFieldLastValue,
            !toTextFieldLastValue.isEmpty
        else { return }
        router.presentAllTicketsViewController(from: ticketsOffersViewController, fromTextFieldText: fromTextFieldLastValue, toTextFieldText: toTextFieldLastValue)
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
