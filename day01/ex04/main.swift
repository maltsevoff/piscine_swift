import Foundation

var sortedGame = Deck(true)
var unsortedGame = Deck(false)

print("Sorted:")
print(sortedGame)

print("\nUnsorted")
print(unsortedGame)

var tmp: Card?

print("\n")
for _ in 1...10 {
    tmp = unsortedGame.draw()
    print("\(tmp!) the card taken")
}

print("\nStart game:")
print(unsortedGame)
print(unsortedGame.outs)
print(unsortedGame.disards)

for val in Value.allValues {
    let card = Card(Color.sp, val)
    unsortedGame.fold(c: card)
}
print("\nDelete Spades from outs:")
print(unsortedGame)
print(unsortedGame.outs)
print(unsortedGame.disards)
