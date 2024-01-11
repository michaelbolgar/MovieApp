import Foundation

enum NetworkError: Error {
    case transportError(Error)
    case serverError(statusCode: Int)
    case noData
    case decodingError(Error)
}

struct NetworkingManager {

    static let shared = NetworkingManager()

    private init() {}

    //MARK: - Private Methods

    private func createURL (for endPoint: Endpoint, with query: String? = nil) -> URL? {
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = endPoint.path

        components.queryItems = makeParameters(for: endPoint, with: query).compactMap {
            URLQueryItem(name: $0.key, value: $0.value)
        }

        return components.url
    }

    /// Make dictionary of parameters for URL request
    private func makeParameters(for endpoint: Endpoint, with query: String?) -> [String: String] {
        var parameters = [String: String]()
        parameters["apiKey"] = API.apiKey

        switch endpoint {
        case .doSearch (request: let request):
            parameters ["number"] = "10"
            parameters ["query"] = "\(request)"
        case .getCollections:
//            parameters ["page"] = "1"
            parameters ["number"] = "10"
            parameters ["category"] = "Фильмы"
        case .getMovieByActor(actor: let actor):
            parameters ["number"] = "10"
        case .getMovieDetails(id: let id):
            parameters ["id"] = "\(id)"
        case .getMoviesByCategory(category: let category):
            parameters ["number"] = "10"
        case .getPopular:
            parameters ["page"] = "1"
            parameters ["number"] = "20"
            parameters ["lists"] = "top250"
        case .getRandom:
            //что тут?
            parameters [""] = ""
        case .getColletionMovieList(slug: let slug):
            parameters ["lists"] = "\(slug)"
        case .getImages(id: let id):
            parameters ["movieId"] = "\(id)"
        }

        return parameters
    }

    private func makeTask<T: Codable>(for url: URL, apiKey: String, using session: URLSession = .shared, completion: @escaping(Result<T, NetworkError>) -> Void) {

        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "X-API-KEY")
//        print("URL: \(url.absoluteString)") /*принт сгенерированного url*/

        session.dataTask(with: request) {data, response, error in
            if let error = error {
                completion(.failure(.transportError(error)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                let error = NSError(domain: "No HTTPURLResponse", code: 0, userInfo: nil)
                completion(.failure(.serverError(statusCode: error.code)))
                return
            }

            let statusCode = httpResponse.statusCode

            #warning ("обработать эти ошибки через структуру с сервера?")

            /// Error handling: authorization error
            if statusCode == 401 {
                let unauthorizedError = NSError(domain: "Unauthorized", code: 401, userInfo: nil)
                completion(.failure(.serverError(statusCode: statusCode)))
                print ("Error \(statusCode). Unauthorized")
                return
            }

            /// Error handling: daily request limit exceeded
            if statusCode == 403 {
                let exceededLimitError = NSError(domain: "Forbidden", code: 403, userInfo: nil)
                completion(.failure(.serverError(statusCode: statusCode)))
                print ("Error \(statusCode). Daily request limit exceeded")
                return
            }

            guard let data = data else {
                let error =  NSError(domain: "No data", code: 0, userInfo: nil)
                completion(.failure(.noData))
                return
            }

            do {
                let decodeData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodeData))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }.resume()
    }

    //MARK: - Public Methods

    /// Get categories for HomeScreen
    func getCollections(completion: @escaping(Result<Collections, NetworkError>) -> Void) {
        guard let url = createURL(for: .getCollections) else { return }
        makeTask(for: url, apiKey: API.apiKey, completion: completion)
    }

    /// Get movies for collections in the above collection on HomeScreen
    func getColletionMovieList(for slug: String, completion: @escaping(Result<PopularMovies, NetworkError>) -> Void) {
        guard let url = createURL(for: .getColletionMovieList(slug: slug)) else { return }
        makeTask(for: url, apiKey: API.apiKey, completion: completion)
    }

    /// Get popular movie list (top 20)
    func getPopular(completion: @escaping(Result<PopularMovies, NetworkError>) -> Void) {
        guard let url = createURL(for: .getPopular) else { return }
        makeTask(for: url, apiKey: API.apiKey, completion: completion)
    }

//    func getMoviesByCategory(for category: String, completion: @escaping(Result<???, NetworkError>) -> Void) {
//        guard let url = createURL(for: .getMoviesByCategory(category: category)) else { return }
//        makeTask(for: url, apiKey: API.apiKey, completion: completion)
//    }

    /// Get full information about a movie
    #warning ("при запросе деталей фильма ограничить массив актёров семью персоналиями")
    func getMovieDetails(for id: Int, completion: @escaping(Result<MovieDetails, NetworkError>) -> Void) {
        guard let url = createURL(for: .getMovieDetails(id: id)) else { return }
        makeTask(for: url, apiKey: API.apiKey, completion: completion)
    }

    /// Get images for gallery in Movie Details
    func getImages(for id: Int, completion: @escaping(Result<Gallery, NetworkError>) -> Void) {
        guard let url = createURL(for: .getImages(id: id)) else { return }
        makeTask(for: url, apiKey: API.apiKey, completion: completion)
    }

//    func getMovieByActor(for actor: String, completion: @escaping(Result<???, NetworkError>) -> Void) {
//        guard let url = createURL(for: .getMovieByActor(actor: actor)) else { return }
//        makeTask(for: url, apiKey: API.apiKey, completion: completion)
//    }

    func doSearch(for request: String, completion: @escaping(Result<SearchResults, NetworkError>) -> Void) {
        guard let url = createURL(for: .doSearch(request: request)) else { return }
        makeTask(for: url, apiKey: API.apiKey, completion: completion)
    }

//    func getRandom(completion: @escaping(Result<MovieDetails, NetworkError>) -> Void) {
//        guard let url = createURL(for: .getRandom) else { return }
//        makeTask(for: url, apiKey: API.apiKey, completion: completion)
//    }
}
