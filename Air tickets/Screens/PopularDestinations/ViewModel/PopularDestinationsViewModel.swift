
import Foundation

final class PopularDestinationsViewModel {

    let cellModels: [PopularDestinationsTableViewCellModel]
    weak var popularDestinationsViewController: PopularDestinationsViewController?
    var toTextFieldLastValue: String? {
        didSet {
            model.saveToTextFieldLastValue(toTextFieldLastValue)
        }
    }
    let fromTextFieldText: String

    private let model: PopularDestinationsModel
    private let router: Router

    init(model: PopularDestinationsModel, router: Router, fromTextFieldText: String) {
        self.model = model
        cellModels = model.mockData.map { PopularDestinationsTableViewCellModel(image: $0.image, title: $0.title) }
        self.fromTextFieldText = fromTextFieldText
        toTextFieldLastValue = model.loadCachedToTextFieldLastValue()
        self.router = router
    }

    func textFieldEditingEnd() {
        guard
            let popularDestinationsViewController,
            let toTextFieldLastValue,
            !toTextFieldLastValue.isEmpty
        else { return }
        router.presentTicketsOffersViewController(
            from: popularDestinationsViewController,
            fromTextFielText: toTextFieldLastValue
        )
    }

    func quickSearchButtonTapped() {
        guard let popularDestinationsViewController else { return }
        router.presentStubViewController(from: popularDestinationsViewController)
    }
}
