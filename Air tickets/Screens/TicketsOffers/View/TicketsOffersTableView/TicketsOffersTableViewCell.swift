
import UIKit

final class TicketsOffersTableViewCell: UITableViewCell {

    private let image: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = UIColor.init(hexString: "FF5E5E")
        return imageView
    }()

    private let titleLabel: UILabel = {
        let title = UILabel()
        title.font = UIFont.regular14
        title.textColor = .white
        title.text = "Уральские авиалинии"
        return title
    }()

    private var textForSubtitleLabel: [String] = []

    private let subTitleLabel: UILabel = {
        let subTitleLabel = UILabel()
        subTitleLabel.textColor = UIColor.init(hexString: "5E5F61")
        subTitleLabel.font = UIFont.regular14
        subTitleLabel.text = "07:00,  09:10,   10:00  11:00  12:00  13:00  12:00      "
        return subTitleLabel
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.regular14
        label.textColor = UIColor.init(hexString: "2261BC")
        label.text = "300"
        return label
    }()

    private let rightArrow: UIImageView = {
        let image = UIImage(named: "rightArrow")
        let imageView = UIImageView(image: image)
        return imageView
    }()

    private let separator: UIView = {
        let separator = UIView()
        separator.backgroundColor = UIColor.lightGray
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        return separator
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        contentView.backgroundColor = UIColor.init(hexString: "1D1E20")
        selectionStyle = .none

        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with model: TicketsOffersTableViewCellModel) {
        image.image = UIImage(named: model.image)
        titleLabel.text = model.title
        textForSubtitleLabel = model.timeRange
        subTitleLabel.text = "\(textForSubtitleLabel)"
        priceLabel.text = model.price
    }

    private func setupConstraints() {
        contentView.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(subTitleLabel)
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(rightArrow)
        rightArrow.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(priceLabel)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(separator)
        separator.translatesAutoresizingMaskIntoConstraints = false

        let constraints = [
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            image.heightAnchor.constraint(equalToConstant: 24),
            image.widthAnchor.constraint(equalToConstant: 24),

            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8),

            subTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -25),
            subTitleLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8),

            rightArrow.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            rightArrow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -27),
            rightArrow.widthAnchor.constraint(equalToConstant: 16),
            rightArrow.heightAnchor.constraint(equalToConstant: 16),

            priceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            priceLabel.trailingAnchor.constraint(equalTo: rightArrow.leadingAnchor),

            separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
        ]

        constraints.forEach {
            $0.priority = .defaultHigh
        }

        NSLayoutConstraint.activate(constraints)
    }
}

