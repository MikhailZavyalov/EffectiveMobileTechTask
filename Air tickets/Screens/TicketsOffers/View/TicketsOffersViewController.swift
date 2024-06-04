
import UIKit

final class TicketsOffersViewController: UIViewController {

    private let viewModel: TicketsOffersViewModel

    private var searchView: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(hexString: "2F3035")
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = false
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 5
        view.layer.shadowColor = UIColor.black.cgColor //UIColor(named: "shadowColor")?.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        return view
    }()

    private var backButton: UIButton = {
        var image = UIImage(named: "backArrow")
        var button = UIButton()
        button.setImage(image, for: .normal)
        return button
    }()

    private var fromTextField: UITextField = {
        var textField = UITextField()
        textField.font = .boldText16
        textField.textColor = .white
        return textField
    }()

    private var toTextField: UITextField = {
        var textField = UITextField()
        textField.font = .boldText16
        textField.textColor = .white
        return textField
    }()

    private let spacerView: UIView = {
        let spacer = UIView()
        spacer.backgroundColor = UIColor(hexString: "9F9F9F9F")
        return spacer
    }()

    private let changeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "change"), for: .normal)
        return button
    }()

    private let clearButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "clear"), for: .normal)
        return button
    }()

    private var backButtonView = TicketsOffersFlightSettingsButton(
        image: "plus", text: "обратно"
    )

    private var dateButton = TicketsOffersFlightSettingsButton(image: nil, text: "24 фев, сб")

    private var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.backgroundColor = .white
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()

    private var numberOfPersonsButton = TicketsOffersFlightSettingsButton(
        image: "person", text: "1,эконом"
    )

    private var filtersButton = TicketsOffersFlightSettingsButton(image: "filters", text: "фильтр")

    private let ticketsOffersTableView: UITableView = {
        let tableView = UITableView()
        tableView.layer.cornerRadius = 16
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        return tableView
    }()

    private let seeAllTicketsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.init(hexString: "2261BC")
        button.layer.cornerRadius = 8
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("Посмотреть все билеты", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return button
    }()

    init(viewModel: TicketsOffersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

        viewModel.$ticketsOffersModels.bind(executeInitially: true) { [weak self] models in
            self?.ticketsOffersTableView.reloadData()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        ticketsOffersTableView.delegate = self
        ticketsOffersTableView.dataSource = self
        ticketsOffersTableView.register(TicketsOffersTableViewCell.self, forCellReuseIdentifier: TicketsOffersTableViewCell.reuseID)
        viewModel.loadTicketsOffersData()
        fromTextField.text = viewModel.fromTextFieldLastValue
        toTextField.text = viewModel.toTextFieldLastValue
        seeAllTicketsButton.addTarget(self, action: #selector(goToAllTicketsScreen), for: .touchUpInside)
        clearButton.addTarget(self, action: #selector(clearText), for: .touchUpInside)
        changeButton.addTarget(self, action: #selector(changeDestinationButtonTapped), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)

        setupConstraints()
    }

    private func setupConstraints() {
        view.addSubview(searchView)
        searchView.translatesAutoresizingMaskIntoConstraints = false

        searchView.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false

        let vStack = UIStackView(arrangedSubviews: [fromTextField, spacerView, toTextField])
        vStack.axis = .vertical
        vStack.translatesAutoresizingMaskIntoConstraints = false
        fromTextField.translatesAutoresizingMaskIntoConstraints = false
        spacerView.translatesAutoresizingMaskIntoConstraints = false
        toTextField.translatesAutoresizingMaskIntoConstraints = false

        searchView.addSubview(vStack)

        searchView.addSubview(changeButton)
        changeButton.translatesAutoresizingMaskIntoConstraints = false

        searchView.addSubview(clearButton)
        clearButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(backButtonView)
        backButtonView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(dateButton)
        dateButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(numberOfPersonsButton)
        numberOfPersonsButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(filtersButton)
        filtersButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(ticketsOffersTableView)
        ticketsOffersTableView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(seeAllTicketsButton)
        seeAllTicketsButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.topAnchor, constant: 79),
            searchView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            vStack.topAnchor.constraint(equalTo: searchView.topAnchor),
            vStack.trailingAnchor.constraint(equalTo: searchView.trailingAnchor, constant: -16),
            vStack.bottomAnchor.constraint(equalTo: searchView.bottomAnchor),
            vStack.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 16),

            fromTextField.heightAnchor.constraint(equalToConstant: 45),
            toTextField.heightAnchor.constraint(equalToConstant: 44),

            backButton.centerYAnchor.constraint(equalTo: searchView.centerYAnchor, constant: 0),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.leadingAnchor.constraint(equalTo: searchView.leadingAnchor, constant: 8),

            changeButton.bottomAnchor.constraint(equalTo: spacerView.topAnchor, constant: -8),
            changeButton.trailingAnchor.constraint(equalTo: searchView.trailingAnchor, constant: -16),
            changeButton.heightAnchor.constraint(equalToConstant: 24),
            changeButton.widthAnchor.constraint(equalToConstant: 24),

            spacerView.heightAnchor.constraint(equalToConstant: 1),

            backButtonView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 15),
            backButtonView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backButtonView.widthAnchor.constraint(equalToConstant: 105),
            backButtonView.heightAnchor.constraint(equalToConstant: 33),

            dateButton.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 15),
            dateButton.leadingAnchor.constraint(equalTo: backButtonView.trailingAnchor, constant: 8),
            dateButton.widthAnchor.constraint(equalToConstant: 88),
            dateButton.heightAnchor.constraint(equalToConstant: 33),

            numberOfPersonsButton.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 15),
            numberOfPersonsButton.leadingAnchor.constraint(equalTo: dateButton.trailingAnchor, constant: 8),
            numberOfPersonsButton.widthAnchor.constraint(equalToConstant: 104),
            numberOfPersonsButton.heightAnchor.constraint(equalToConstant: 33),

            filtersButton.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 15),
            filtersButton.leadingAnchor.constraint(equalTo: numberOfPersonsButton.trailingAnchor, constant: 8),
            filtersButton.widthAnchor.constraint(equalToConstant: 104),
            filtersButton.heightAnchor.constraint(equalToConstant: 33),

            clearButton.topAnchor.constraint(equalTo: spacerView.bottomAnchor, constant: 8),
            clearButton.trailingAnchor.constraint(equalTo: searchView.trailingAnchor, constant: -16),
            clearButton.heightAnchor.constraint(equalToConstant: 24),
            clearButton.widthAnchor.constraint(equalToConstant: 24),

            ticketsOffersTableView.topAnchor.constraint(equalTo: backButtonView.bottomAnchor, constant: 15),
            ticketsOffersTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            ticketsOffersTableView.heightAnchor.constraint(equalToConstant: 218),
            ticketsOffersTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            seeAllTicketsButton.topAnchor.constraint(equalTo: ticketsOffersTableView.bottomAnchor, constant: 18),
            seeAllTicketsButton.heightAnchor.constraint(equalToConstant: 42),
            seeAllTicketsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            seeAllTicketsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

        ])
    }

    @objc 
    func goToAllTicketsScreen() {
        viewModel.seeAllTicketsButtonTap()
    }

    @objc 
    func clearText() {
        toTextField.text = ""
        viewModel.toTextFieldLastValue = ""
    }

    @objc
    func changeDestinationButtonTapped() {
        let to = toTextField.text
        let from = fromTextField.text

        toTextField.text = from
        fromTextField.text = to
        viewModel.toTextFieldLastValue = from
        viewModel.fromTextFieldLastValue = to
    }

    @objc
    func backButtonTapped() {
        self.dismiss(animated: true)
    }
}

extension TicketsOffersViewController: UITableViewDelegate {

}

extension TicketsOffersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.ticketsOffersModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ticketsOffersTableView.dequeueReusableCell(withIdentifier: TicketsOffersTableViewCell.reuseID, for: indexPath)
        guard let ticketsOfferCell = cell as? TicketsOffersTableViewCell else { return cell }
        ticketsOfferCell.configure(
            with: viewModel.ticketsOffersModels[indexPath.row],
            isFirst: indexPath.row == 0,
            isLast: indexPath.row == viewModel.ticketsOffersModels.count - 1
        )
        return ticketsOfferCell
    }
}
