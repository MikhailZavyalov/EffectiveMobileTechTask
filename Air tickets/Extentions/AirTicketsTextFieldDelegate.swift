
import UIKit

final class AirTicketsTextFieldDelegate: NSObject, UITextFieldDelegate {

    private let onEditingEnd: () -> Void

    init(onEditingEnd: @escaping () -> Void) {
        self.onEditingEnd = onEditingEnd
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
                let cyrillicChars = CharacterSet(charactersIn: "АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдеёжзийклмнопрстуфхцчшщъыьэюя\n")
                if string.rangeOfCharacter(from: cyrillicChars.inverted) != nil {
                    return false
                }
        if string == "\n" {
            textField.resignFirstResponder()
            return false
        }
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        onEditingEnd()
    }
}
