
import Foundation

final class PopularDestinationsViewModel {
    
    private let model: PopularDestinationsModel
    private let router: Router
    let cellModels: [PopularDestinationsTableViewCellModel]

    weak var popularDestinationsViewController: PopularDestinationsViewController?

    var fromTextFieldLastValue: String?
    var fromTextFieldText: String

    init(model: PopularDestinationsModel, router: Router, fromTextFieldText: String) {
        self.model = model
        cellModels = model.mockData.map { PopularDestinationsTableViewCellModel(image: $0.image, title: $0.title) }
        self.fromTextFieldText = fromTextFieldText
        fromTextFieldLastValue = model.loadCachedFromTextFieldLastValue()
        self.router = router
    }

    func textFieldEditingEnd() {
        guard
            let popularDestinationsViewController,
            let fromTextFieldLastValue,
            !fromTextFieldLastValue.isEmpty
        else { return }
        router.presentTicketsOffersViewController(
            from: popularDestinationsViewController,
            fromTextFielText: fromTextFieldLastValue
        )
    }
}
