
import UIKit

final class PopularDestinationsTableViewCell: UITableViewCell {

    private let image: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private let titleLabel: UILabel = {
        let title = UILabel()
        title.font = UIFont.boldText16
        title.textColor = .white
        return title
    }()

    private let subTitleLabel: UILabel = {
        let subTitleLabel = UILabel()
        subTitleLabel.textColor = UIColor.init(hexString: "5E5F61")
        subTitleLabel.font = UIFont.regular14
        subTitleLabel.text = "Популярное направление"
        return subTitleLabel
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
        backgroundColor = .clear
        contentView.backgroundColor = UIColor.init(hexString: "2F3035")
        contentView.layer.cornerRadius = 16
        selectionStyle = .none

        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with model: PopularDestinationsTableViewCellModel, isFirst: Bool, isLast: Bool) {
        image.image = UIImage(named: model.image)
        titleLabel.text = model.title
        
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
        let titleAndSubtitleStackView = UIStackView(arrangedSubviews: [titleLabel, subTitleLabel])
        contentView.addSubview(titleAndSubtitleStackView)
        titleAndSubtitleStackView.axis = .vertical
        titleAndSubtitleStackView.spacing = 4
        titleAndSubtitleStackView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
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
            image.bottomAnchor.constraint(equalTo: separator.topAnchor, constant: -8),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            image.heightAnchor.constraint(equalToConstant: 40),
            image.widthAnchor.constraint(equalToConstant: 40),

            titleAndSubtitleStackView.bottomAnchor.constraint(equalTo: separator.topAnchor, constant: -8),
            titleAndSubtitleStackView.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8),
            
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
