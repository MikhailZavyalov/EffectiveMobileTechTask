
import UIKit

final class PopularDestinationsButtonsView: UIButton {

    init(image: String) {
        let image = UIImage(named: image)

        super.init(frame: .zero)
        setImage(image, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
