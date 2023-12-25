import UIKit

extension UILabel {

    static func makeLabel(text: String = "", font: UIFont?, textColor: UIColor, numberOfLines: Int?) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = textColor
        label.numberOfLines = numberOfLines ?? 0
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
