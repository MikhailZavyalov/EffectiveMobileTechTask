
import Foundation

enum UserDefaultsManager {

    enum Key: String {
        case fromTextFieldLastValue
        case toTextFieldLastValue
    }

    private static let userDefaults = UserDefaults.standard

    static func getString(key: Key) -> String? {
        userDefaults.string(forKey: key.rawValue)
    }

    static func setString(_ string: String?, key: Key) {
        userDefaults.set(string, forKey: key.rawValue)
    }
}
