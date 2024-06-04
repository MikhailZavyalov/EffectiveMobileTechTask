
import UIKit

final class AllTicketsTableViewCell: UITableViewCell {

    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = false
        return view
    }()

    private let badge: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.backgroundColor = UIColor(hexString: "#2261BC")
        label.font = UIFont.regular14
        label.textAlignment = .center
        return label
    }()

    private let price: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldText22
        return label
    }()

    private let image: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor.init(hexString: "FF5E5E")
        return view
    }()

    private let departureAndArrivalTime: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.regular14
        return label
    }()

    private let flightTime: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.regular14
        return label
    }()

    private let noTransfers: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.regular14
        return label
    }()

    private let departureAirport: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "9F9F9F")
        label.font = UIFont.regular14
        return label
    }()

    private let arrivalAirport: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "9F9F9F")
        label.font = UIFont.regular14
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 16
        backgroundColor = .clear
        selectionStyle = .none
        layer.masksToBounds = false

        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func configure(with model: AllTicketsTableViewCellModel) {
        badge.text = model.badge
        price.text = model.price + " ₽"
        departureAndArrivalTime.text = "\(model.departureTime)-\(model.arrivalTime)"
        flightTime.text = model.flightTime
        noTransfers.text = model.noTransfers
        departureAirport.text = model.departureAirport
        arrivalAirport.text = model.arrivalAirport
    }

    private func setupConstraints() {
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false

        containerView.addSubview(badge)
        badge.translatesAutoresizingMaskIntoConstraints = false

        containerView.addSubview(price)
        price.translatesAutoresizingMaskIntoConstraints = false

        containerView.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false

        containerView.addSubview(departureAndArrivalTime)
        departureAndArrivalTime.translatesAutoresizingMaskIntoConstraints = false

        containerView.addSubview(flightTime)
        flightTime.translatesAutoresizingMaskIntoConstraints = false

        containerView.addSubview(noTransfers)
        noTransfers.translatesAutoresizingMaskIntoConstraints = false

        containerView.addSubview(departureAirport)
        departureAirport.translatesAutoresizingMaskIntoConstraints = false

        containerView.addSubview(arrivalAirport)
        arrivalAirport.translatesAutoresizingMaskIntoConstraints = false

        let constraints = [
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),

            badge.topAnchor.constraint(equalTo: containerView.topAnchor, constant: -8),
            badge.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
            badge.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -104),

            price.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            price.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            price.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -77),

            image.topAnchor.constraint(equalTo: price.bottomAnchor, constant: 23),
            image.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            image.heightAnchor.constraint(equalToConstant: 24),
            image.widthAnchor.constraint(equalToConstant: 24),

            departureAndArrivalTime.topAnchor.constraint(equalTo: price.bottomAnchor, constant: 16),
            departureAndArrivalTime.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8),

            flightTime.topAnchor.constraint(equalTo: price.bottomAnchor, constant: 16),
            flightTime.leadingAnchor.constraint(equalTo: departureAndArrivalTime.trailingAnchor, constant: 13),

            noTransfers.topAnchor.constraint(equalTo: price.bottomAnchor, constant: 16),
            noTransfers.leadingAnchor.constraint(equalTo: flightTime.trailingAnchor, constant: 0),

            departureAirport.topAnchor.constraint(equalTo: departureAndArrivalTime.bottomAnchor, constant: 4),
            departureAirport.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8),

            arrivalAirport.topAnchor.constraint(equalTo: departureAndArrivalTime.bottomAnchor, constant: 4),
            arrivalAirport.leadingAnchor.constraint(equalTo: departureAirport.trailingAnchor, constant: 26),
        ]

        constraints.forEach {
            $0.priority = .defaultHigh
        }

        NSLayoutConstraint.activate(constraints)
    }
}

