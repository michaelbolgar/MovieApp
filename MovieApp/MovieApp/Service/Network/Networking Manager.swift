import Foundation

struct API {
    static let scheme = "https"
    static let host = "api.kinopoisk.dev"
}

struct NetworkingManager {

    static let shared = NetworkingManager()

    private init() {}

    //MARK: Methods

    private func createURL (for endPoint: Endpoint, with query: String? = nil) -> URL? {
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = endPoint.path
//
//        components.queryItems = makeParameters(for: endPoint, with: query).compactMap {
//            URLQueryItem(name: $0.key, value: $0.value)

        return components.url
    }
}
