import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    class func configure() -> UIViewController {

        let searchVC = UINavigationController(rootViewController: createFirstEntryScreen())
        searchVC.tabBarItem = UITabBarItem(
            title: "Авиабилеты",
            image: UIImage(named: "airTickets"),
            selectedImage: UIImage(named: "airTickets"))

        let hotelsVC = UINavigationController(
            rootViewController: BlankScreenViewController(blankTitleText: "Отели"))
        hotelsVC.tabBarItem = UITabBarItem(
            title: "Отели",
            image: UIImage(named: "hotels"),
            selectedImage: UIImage(named: "hotels"))

        let inShortVC = UINavigationController(rootViewController: BlankScreenViewController(blankTitleText: "Короче"))
        inShortVC.tabBarItem = UITabBarItem(
            title: "Короче",
            image: UIImage(named: "inShort"),
            selectedImage: UIImage(named: "inShort"))

        let subscriptionsVC = UINavigationController(rootViewController: BlankScreenViewController(blankTitleText: "Подписки"))
        subscriptionsVC.tabBarItem = UITabBarItem(
            title: "Подписки",
            image: UIImage(named: "subscriptions"),
            selectedImage: UIImage(named: "subscriptions"))

        let profileVC = UINavigationController(rootViewController: BlankScreenViewController(blankTitleText: "Профиль"))
        profileVC.tabBarItem = UITabBarItem(
            title: "Профиль",
            image: UIImage(named: "profile"),
            selectedImage: UIImage(named: "profile"))

        let tabBarController = TabBarController()
        tabBarController.viewControllers = [searchVC, hotelsVC, inShortVC, subscriptionsVC, profileVC]
        tabBarController.tabBar.unselectedItemTintColor = .gray
        tabBarController.tabBar.backgroundColor = .black
        
       return tabBarController
    }

    static func createFirstEntryScreen() -> FirstEntryViewController {
        let model = FirstEntryModel(networkService: AppDelegate.networkService)
        let viewModel = FirstEntryViewModel(model: model, router: AppDelegate.router)
        let viewController = FirstEntryViewController(viewModel: viewModel)
        viewModel.firstEntryViewController = viewController
        return viewController
    }
}
