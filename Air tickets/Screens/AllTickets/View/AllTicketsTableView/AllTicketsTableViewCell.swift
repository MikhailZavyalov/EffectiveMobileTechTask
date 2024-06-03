
import UIKit

final class AllTicketsTableViewCell: UITableViewCell {

    private let badge: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.layer.cornerRadius = 50
        label.backgroundColor = UIColor(hexString: "#2261BC")
        return label
    }()

    private let price: UILabel = {
        let label = UILabel()
        label.textColor = .white
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
        return label
    }()

    private let flightTime: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()

    private let noTransfers: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()

    private let departureAirport: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "9F9F9F")
        return label
    }()

    private let arrivalAirport: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "9F9F9F")
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.init(hexString: "1D1E20")
        contentView.layer.cornerRadius = 16
        backgroundColor = .clear
        selectionStyle = .none
        layer.masksToBounds = true

        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func configure(with model: AllTicketsTableViewCellModel) {
        badge.text = model.badge
        price.text = model.price
        departureAndArrivalTime.text = "\(model.departureTime)-\(model.arrivalTime)"
        flightTime.text = model.flightTime
        noTransfers.text = model.noTransfers
        departureAirport.text = model.departureAirport
        arrivalAirport.text = model.arrivalAirport
    }

    private func setupConstraints() {
        contentView.addSubview(badge)
        badge.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(price)
        price.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(departureAndArrivalTime)
        departureAndArrivalTime.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(flightTime)
        flightTime.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(noTransfers)
        noTransfers.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(departureAirport)
        departureAirport.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(arrivalAirport)
        arrivalAirport.translatesAutoresizingMaskIntoConstraints = false

        let constraints = [
            badge.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -8),
            badge.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            badge.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -104),

            price.topAnchor.constraint(equalTo: badge.bottomAnchor, constant: 8),
            price.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            image.topAnchor.constraint(equalTo: price.bottomAnchor, constant: 23),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
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

