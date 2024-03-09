import Foundation

protocol Configurable {
    associatedtype Model

    func update(model: Model)
}
