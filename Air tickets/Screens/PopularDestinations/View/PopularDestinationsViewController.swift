
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
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 5
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2.0)
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

    private var spacerView: UIView = {
        let spacer = UIView()
        spacer.backgroundColor = UIColor(hexString: "3E3F43")
        return spacer
    }()

    private var difficultRoute = PopularDestinationsImageView(image: "difficultRoute", text: "Сложный\n маршрут")
    private var anywhere = PopularDestinationsImageView(image: "anywhere", text: "Куда угодно")
    private var weekend = PopularDestinationsImageView(image: "weekend", text: "Выходные")
    private var hotTickets = PopularDestinationsImageView(image: "hotTickets", text: "Горячие билеты")

    private let popularDestinationsTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
        return tableView
    }()

    private let viewModel: PopularDestinationsViewModel

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
        toTextField.addTarget(self, action: #selector(textFieldEditingEnd), for: .editingDidEnd)

        setupConstraints()
    }

    @objc
    func textFieldEditingEnd() {
        viewModel.textFieldEditingEnd()
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

        let hStack = UIStackView(arrangedSubviews: [difficultRoute, anywhere, weekend, hotTickets])
        hStack.axis = .horizontal
        hStack.spacing = 16
        hStack.distribution = .fillEqually
        hStack.alignment = .center
        hStack.translatesAutoresizingMaskIntoConstraints = false
        difficultRoute.translatesAutoresizingMaskIntoConstraints = false
        anywhere.translatesAutoresizingMaskIntoConstraints = false
        weekend.translatesAutoresizingMaskIntoConstraints = false
        hotTickets.translatesAutoresizingMaskIntoConstraints = false

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

            hStack.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 26),
            hStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hStack.heightAnchor.constraint(equalToConstant: 90),
            hStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            popularDestinationsTableView.topAnchor.constraint(equalTo: hStack.bottomAnchor, constant: 26),
            popularDestinationsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            popularDestinationsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            popularDestinationsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),

        ])
    }
}

extension PopularDestinationsViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        UIView()
//    }
//
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        UIView()
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        20
//    }
//
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        20
//    }
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
