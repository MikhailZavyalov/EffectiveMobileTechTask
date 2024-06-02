import Foundation

final class FirstEntryViewModel {
    @Observable
    var flyAwayModels: [FlyAwayMusicallyCellModel] = []

    @Observable
    var ticketsOffersModels: [PopularDestinationsTableViewCellModel] = []

    var fromTextFieldLastValue: String? {
        didSet {
            model.saveFromTextFieldLastValue(fromTextFieldLastValue)
        }
    }

    weak var viewController: FirstEntryViewController?

    private let model: FirstEntryModel
//    private let coordinator: StatisticsNavigation
    private let router: Router

    init(model: FirstEntryModel, router: Router/*, coordinator: StatisticsRouter*/) {
        self.model = model
//        self.coordinator = coordinator
        self.router = router
        fromTextFieldLastValue = model.loadCachedFromTextFieldLastValue()
    }

    func loadData() {
        model.loadOffers { result in
            DispatchQueue.main.async { [weak self] in
                guard let self else {
                    return
                }

                switch result {
                case let .success(models):
                    self.flyAwayModels = models.map(FlyAwayMusicallyCellModel.init(offerDTO:))
                case let .failure(error):
                    print(error)
                }
            }
        }
    }

    func toTextFieldTapped() {
        guard
            let viewController,
            let fromTextFieldLastValue,
            !fromTextFieldLastValue.isEmpty 
        else { return }
        router.presentPopularDestinationsScreen(
            from: viewController,
            fromTextFieldText: fromTextFieldLastValue
        )
    }
}

private extension FlyAwayMusicallyCellModel {
    init(offerDTO: OfferDTO) {
        id = String(offerDTO.id)
        title = offerDTO.title
        town = offerDTO.town
        price = "от \(offerDTO.price.value) ₽"
    }
}
