import Foundation

class Deck: NSObject {
    static let allSpades: [Card] = Value.allValues.map{Card(Color.sp, $0)}
    static let allDiamonds: [Card] = Value.allValues.map{Card(Color.dim, $0)}
    static let allHearts: [Card] = Value.allValues.map{Card(Color.he, $0)}
    static let allClubs: [Card] = Value.allValues.map{Card(Color.cl, $0)}
    static let allCards: [Card] = allSpades + allDiamonds + allHearts + allClubs
}
