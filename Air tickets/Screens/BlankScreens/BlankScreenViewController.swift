
import UIKit

final class BlankScreenViewController: UIViewController {

    private var blankTitle: UILabel = {
        let label = UILabel()
        label.text = "Something"
        label.font = .boldText22
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupConstraints()
    }

    init(blankTitleText: String) {
        self.blankTitle.text = blankTitleText
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        view.addSubview(blankTitle)
        blankTitle.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            blankTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 26),
            blankTitle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -98),
            blankTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 90),

        ])
    }
}
