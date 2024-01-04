import Foundation

/// Small structs for arrays
struct Poster: Codable {
    let url: String?
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

//        let id: Int                   //вроде не нужно
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
    }
}

struct PopularMovies: Codable {

    let docs: [PopularMovie]

    struct PopularMovie: Codable {
        let name: String?
        let genre: [Genre]?
        let rating: Rating
        let poster: Cover?          //как вариант попробовать let backdrop с тем же типом данных
        let id: Int?                //нужно для идентфикации коллекции при тапе на ячейку
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
