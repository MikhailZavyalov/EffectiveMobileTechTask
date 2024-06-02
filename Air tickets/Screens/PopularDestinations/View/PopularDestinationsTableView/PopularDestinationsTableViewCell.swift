
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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        contentView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        contentView.backgroundColor = UIColor.init(hexString: "2F3035")
        selectionStyle = .none

        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with model: PopularDestinationsTableViewCellModel) {
        image.image = UIImage(named: model.image)
        titleLabel.text = model.title
    }

    private func setupConstraints() {
        let titleAndSubtitleStackView = UIStackView(arrangedSubviews: [titleLabel, subTitleLabel])
        contentView.addSubview(titleAndSubtitleStackView)
        titleAndSubtitleStackView.axis = .vertical
        titleAndSubtitleStackView.spacing = 4
        titleAndSubtitleStackView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(separator)
        separator.translatesAutoresizingMaskIntoConstraints = false

        let constraints = [
            image.bottomAnchor.constraint(equalTo: separator.topAnchor, constant: -8),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            image.heightAnchor.constraint(equalToConstant: 40),
            image.widthAnchor.constraint(equalToConstant: 40),

//            titleAndSubtitleStackView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 24),
//            titleAndSubtitleStackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: 8),
            titleAndSubtitleStackView.bottomAnchor.constraint(equalTo: separator.topAnchor, constant: -8),
            titleAndSubtitleStackView.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8),

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
