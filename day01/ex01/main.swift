import Foundation

let card1 = Card(Color.dim, Value.Jack)
let card2 = Card(Color.dim, Value.Ace)
let card3 = Card(Color.sp, Value.Ace)
let card4 = Card(Color.dim, Value.Jack)

print("First card: \(card1)")
print("Second card: \(card2)")
print("Third card: \(card3)")
print("Fourth card: \(card4)")

print("\nCompare using isEqual():")
print("     First and second: \(card1.isEqual(card2))")
print("     First and third: \(card1.isEqual(card3))")
print("     Second and third: \(card2.isEqual(card3))")
print("     First and fourth: \(card1.isEqual(card4))")

print("\nCompare using \"==\"")
print("     First and second: \(card1 == card2)")
print("     First and third: \(card1 == card3)")
print("     Second and third: \(card2 == card3)")
print("     First and fourth: \(card1 == card4)")
