import Foundation

final class FirstEntryViewModel {
    @Observable
    var flyAwayModels: [FlyAwayMusicallyCellModel] = []

    var fromTextFieldLastValue: String? {
        didSet {
            model.saveFromTextFieldLastValue(fromTextFieldLastValue)
        }
    }

    weak var firstEntryViewController: FirstEntryViewController?

    private let model: FirstEntryModel
    private let router: Router

    init(model: FirstEntryModel, router: Router) {
        self.model = model
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
            let firstEntryViewController,
            let fromTextFieldLastValue,
            !fromTextFieldLastValue.isEmpty 
        else { return }
        router.presentPopularDestinationsScreen(
            from: firstEntryViewController,
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
