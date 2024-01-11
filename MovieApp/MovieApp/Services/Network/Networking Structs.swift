import Foundation

/// Categories names on HomeScreen
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

#warning("сделать универсальную структуру Doc")

/// Small structs for arrays
struct Poster: Codable {
    let url: String?            //this one is in high quality (as possible)
    let previewUrl: String?
    #warning("надо проверить прилетающие картинки на большом количестве фильмов. Возможно запрос logo будет тоже релевантным")
}

struct Cover: Codable {
    #warning("подобрать дефолтную картинку для случае, когда нет обложки (так бывает)")
    let previewUrl: String?
}

struct Genre: Codable {
    let name: String
}

struct Rating: Codable {
    let imdb: Double?
    let kp: Double?
}

struct Person: Codable {
    let enName: String?
    let enProfession: String?
    let photo: String?
    let id: Int?

//        let name: String              //если захотим перевести на русский
//        let profession: String        //если захотим перевести на русский
}

/// Structs for different requests
struct MovieDetails: Codable {
    let name: String?               //RUS
    let enName: String?
    let year: Int?
    let description: String?        //RUS
    let rating: Rating?
    let movieLength: Int?
    let poster: Poster?
    let genres: [Genre]?            //RUS
    let persons: [Person]?
}

struct Collections: Codable {

    let docs: [Collection]

    struct Collection: Codable {
        let name: String?
        //    let id: String?                     //нужно для идентфикации коллекции при тапе на ячейку
        let cover: Cover?
        let slug: String?
        let moviesCount: Int?
    }
}

struct PopularMovies: Codable {

    let docs: [PopularMovie]

    struct PopularMovie: Codable {
        let name: String?
        let genres: [Genre]?
        let rating: Rating
        let poster: Cover?          //как вариант попробовать let backdrop с тем же типом данных
        let id: Int?                //нужно для идентфикации коллекции при тапе на ячейку
        let year: Int?
        let type: String?
        let movieLength: Int?

    }
}

struct SearchResults: Codable {

    let docs: [MovieDetails]

#warning("использовать тут уникальную структуру SearchResult или взять MovieDetails? ")
//    struct SearchResult: Codable {
//        let name: String?           //RUS
//        let enName: String?
//        let year: Int?
//        let movieLength: Int?
//        let rating: Rating
//        let type: String?
//        let poster: Poster
//        let genres: [Genre]?
//    }
}

struct Gallery: Codable {

    let docs: [Poster]
}
