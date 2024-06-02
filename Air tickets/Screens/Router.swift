
import UIKit

final class Router {
    func presentPopularDestinationsScreen(from vc: UIViewController, fromTextFieldText: String) {
        let model = PopularDestinationsModel()
        let viewModel = PopularDestinationsViewModel(model: model, router: AppDelegate.router, fromTextFieldText: fromTextFieldText)
        let popularDestinationsVC = PopularDestinationsViewController(viewModel: viewModel)
        viewModel.popularDestinationsViewController = popularDestinationsVC
        popularDestinationsVC.modalTransitionStyle = .coverVertical
        popularDestinationsVC.modalPresentationStyle = .popover
        vc.present(popularDestinationsVC, animated: true)
    }
    
    func presentTicketsOffersViewController(from vc: UIViewController, fromTextFielText: String) {
        let model = TicketsOffersModel(networkService: AppDelegate.networkService)
         let viewModel = TicketsOffersViewModel(model: model, fromTextFieldText: fromTextFielText)
         let ticketsOffersVC = TicketsOffersViewController(viewModel: viewModel)
        vc.present(ticketsOffersVC, animated: true)
    }
}
