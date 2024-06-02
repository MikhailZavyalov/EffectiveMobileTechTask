
import UIKit

final class PopularDestinationsModel {
    let mockData = [
        (image: "istanbul", title: "Стамбул"),
        (image: "sochi", title: "Сочи"),
        (image: "phuket", title: "Пхукет"),
    ]

    func loadCachedFromTextFieldLastValue() -> String? {
        UserDefaultsManager.getString(key: .fromTextFieldLastValue)
    }
}
