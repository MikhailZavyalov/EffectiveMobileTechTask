
import UIKit

final class FlyAwayMusicallyViewCell: UICollectionViewCell {
    let reuseID = "cell"

    private var image: UIImageView = {
        var image = UIImage()
        var imageView = UIImageView(image: image)
        return imageView
    }()

    private var title: UILabel = {
        var title = UILabel()
        title.font = UIFont.boldText16
        title.textColor = .white
        return title
    }()

    private var town: UILabel = {
        var town = UILabel()
        town.font = UIFont.regular14
        town.textColor = .white
        return town
    }()

    private var airplaneImage: UIImageView = {
        var image = UIImage(named: "airTickets")
        var imageView = UIImageView(image: image)
        return imageView
    }()

    private var price: UILabel = {
        var price = UILabel()
        price.font = UIFont.regular14
        price.textColor = .white
        return price
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        

        contentView.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 16

        contentView.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.layer.masksToBounds = true

        contentView.addSubview(town)
        town.layer.masksToBounds = true
        town.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(airplaneImage)
        airplaneImage.translatesAutoresizingMaskIntoConstraints = false
        airplaneImage.layer.masksToBounds = true

        contentView.addSubview(price)
        price.translatesAutoresizingMaskIntoConstraints = false
        price.layer.masksToBounds = true

        let constraints = [
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            image.widthAnchor.constraint(equalToConstant: 133),
            image.heightAnchor.constraint(equalToConstant: 133),

            title.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 8),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),

            town.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            town.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),

            airplaneImage.topAnchor.constraint(equalTo: town.bottomAnchor, constant: 4),
            airplaneImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),

            price.topAnchor.constraint(equalTo: town.bottomAnchor, constant: 4),
            price.leadingAnchor.constraint(equalTo: airplaneImage.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureWith(model: FlyAwayMusicallyCellModel) {
        image.image = UIImage(named: model.id)
        title.text = model.title
        town.text = model.town
        price.text = model.price
    }
}
