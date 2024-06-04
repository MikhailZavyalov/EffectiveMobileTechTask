
import UIKit

final class TicketsOffersFlightSettingsButton: UIView {

    init(image: String? = nil, text: String){

        let button: UIButton = {
            let button = UIButton()
            button.backgroundColor = UIColor.init(hexString: "2F3035")
            button.layer.cornerRadius = 16
            return button
        }()


        let imageView: UIImageView = {
            let imageView = UIImageView()
            return imageView
        }()

        let textLabel: UILabel = {
            let textLabel = UILabel()
            textLabel.text = text
            textLabel.textColor = .white
            textLabel.font = UIFont.regular14
            return textLabel
        }()

        super.init(frame: .zero)

        self.backgroundColor = UIColor.init(hexString: "2F3035")
        self.layer.cornerRadius = 50

        if image != nil {
            addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false

            button.addSubview(textLabel)
            textLabel.translatesAutoresizingMaskIntoConstraints = false

            imageView.image = UIImage(named: image ?? "")
            button.addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                button.topAnchor.constraint(equalTo: topAnchor),
                button.trailingAnchor.constraint(equalTo: trailingAnchor),
                button.bottomAnchor.constraint(equalTo: bottomAnchor),
                button.leadingAnchor.constraint(equalTo: leadingAnchor),

                imageView.topAnchor.constraint(equalTo: button.topAnchor, constant: 8),
                imageView.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 10),
                imageView.heightAnchor.constraint(equalToConstant: 16),
                imageView.widthAnchor.constraint(equalToConstant: 16),

                textLabel.topAnchor.constraint(equalTo: button.topAnchor, constant: 8),
                textLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8)
            ])
        } else {
            addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false

            button.addSubview(textLabel)
            textLabel.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                button.topAnchor.constraint(equalTo: topAnchor),
                button.trailingAnchor.constraint(equalTo: trailingAnchor),
                button.bottomAnchor.constraint(equalTo: bottomAnchor),
                button.leadingAnchor.constraint(equalTo: leadingAnchor),

                textLabel.topAnchor.constraint(equalTo: button.topAnchor, constant: 8),
                textLabel.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 10)
            ])
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
