
import UIKit

final class PopularDestinationsModel {
    let mockData = [
        (image: "istanbul", title: "Стамбул"),
        (image: "sochi", title: "Сочи"),
        (image: "phuket", title: "Пхукет"),
    ]

    func loadCachedToTextFieldLastValue() -> String? {
        UserDefaultsManager.getString(key: .toTextFieldLastValue)
    }

    func saveToTextFieldLastValue(_ value: String?) {
        UserDefaultsManager.setString(value, key: .toTextFieldLastValue)
    }
}
