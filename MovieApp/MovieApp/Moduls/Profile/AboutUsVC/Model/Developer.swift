//
//  Developer.swift
//  MovieApp
//
//  Created by Kirill Taraturin on 26.12.2023.
//

import Foundation

struct Developer {
    let role: String
    let githubLink: String
    let image: String
    
    static func getTeam() -> [Developer] {
        [
            Developer(role: "Team Leader", githubLink: "michaelbolgar", image: "1"),
            Developer(role: "Developer", githubLink: "kornilov-ux", image: "2"),
            Developer(role: "Developer", githubLink: "Privetyanikita", image: "3"),
            Developer(role: "Developer", githubLink: "YO1901", image: "4"),
            Developer(role: "Developer", githubLink: "ShirobokovNikita", image: "5"),
            Developer(role: "Developer", githubLink: "Zarkan1204", image: "6"),
            Developer(role: "Developer", githubLink: "Kirilloao", image: "7"),
        ]
    }
}
