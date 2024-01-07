//
//  ConfigureProtocol.swift
//  MovieApp
//
//  Created by Nikita Shirobokov on 29.12.23.
//

import Foundation

protocol Configurable {
    associatedtype Model
    
    func update(model: Model)
}
