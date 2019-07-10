import Foundation

class Deck: NSObject {
    static let allSpades: [Card] = Value.allValues.map{Card(Color.sp, $0)}
    static let allDiamonds: [Card] = Value.allValues.map{Card(Color.dim, $0)}
    static let allHearts: [Card] = Value.allValues.map{Card(Color.he, $0)}
    static let allClubs: [Card] = Value.allValues.map{Card(Color.cl, $0)}
    static let allCards: [Card] = allSpades + allDiamonds + allHearts + allClubs
    
    var cards: [Card] = allCards
    var disards: [Card] = []
    var outs: [Card] = []
    init(_ sortOrNot: Bool) {
        if sortOrNot == false {
            self.cards.shuffle()
        }
    }
    override var description: String {
        return "\(cards)"
    }
    func draw() -> Card? {
        self.outs.append(cards.first!)
        cards.remove(at: 0)
        return self.outs.last
    }
    func fold (c: Card) {
        if self.outs.contains(c) {
            self.disards.append(c)
            let ind = self.outs.lastIndex(of: c)
            self.outs.remove(at: ind!)
        }
    }
}

extension Array {
    mutating func meshat() {
        self.shuffle()
    }
}
