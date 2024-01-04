import Foundation

struct API {
    static let scheme = "https"
    static let host = "api.kinopoisk.dev"
    static let apiKey = "QC4AKM6-2YZ42H6-NQT8M9Z-P1MC2JP"
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
        case .doSearch:
            if query != nil { parameters ["query"] = query }
            parameters ["number"] = "10"
        case .getCollections:
#warning("work in progress")
            print ("no func")
        case .getMovieByActor:
            parameters ["number"] = "10"
        case .getMovieDetails(id: let id):
            parameters["id"] = "\(id)"
        case .getMoviesByCategory:
            parameters ["number"] = "10"
        case .getPopular:
            parameters ["sort"] = "popularity"
            parameters ["number"] = "10"
        }

        return parameters
    }

    private func makeTask<T: Codable>(for url: URL, apiKey: String, using session: URLSession = .shared, completion: @escaping(Result<T, Error>) -> Void) {

        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "X-API-KEY")
        print("URL: \(url.absoluteString)")

        session.dataTask(with: request) {data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

#warning ("обработать все эти ошибки с выводом правильных сообщений через структуры")
            guard let httpResponse = response as? HTTPURLResponse else {
                let error = NSError(domain: "No HTTPURLResponse", code: 0, userInfo: nil)
                completion(.failure(error))
                return
            }

            let statusCode = httpResponse.statusCode

            if statusCode == 401 {
                print("Error: Unauthorized")
                let unauthorizedError = NSError(domain: "Unauthorized", code: 401, userInfo: nil)
                completion(.failure(unauthorizedError))
                return
            }

            guard let data = data else {
                let error =  NSError(domain: "No data", code: 0, userInfo: nil)
                completion(.failure(error))
                return
            }

            do {
                let decodeData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodeData))
                print (decodeData)
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    //MARK: - Public Methods

    /// Get full information about a movie
    func getMovieDetails(for id: Int, completion: @escaping(Result<MovieDetails, Error>) -> Void) {
        guard let url = createURL(for: .getMovieDetails(id: id)) else { return }
        makeTask(for: url, apiKey: API.apiKey, completion: completion)
    }
}
