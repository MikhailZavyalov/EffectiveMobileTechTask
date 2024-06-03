
import UIKit

final class AllTicketsViewController: UIViewController {

    private let allTicketsTableView: UITableView = {
        let tableView = UITableView()
//        tableView.backgroundColor = .clear
        return tableView
    }()

    private let viewModel: AllTicketsViewModel

    init(viewModel: AllTicketsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        viewModel.loadData()
        allTicketsTableView.delegate = self
        allTicketsTableView.dataSource = self
        allTicketsTableView.register(AllTicketsTableViewCell.self, forCellReuseIdentifier: AllTicketsTableViewCell.reuseID)
        viewModel.$allTicketsModels.bind(executeInitially: true) { [weak self] models in
            print("🍎", #function, models)
        }

        setupConstraints()
    }

    private func setupConstraints() {
        view.addSubview(allTicketsTableView)
        allTicketsTableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            allTicketsTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 26),
            allTicketsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            allTicketsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            allTicketsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
        ])
    }

}

extension AllTicketsViewController: UITableViewDelegate {

}

extension AllTicketsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.allTicketsModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = allTicketsTableView.dequeueReusableCell(withIdentifier: AllTicketsTableViewCell.reuseID, for: indexPath)
        guard let settingsCell = cell as? AllTicketsTableViewCell else { return cell }
        settingsCell.configure(with: viewModel.allTicketsModels[indexPath.row])
        return settingsCell
    }
}
