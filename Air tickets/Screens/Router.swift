
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
        let viewModel = TicketsOffersViewModel(model: model, router: AppDelegate.router, fromTextFieldText: fromTextFielText)
         let ticketsOffersVC = TicketsOffersViewController(viewModel: viewModel)
        viewModel.ticketsOffersViewController = ticketsOffersVC
        ticketsOffersVC.modalTransitionStyle = .coverVertical
        ticketsOffersVC.modalPresentationStyle = .fullScreen
        vc.present(ticketsOffersVC, animated: true)
    }

    func presentAllTicketsViewController(from vc: UIViewController, fromTextFieldText: String) {
        let model = AllTicketsModel(networkService: AppDelegate.networkService)
        let viewModel = AllTicketsViewModel(model: model, router: AppDelegate.router)
        let allTicketsVC = AllTicketsViewController(viewModel: viewModel)
        allTicketsVC.modalTransitionStyle = .coverVertical
        allTicketsVC.modalPresentationStyle = .fullScreen
        vc.present(allTicketsVC, animated: true)
    }

    func presentStubViewController(from vc: UIViewController) {
        let controller = StubScreen()
        vc.present(controller, animated: true)
    }
}
