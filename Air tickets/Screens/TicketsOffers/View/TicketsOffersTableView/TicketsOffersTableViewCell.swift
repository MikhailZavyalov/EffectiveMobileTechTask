
import UIKit

final class TicketsOffersTableViewCell: UITableViewCell {

    private let image: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor.init(hexString: "FF5E5E")
        return view
    }()

    private let titleLabel: UILabel = {
        let title = UILabel()
        title.font = UIFont.regular14
        title.textColor = .white
        title.text = "Уральские авиалинии"
        return title
    }()

    private let subTitleLabel: UILabel = {
        let subTitleLabel = UILabel()
        subTitleLabel.textColor = UIColor.white
        subTitleLabel.font = UIFont.regular14
        return subTitleLabel
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.regular14
        label.textColor = UIColor.init(hexString: "2261BC")
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

    private var topConstraint: NSLayoutConstraint?
    private var bottomConstraint: NSLayoutConstraint?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        contentView.backgroundColor = UIColor.init(hexString: "1D1E20")
        backgroundColor = .clear
        selectionStyle = .none

        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with model: TicketsOffersTableViewCellModel, isFirst: Bool, isLast: Bool) {
        image.backgroundColor = UIColor(hexString: model.color)
        titleLabel.text = model.title
        subTitleLabel.text = model.timeRange
        priceLabel.text = model.price

        topConstraint?.constant = isFirst ? 24 : 16
        bottomConstraint?.constant = isLast ? -16 : 0

        contentView.layer.maskedCorners = []
        if isFirst {
            contentView.layer.maskedCorners.insert(.layerMinXMinYCorner)
            contentView.layer.maskedCorners.insert(.layerMaxXMinYCorner)
        }
        if isLast {
            contentView.layer.maskedCorners.insert(.layerMinXMaxYCorner)
            contentView.layer.maskedCorners.insert(.layerMaxXMaxYCorner)
        }
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

        topConstraint = image.topAnchor.constraint(
            equalTo: contentView.topAnchor,
            constant: 16
        )

        bottomConstraint = separator.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor,
            constant: 0
        )

        let constraints = [
            topConstraint!,
            image.bottomAnchor.constraint(equalTo: separator.topAnchor, constant: -20),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            image.heightAnchor.constraint(equalToConstant: 24),
            image.widthAnchor.constraint(equalToConstant: 24),

            titleLabel.topAnchor.constraint(equalTo: image.topAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8),

            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subTitleLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8),

            rightArrow.topAnchor.constraint(equalTo: image.topAnchor, constant: 0),
            rightArrow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -27),
            rightArrow.widthAnchor.constraint(equalToConstant: 16),
            rightArrow.heightAnchor.constraint(equalToConstant: 16),

            priceLabel.topAnchor.constraint(equalTo: image.topAnchor, constant: 0),
            priceLabel.trailingAnchor.constraint(equalTo: rightArrow.leadingAnchor),

            bottomConstraint!,
            separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
        ]

        constraints.forEach {
            $0.priority = .defaultHigh
        }

        NSLayoutConstraint.activate(constraints)
    }
}

