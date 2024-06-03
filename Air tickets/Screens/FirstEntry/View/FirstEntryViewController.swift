
import UIKit

class FirstEntryViewController: UIViewController {
    private let geometricParams = GeometricParams(
        cellSize: CGSize(
            width: 132,
            height: 213
        ),
        leftInset: 0,
        rightInset: 0,
        cellSpacing: 67
    )

    private let viewModel: FirstEntryViewModel

    private var title1: UILabel = {
        let label = UILabel()
        label.text = "Поиск дешевых\n авиабилетов"
        label.numberOfLines = 2
        label.font = .title1
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()

    private var backgroundView: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(hexString: "2F3035")
        view.layer.cornerRadius = 16
        return view
    }()

    private var searchView: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(hexString: "3E3F43")
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = false
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 5
        view.layer.shadowColor = UIColor.black.cgColor //UIColor(named: "shadowColor")?.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        return view
    }()

    private var searchImage: UIImageView = {
        var image = UIImage(named: "search")
        var view = UIImageView(image: image)
        return view
    }()

    private var fromTextField: UITextField = {
        var textField = UITextField()
        textField.font = .boldText16
        textField.attributedPlaceholder = NSAttributedString(
            string: "Откуда - Москва",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(hexString: "9F9F9F")]
        )
        textField.textColor = UIColor.white
        return textField
    }()

    private var toTextField: UITextField = {
        var textField = UITextField()
        textField.font = .boldText16
        textField.attributedPlaceholder = NSAttributedString(
            string: "Куда - Турция",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(hexString: "9F9F9F")]
        )
        textField.textColor = UIColor(hexString: "9F9F9F")
        return textField
    }()

    private var spacerView: UIView = {
        var spacer = UIView()
        spacer.backgroundColor = UIColor(hexString: "9F9F9F9F")
        return spacer
    }()

    private var flyAwayMusicallyLabel: UILabel = {
        var label = UILabel()
        label.font = .title1
        label.text = "Музыкально отлететь"
        label.textColor = .white
        return label
    }()

    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        var view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .black
        return view
    }()

    private var textFieldDelegate: AirTicketsTextFieldDelegate?

    init(viewModel: FirstEntryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.$flyAwayModels.bind(executeInitially: true) { [weak self] _ in
            self?.collectionView.reloadData()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupConstraints()
        viewModel.loadData()
        toTextField.addTarget(self, action: #selector(toTextFieldTapped), for: .touchDown)
        textFieldDelegate = AirTicketsTextFieldDelegate(onEditingEnd: { [weak self] in
            guard let self else { return }
            viewModel.fromTextFieldLastValue = fromTextField.text
        })
        fromTextField.delegate = textFieldDelegate
        fromTextField.text = viewModel.fromTextFieldLastValue

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.scrollToNextItem()
        collectionView.scrollToPreviousItem()

        collectionView.register(FlyAwayMusicallyViewCell.self, forCellWithReuseIdentifier: FlyAwayMusicallyViewCell.reuseID)

        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    private func setupConstraints() {
        view.addSubview(title1)
        title1.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false

        backgroundView.addSubview(searchView)
        searchView.translatesAutoresizingMaskIntoConstraints = false

        searchView.addSubview(searchImage)
        searchImage.translatesAutoresizingMaskIntoConstraints = false

        let vStack = UIStackView(arrangedSubviews: [fromTextField, spacerView, toTextField])
        vStack.axis = .vertical
        vStack.translatesAutoresizingMaskIntoConstraints = false
        fromTextField.translatesAutoresizingMaskIntoConstraints = false
        spacerView.translatesAutoresizingMaskIntoConstraints = false
        toTextField.translatesAutoresizingMaskIntoConstraints = false

        searchView.addSubview(vStack)

        view.addSubview(flyAwayMusicallyLabel)
        flyAwayMusicallyLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            title1.topAnchor.constraint(equalTo: view.topAnchor, constant: 58),
            title1.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -98),
            title1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 90),

            backgroundView.topAnchor.constraint(equalTo: title1.bottomAnchor, constant: 38),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            backgroundView.heightAnchor.constraint(equalToConstant: 122),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            searchView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            searchView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            searchView.heightAnchor.constraint(equalToConstant: 90),
            searchView.widthAnchor.constraint(equalToConstant: 296),

            vStack.topAnchor.constraint(equalTo: searchView.topAnchor),
            vStack.trailingAnchor.constraint(equalTo: searchView.trailingAnchor, constant: -16),
            vStack.bottomAnchor.constraint(equalTo: searchView.bottomAnchor),
            vStack.leadingAnchor.constraint(equalTo: searchImage.trailingAnchor, constant: 16),

            fromTextField.heightAnchor.constraint(equalToConstant: 45),
            toTextField.heightAnchor.constraint(equalToConstant: 44),

            searchImage.topAnchor.constraint(equalTo: searchView.topAnchor, constant: 33),
            searchImage.widthAnchor.constraint(equalToConstant: 24),
            searchImage.heightAnchor.constraint(equalToConstant: 24),
            searchImage.leadingAnchor.constraint(equalTo: searchView.leadingAnchor, constant: 8),

            spacerView.heightAnchor.constraint(equalToConstant: 1),

            flyAwayMusicallyLabel.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 32),
            flyAwayMusicallyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            collectionView.topAnchor.constraint(equalTo: flyAwayMusicallyLabel.bottomAnchor, constant: 16),
            collectionView.heightAnchor.constraint(equalToConstant: 220),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

        ])
    }

    @objc func toTextFieldTapped() {
        viewModel.fromTextFieldLastValue = fromTextField.text
        viewModel.toTextFieldTapped()
    }
}

extension FirstEntryViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.flyAwayModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: FlyAwayMusicallyViewCell.reuseID,
            for: indexPath
        )
        guard let flyAwayCell = cell as? FlyAwayMusicallyViewCell else {
            return cell
        }
        
        let model = viewModel.flyAwayModels[indexPath.row]

        flyAwayCell.configureWith(model: model)

        return flyAwayCell
    }
}

extension FirstEntryViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return geometricParams.cellSize
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: geometricParams.leftInset, bottom: 10, right: geometricParams.rightInset)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return geometricParams.cellSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return geometricParams.cellSpacing
    }
}

extension FirstEntryViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let cyrillicChars = CharacterSet(charactersIn: "АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдеёжзийклмнопрстуфхцчшщъыьэюя\n")
        if string.rangeOfCharacter(from: cyrillicChars.inverted) != nil {
            return false
        }
        if string == "\n" {
            textField.resignFirstResponder()
            return false
        }
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        viewModel.fromTextFieldLastValue = textField.text
    }
}
