
import UIKit

final class StubScreen: UIViewController {

    private let returnOnPreviousScreenButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backArrow"), for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        returnOnPreviousScreenButton.addTarget(self, action: #selector(returnOnPreviousScreen), for: .touchUpInside)

        setupConstraints()
    }

    @objc func returnOnPreviousScreen() {
        self.dismiss(animated: true)
    }

    private func setupConstraints() {
        view.addSubview(returnOnPreviousScreenButton)
        returnOnPreviousScreenButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            returnOnPreviousScreenButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            returnOnPreviousScreenButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            returnOnPreviousScreenButton.heightAnchor.constraint(equalToConstant: 24),
            returnOnPreviousScreenButton.widthAnchor.constraint(equalToConstant: 24),
        ])
    }
}
