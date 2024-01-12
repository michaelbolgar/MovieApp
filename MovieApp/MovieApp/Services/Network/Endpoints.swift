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
    case getMovieByActor(actorID: Int)             //поиск related movies
    case getRandom                                  //запрос для экрана с ёлкой
    case getColletionMovieList(slug: String)
    case getImages(id: Int)

    var path: String {
        switch self {
        case .getCollections:
            return "/v1.4/list"
        case .getMoviesByCategory:
            return "/v1.4/movie"
        case .getPopular:
            return "/v1.4/movie"
        case .getMovieDetails(id: let id):
            return "/v1.4/movie/\(id)"
        case .doSearch:
            return "/v1.4/movie/search"
        case .getMovieByActor(actorID: let actorID):
            return "/v1.4/person/\(actorID)"
        case .getRandom:
            return "/v1.4/movie/random"
        case .getColletionMovieList:
            return "/v1.4/movie"
        case .getImages:
            return "/v1.4/image"
        }
    }
}
