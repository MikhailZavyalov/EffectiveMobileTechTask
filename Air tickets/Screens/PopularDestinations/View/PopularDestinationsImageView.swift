
import UIKit

final class PopularDestinationsImageView: UIView {

    init(image: String, text: String) {
        let popupImage = UIImage(named: image)
        let popupImageView = UIImageView(image: popupImage)
        let popupText = UILabel()
        popupText.text = text
        popupText.textAlignment = .center
        popupText.numberOfLines = 2
        popupText.font = UIFont.regular14
        popupText.textColor = .white

        let vStack = UIStackView(arrangedSubviews: [popupImageView, popupText])
        vStack.axis = .vertical
        vStack.spacing = 8
        vStack.alignment = .center

        super.init(frame: .zero)

        addSubview(vStack)
        vStack.translatesAutoresizingMaskIntoConstraints = false
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: topAnchor),
            vStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            vStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            vStack.leadingAnchor.constraint(equalTo: leadingAnchor),

            popupImageView.heightAnchor.constraint(equalToConstant: 48),
            popupImageView.widthAnchor.constraint(equalToConstant: 48),

            popupText.widthAnchor.constraint(equalToConstant: 83),
            popupText.heightAnchor.constraint(equalToConstant: 34),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
