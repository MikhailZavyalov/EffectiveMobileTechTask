
import UIKit

final class TicketsOffersFlightSettingsButton: UIView {

    init(image: String? = nil, text: String){

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
        self.layer.cornerRadius = 16

        if image != nil {

            addSubview(textLabel)
            textLabel.translatesAutoresizingMaskIntoConstraints = false

            imageView.image = UIImage(named: image ?? "")
            addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
                imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
                imageView.heightAnchor.constraint(equalToConstant: 16),
                imageView.widthAnchor.constraint(equalToConstant: 16),

                textLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
                textLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8)
            ])
        } else {
            addSubview(textLabel)
            textLabel.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                textLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
                textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
            ])
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
