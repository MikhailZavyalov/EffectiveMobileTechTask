
import UIKit

final class Router {
    func presentPopularDestinationsScreen(from vc: UIViewController, fromTextFieldText: String) {
        let model = Model()
        let viewModel = ViewModel(model: model, fromTextFieldText: fromTextFieldText)
        let popularDestinationsVC = PopularDestinationsViewController(viewModel: viewModel)
        popularDestinationsVC.modalTransitionStyle = .coverVertical
        popularDestinationsVC.modalPresentationStyle = .popover
        vc.present(popularDestinationsVC, animated: true)
    }
}
