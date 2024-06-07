
import UIKit

final class AllTicketsViewController: UIViewController {

    private var flightInformationView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "242529")
        view.layer.masksToBounds = false
        return view
    }()

    private let returnButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backArrow"), for: .normal)
        return button
    }()

    private let cities: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldText16
        return label
    }()

    private let passengerDetails: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "9F9F9F")
        label.font = UIFont.regular14
        return label
    }()

    private let allTicketsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        tableView.layer.masksToBounds = true
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
            self?.allTicketsTableView.reloadData()
        }
        returnButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        cities.text = "\(viewModel.fromTextFieldText)-\(viewModel.toTextFieldText)"
        passengerDetails.text = "\(viewModel.textFromDatePicker), 1 пассажир"

        setupConstraints()
    }

    private func setupConstraints() {
        view.addSubview(flightInformationView)
        flightInformationView.translatesAutoresizingMaskIntoConstraints = false

        flightInformationView.addSubview(returnButton)
        returnButton.translatesAutoresizingMaskIntoConstraints = false

        flightInformationView.addSubview(cities)
        cities.translatesAutoresizingMaskIntoConstraints = false

        flightInformationView.addSubview(passengerDetails)
        passengerDetails.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(allTicketsTableView)
        allTicketsTableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            flightInformationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            flightInformationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            flightInformationView.heightAnchor.constraint(equalToConstant: 56),
            flightInformationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            returnButton.topAnchor.constraint(equalTo: flightInformationView.topAnchor, constant: 16),
            returnButton.leadingAnchor.constraint(equalTo: flightInformationView.leadingAnchor, constant: 0),
            returnButton.heightAnchor.constraint(equalToConstant: 24),
            returnButton.widthAnchor.constraint(equalToConstant: 24),

            cities.topAnchor.constraint(equalTo: flightInformationView.topAnchor, constant: 8),
            cities.leadingAnchor.constraint(equalTo: returnButton.trailingAnchor, constant: 8),

            passengerDetails.topAnchor.constraint(equalTo: cities.bottomAnchor, constant: 4),
            passengerDetails.leadingAnchor.constraint(equalTo: returnButton.trailingAnchor, constant: 8),

            allTicketsTableView.topAnchor.constraint(equalTo: flightInformationView.bottomAnchor, constant: 34),
            allTicketsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            allTicketsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            allTicketsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
        ])
    }

    @objc
    func backButtonTapped() {
        self.dismiss(animated: true)
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
        settingsCell.containerView.backgroundColor = UIColor(hexString: "1D1E20")
        settingsCell.configure(with: viewModel.allTicketsModels[indexPath.row])
        return settingsCell
    }
}
