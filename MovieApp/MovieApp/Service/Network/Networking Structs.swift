
/**

 API работает по принципу REST, все запросы отправляются на адрес https://api.kinopoisk.dev/ с указанием версии API и необходимого ресурса.
 Все запросы к API кинопоиска должны содержать заголовок X-API-KEY с вашим токеном. В противном случае вы получите ошибку 401.
 При составлении запроса учитывайте, что все параметры должны быть в query и path. В зависимости от метода который вы используете. Например, вы хотите получить список фильмов за 2023 год в жанре криминал, тогда ваш запрос будет выглядеть так: https://api.kinopoisk.dev/v1.4/movie?year=2023&genres.name=криминал. Или вы хотите получить список фильмов с рейтингом выше 8, тогда ваш запрос будет выглядеть так: https://api.kinopoisk.dev/v1.4/movie?rating.imdb=8-10. Документация kinopoisk api может помочь вам составить нужный запрос, для этого воспользуйтесь ее конструктором

 Ключи в query параметрах имеют разные типы значений. В зависимости от типа значения, вы можете использовать разные операторы для фильтрации для поиска максимально релевантного фильма, сериала и т.д. в базе.
 Поля с типом Number могут принимать значения в форматах: rating.kp=1-10, rating.kp=1, year=2022&year=2023.
 Поля с типом Date могут принимать значения в форматах: premiere.russia=dd.mm.yyyy-dd.mm.yyyy, premiere.russia=dd.mm.yyyy.
 Поля с типом String могут принимать значения в форматах: genres.name=драма, genres.name=криминал, genres.name=криминал&genres.name=драма
 Поля с типом Boolean могут принимать значения в форматах: isSeries=true, isSeries=false.
 Параметры жанров и стран могут принимать операторы + и !, для указания включаемых и исключаемых значений. Например, вы хотите получить список фильмов в жанрах драма и криминал, тогда ваш запрос будет выглядеть так: genres.name=+драма&genres.name=+криминал. Или вы хотите получить список фильмов с жанром драма и без жанра криминал, тогда ваш запрос будет выглядеть так: genres.name=+драма&genres.name=!криминал.

**/

import Foundation

enum Endpoint {
    case getCollections
    case getMoviesByCategory(category: String)
    case getPopular
    case getMovieDetails(id: Int)
    case doSearch(request: String)
    case getMovieByActor(actor: String)             //поиск related movies
    case getRandom                                  //запрос для экрана с ёлкой

    var path: String {
        switch self {
        case .getCollections:
            return "/v1.4/list"
        case .getMoviesByCategory(category: let category):
            return ""
        case .getPopular:
            return "/v1.4/movie"
        case .getMovieDetails(id: let id):
            return "/v1.4/movie/\(id)"
        case .doSearch:
            return "/v1.4/movie/search"
        case .getMovieByActor(actor: let actor):
            return ""
        case .getRandom:
            return ""
        }
    }
}

//это будет отдельной структурой или внутри другой?
struct Poster: Codable {
    let url: String?
    let previewUrl: String?
    //https://avatars.mds.yandex.net/get-kinopoisk-image/1946459/428e2842-4157-45e8-a9af-1e5245e52c37/x1000
    //заменить часть кода на ключ?
}

struct Genre: Codable {
    let name: String
}

struct Rating: Codable {
    let imdb: Double?
    let kp: Double?
}

struct Cover: Codable {
#warning("подобрать дефолтную картинку для случае, когда нет обложки (так бывает)")
    let previewUrl: String?
}

struct MovieDetails: Codable {
    let name: String?               //RUS
    let year: Int?
    let description: String?        //RUS
    let rating: Rating?
    let movieLength: Int?
    let poster: Poster?
    let genres: [Genre]?            //RUS
    let persons: [Person]?

    struct Person: Codable {
        let enName: String?
        let enProfession: String?

//        let id: Int                   //вроде не нужно
//        let name: String              //если захотим перевести на русский
//        let profession: String        //если захотим перевести на русский
    }
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

    let docs: [SearchResult]

    struct SearchResult: Codable {
        let name: String?           //RUS
        let enName: String?
        let year: Int?
        let movieLength: Int?
        let rating: Rating
        let type: String?
        let poster: Poster
        let genres: [Genre]?
    }
}
