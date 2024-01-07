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

extension UILabel: Configurable {
    struct Model {
        let text: NSAttributedString
        let numberOfLines: Int
        let textAlignment: NSTextAlignment
        
        init(
            text: NSAttributedString,
            numberOfLines: Int,
            textAlignment: NSTextAlignment
        ) {
            self.text = text
            self.numberOfLines = numberOfLines
            self.textAlignment = textAlignment
        }
        init(
            text: String,
            textFont: UIFont = .montserratSemiBold(ofSize: 14) ?? .systemFont(ofSize: 14),
            textColor: UIColor = .white,
            numberOfLines: Int = 0,
            textAlignment: NSTextAlignment = .left
        ) {
            let attributedText = NSMutableAttributedString(string: text)
            attributedText.addAttributes(
                [
                    .font: textFont,
                    .foregroundColor: textColor
                ],
                range: .init(location: 0, length: attributedText.length)
            )
            self.text = attributedText
            self.numberOfLines = numberOfLines
            self.textAlignment = textAlignment
        }
    }
    
    func update(model: Model) {
        self.attributedText = model.text
        self.numberOfLines = model.numberOfLines
        self.textAlignment = model.textAlignment
    }
}
