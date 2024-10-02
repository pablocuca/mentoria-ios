import UIKit

struct Exercise: Codable {
    let index: Int
    let title: String
    let description: String
    let colorHex: String

    var color: UIColor {
        return UIColor(hex: colorHex)
    }
}
