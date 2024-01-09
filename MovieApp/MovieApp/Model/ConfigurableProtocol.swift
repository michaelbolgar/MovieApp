//
//  ConfigureProtocol.swift
//  MovieApp
//
//  Created by Nikita Shirobokov on 29.12.23.
//

import Foundation

#warning("вряд ли этот файл должен быть в этой папке")
protocol Configurable {
    associatedtype Model

    func update(model: Model)
}
