import Foundation

class Card: NSObject {
    var color: Color
    var value: Value
    init(_ color: Color,_ value: Value) {
        self.color = color
        self.value = value
    }
    override var description: String {
        return ("[\(color.rawValue) \(value)]")
    }
    override func isEqual(_ object: Any?) -> Bool {
        if let object = object as? Card{
            return object.color == self.color && object.value == self.value
        } else {
            return false
        }
    }
    static func == (lft: Card, rght: Card) -> Bool {
        return lft.color == rght.color && lft.value == rght.value
    }
}
