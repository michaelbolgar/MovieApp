import Foundation

/// Names of categories on HomeScreen
enum Categories: String, Equatable {
    case action = "боевик"
    case comedy = "комедия"
    case horror = "ужасы"
    case drama = "драма"
    case anime = "аниме"
    case cartoon = "мультфильм"

    var stringValue: String {
        rawValue
    }
}

// MARK: - Small structs for arrays

/// Cover for movie
struct Poster: Codable {
    let url: String?            //this one is in high quality (as possible)
    let previewUrl: String?
}

/// Genre of movie
struct Genre: Codable {
    let name: String
}

/// Rating of movie
struct Rating: Codable {
    let imdb: Double?
    let kp: Double?
}

/// People related to movie
struct Person: Codable {
    let name: String                        //RUS
    let enName: String?
    let profession: String                  //RUS
    let enProfession: String?
    let photo: String?
    let id: Int?
}

// MARK: - Structs for different requests

/// Short description (for cells)
struct MovieInfoForCell: Codable {
    let id: Int?
    let name: String?                       //RUS
    let enName: String?                     //ENG
    let genres: [Genre]?
    let rating: Rating
    let poster: Poster?
    let year: Int?
    let type: String?
    let movieLength: Int?
}

/// Standard cell info (for PopularMovie Screen, Movies of the tapped cell, etc.
struct MovieShortInfo: Codable {
    let docs: [MovieInfoForCell]
}

/// Cell in the collectionView on HomeScreen
struct Collections: Codable {
    let docs: [Collection]

    struct Collection: Codable {
        let name: String?
        let cover: Poster?
        let slug: String?                   //needed for getting of the collection movies
        let moviesCount: Int?
    }
}

// MARK: - Structs for MovieDetails Screen

/// Detailed description of movie
struct FullMovieInfo: Codable {
    let name: String?               //RUS
    let enName: String?
    let year: Int?
    let description: String?        //RUS
    let rating: Rating?
    let movieLength: Int?
    let poster: Poster?
    let genres: [Genre]?            //RUS
    let persons: [Person]?
    let type: String?
}

/// Screenshots from movie on MovieDetails Screen
struct Gallery: Codable {
    let docs: [Poster]
}

/// 'Cast and Crew' info on MovieDetails Screen
struct PersonInfo: Codable {
//    let id: Int?
    let enName: String?
    let movies: [Filmography]

    /// Movies related to a person
    struct Filmography: Codable {
        let id: Int?                        //id фильма -- понадобится для тапа на ячейку
        let name: String?                   //RUS
        let alternativeName: String?        //ENG
        let rating: Double?
        let description: String?            //это имя героя в фильме -- можно вставить для красоты (хз что прилетит для не актёров)
        let enProfession: String?
    }
}
