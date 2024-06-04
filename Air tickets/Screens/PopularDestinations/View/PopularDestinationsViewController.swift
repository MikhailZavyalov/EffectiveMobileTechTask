
import UIKit

final class PopularDestinationsViewController: UIViewController {

    private var rectangle: UIImageView = {
        let rectangle = UIImage(named: "rectangle")
        let view = UIImageView(image: rectangle)
        return view
    }()

    private var searchView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "2F3035")
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.25
        view.layer.shadowRadius = 5
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        return view
    }()

    private var airplaneImage: UIImageView = {
        let image = UIImage(named: "airplane")
        let view = UIImageView(image: image)
        return view
    }()

    private var searchImage: UIImageView = {
        let image = UIImage(named: "search")
        let view = UIImageView(image: image)
        return view
    }()

    private var fromTextField: UITextField = {
        let textField = UITextField()
        textField.font = .boldText16
        textField.textColor = UIColor.white
        return textField
    }()

    private var toTextField: UITextField = {
        let textField = UITextField()
        textField.font = .boldText16
        textField.attributedPlaceholder = NSAttributedString(
            string: "Куда - Турция",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(hexString: "9F9F9F")]
        )
        textField.textColor = UIColor(hexString: "9F9F9F")
        return textField
    }()

    private let spacerView: UIView = {
        let spacer = UIView()
        spacer.backgroundColor = UIColor(hexString: "3E3F43")
        return spacer
    }()

    private let clearButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "clear"), for: .normal)
        return button
    }()

    private var difficultRoute = PopularDestinationsButtonsView(image: "difficultRoute")
    private var anywhere = PopularDestinationsButtonsView(image: "anywhere")
    private var weekend = PopularDestinationsButtonsView(image: "weekend")
    private var hotTickets = PopularDestinationsButtonsView(image: "hotTickets")

    private let difficultRouteText: UILabel = {
        let text = UILabel()
        text.text = "Сложный\n маршрут"
        text.numberOfLines = 2
        text.textAlignment = .center
        text.textColor = .white
        text.font = UIFont.regular14
        return text
    }()

    private let anywhereText: UILabel = {
        let text = UILabel()
        text.text = "Куда угодно"
        text.numberOfLines = 1
        text.textAlignment = .center
        text.textColor = .white
        text.font = UIFont.regular14
        return text
    }()

    private let weekendText: UILabel = {
        let text = UILabel()
        text.text = "Выходные"
        text.numberOfLines = 1
        text.textAlignment = .center
        text.textColor = .white
        text.font = UIFont.regular14
        return text
    }()

    private let hotTicketsText: UILabel = {
        let text = UILabel()
        text.text = "Горячие\n билеты"
        text.numberOfLines = 2
        text.textAlignment = .center
        text.textColor = .white
        text.font = UIFont.regular14
        return text
    }()

    private let popularDestinationsTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
        return tableView
    }()

    private let viewModel: PopularDestinationsViewModel
    private var textFieldDelegate: AirTicketsTextFieldDelegate?

    init(viewModel: PopularDestinationsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(hexString: "242529")
        popularDestinationsTableView.dataSource = self
        popularDestinationsTableView.delegate = self
        popularDestinationsTableView.register(PopularDestinationsTableViewCell.self, forCellReuseIdentifier: PopularDestinationsTableViewCell.reuseID)
        fromTextField.text = viewModel.fromTextFieldText
        textFieldDelegate = AirTicketsTextFieldDelegate(onEditingEnd: { [weak self] in
            guard let self else { return }
            viewModel.toTextFieldLastValue = toTextField.text
        })
        toTextField.delegate = textFieldDelegate
        toTextField.addTarget(self, action: #selector(textFieldEditingEnd), for: .editingDidEnd)

        clearButton.addTarget(self, action: #selector(clearText), for: .touchUpInside)

        difficultRoute.addTarget(self, action: #selector(quickSearchButtonTapped), for: .touchUpInside)
        weekend.addTarget(self, action: #selector(quickSearchButtonTapped), for: .touchUpInside)
        hotTickets.addTarget(self, action: #selector(quickSearchButtonTapped), for: .touchUpInside)
        anywhere.addTarget(self, action: #selector(printAnywhere), for: .touchUpInside)

        setupConstraints()
    }

    @objc
    func textFieldEditingEnd() {
        viewModel.textFieldEditingEnd()
    }

    @objc 
    func quickSearchButtonTapped() {
        viewModel.quickSearchButtonTapped()
    }

    @objc
    func printAnywhere() {
        toTextField.text = "Куда угодно"
    }

    private func setupConstraints() {
        view.addSubview(rectangle)
        rectangle.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(searchView)
        searchView.translatesAutoresizingMaskIntoConstraints = false

        searchView.addSubview(airplaneImage)
        airplaneImage.translatesAutoresizingMaskIntoConstraints = false

        searchView.addSubview(searchImage)
        searchImage.translatesAutoresizingMaskIntoConstraints = false

        searchView.addSubview(fromTextField)
        fromTextField.translatesAutoresizingMaskIntoConstraints = false

        searchView.addSubview(spacerView)
        spacerView.translatesAutoresizingMaskIntoConstraints = false

        searchView.addSubview(toTextField)
        toTextField.translatesAutoresizingMaskIntoConstraints = false

        searchView.addSubview(clearButton)
        clearButton.translatesAutoresizingMaskIntoConstraints = false

        let hStack = UIStackView(arrangedSubviews: [difficultRoute, anywhere, weekend, hotTickets])
        hStack.axis = .horizontal
        hStack.distribution = .equalSpacing
        hStack.alignment = .center
        hStack.translatesAutoresizingMaskIntoConstraints = false
        difficultRoute.translatesAutoresizingMaskIntoConstraints = false
        anywhere.translatesAutoresizingMaskIntoConstraints = false
        weekend.translatesAutoresizingMaskIntoConstraints = false
        hotTickets.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(difficultRouteText)
        difficultRouteText.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(anywhereText)
        anywhereText.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(weekendText)
        weekendText.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(hotTicketsText)
        hotTicketsText.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(hStack)

        view.addSubview(popularDestinationsTableView)
        popularDestinationsTableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            rectangle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            rectangle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rectangle.heightAnchor.constraint(equalToConstant: 5),
            rectangle.widthAnchor.constraint(equalToConstant: 38),

            searchView.topAnchor.constraint(equalTo: rectangle.bottomAnchor, constant: 25),
            searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchView.heightAnchor.constraint(equalToConstant: 96),
            searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            airplaneImage.topAnchor.constraint(equalTo: searchView.topAnchor, constant: 16),
            airplaneImage.widthAnchor.constraint(equalToConstant: 24),
            airplaneImage.heightAnchor.constraint(equalToConstant: 24),
            airplaneImage.leadingAnchor.constraint(equalTo: searchView.leadingAnchor, constant: 16),

            searchImage.topAnchor.constraint(equalTo: spacerView.bottomAnchor, constant: 8),
            searchImage.widthAnchor.constraint(equalToConstant: 24),
            searchImage.heightAnchor.constraint(equalToConstant: 24),
            searchImage.leadingAnchor.constraint(equalTo: searchView.leadingAnchor, constant: 16),

            fromTextField.topAnchor.constraint(equalTo: searchView.topAnchor, constant: 16),
            fromTextField.leadingAnchor.constraint(equalTo: airplaneImage.trailingAnchor, constant: 8),

            toTextField.topAnchor.constraint(equalTo: spacerView.bottomAnchor, constant: 8),
            toTextField.leadingAnchor.constraint(equalTo: searchImage.trailingAnchor, constant: 8),

            spacerView.topAnchor.constraint(equalTo: searchView.topAnchor, constant: 48),
            spacerView.leadingAnchor.constraint(equalTo: searchView.leadingAnchor, constant: 16),
            spacerView.trailingAnchor.constraint(equalTo: searchView.trailingAnchor, constant: -16),
            spacerView.heightAnchor.constraint(equalToConstant: 1),

            clearButton.topAnchor.constraint(equalTo: spacerView.bottomAnchor, constant: 8),
            clearButton.trailingAnchor.constraint(equalTo: searchView.trailingAnchor, constant: -16),
            clearButton.heightAnchor.constraint(equalToConstant: 24),
            clearButton.widthAnchor.constraint(equalToConstant: 24),

            hStack.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 26),
            hStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -26),
            hStack.heightAnchor.constraint(equalToConstant: 48),
            hStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26),

            difficultRoute.heightAnchor.constraint(equalToConstant: 48),
            difficultRoute.widthAnchor.constraint(equalToConstant: 48),

            difficultRouteText.topAnchor.constraint(equalTo: difficultRoute.bottomAnchor, constant: 8),
            difficultRouteText.centerXAnchor.constraint(equalTo: difficultRoute.centerXAnchor, constant: 0),

            anywhere.heightAnchor.constraint(equalToConstant: 48),
            anywhere.widthAnchor.constraint(equalToConstant: 48),
            anywhereText.topAnchor.constraint(equalTo: anywhere.bottomAnchor, constant: 8),
            anywhereText.centerXAnchor.constraint(equalTo: anywhere.centerXAnchor, constant: 0),

            weekend.heightAnchor.constraint(equalToConstant: 48),
            weekend.widthAnchor.constraint(equalToConstant: 48),
            weekendText.topAnchor.constraint(equalTo: weekend.bottomAnchor, constant: 8),
            weekendText.centerXAnchor.constraint(equalTo: weekend.centerXAnchor, constant: 0),

            hotTickets.heightAnchor.constraint(equalToConstant: 48),
            hotTickets.widthAnchor.constraint(equalToConstant: 48),
            hotTicketsText.topAnchor.constraint(equalTo: hotTickets.bottomAnchor, constant: 8),
            hotTicketsText.centerXAnchor.constraint(equalTo: hotTickets.centerXAnchor, constant: 0),

            popularDestinationsTableView.topAnchor.constraint(equalTo: difficultRouteText.bottomAnchor, constant: 26),
            popularDestinationsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            popularDestinationsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            popularDestinationsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),

        ])
    }

    @objc func clearText() {
        toTextField.text = ""
    }
}

extension PopularDestinationsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = viewModel.cellModels[indexPath.row].title
        toTextField.text = city
    }
}

extension PopularDestinationsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = popularDestinationsTableView.dequeueReusableCell(withIdentifier: PopularDestinationsTableViewCell.reuseID, for: indexPath)
        guard let settingsCell = cell as? PopularDestinationsTableViewCell else { return cell }
        settingsCell.configure(
            with: viewModel.cellModels[indexPath.row],
            isFirst: indexPath.row == 0,
            isLast: indexPath.row == viewModel.cellModels.count - 1
        )
        return settingsCell
    }
}
