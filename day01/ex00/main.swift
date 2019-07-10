import Foundation

print("Colors:")
for col in Color.allColors {
    print("\(col) = \(col.rawValue)")
}

print("\nValues:")
for val in Value.allValues {
    print("\(val) = \(val.rawValue)")
}

print(Color.allColors)
