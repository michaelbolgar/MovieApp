import UIKit

protocol HomePresenterProtocol {
    init(view: HomeViewControllerProtocol, storageManager: StorageManagerProtocol)
    var filmsData: [MovieCellModel] { get }
    var categoryData: [CatergoriesModel] { get }
    var categoriesFilmData: [PopularCategoryMovieCellModel] { get }
    func setUser()
}

final class HomePresenter: HomePresenterProtocol {

    private weak var view: HomeViewControllerProtocol?
    private let dataSource: StorageManagerProtocol
    
    //MARK: - Mock data
    var filmsData = [
        MovieCellModel(image: nil, name: "Marvel", description: "40 best movies"),
        MovieCellModel(image: nil, name: "Marvel", description: "40 best movies"),
        MovieCellModel(image: nil, name: "Marvel", description: "40 best movies"),
    ]
    
    var categoryData = [
        CatergoriesModel(name: "All"),
        CatergoriesModel(name: "Action"),
        CatergoriesModel(name: "Comedy"),
        CatergoriesModel(name: "Drama"),
        CatergoriesModel(name: "Horror"),
        CatergoriesModel(name: "Thriller"),
        CatergoriesModel(name: "Animation"),
    ]
    
    var categoriesFilmData = [
        PopularCategoryMovieCellModel(image: nil, name: "CgelovekPayk", ganre: "Action", rating: "4.9"),
        PopularCategoryMovieCellModel(image: nil, name: "CgelovekPayk", ganre: "Action", rating: "4.9"),
        PopularCategoryMovieCellModel(image: nil, name: "CgelovekPayk", ganre: "Action", rating: "4.9"),
        PopularCategoryMovieCellModel(image: nil, name: "CgelovekPayk", ganre: "Action", rating: "4.9"),
        PopularCategoryMovieCellModel(image: nil, name: "CgelovekPayk", ganre: "Action", rating: "4.9"),
    ]
    
    init(view: HomeViewControllerProtocol, storageManager: StorageManagerProtocol) {
        self.view = view
        self.dataSource = storageManager
    }
    
    func setUser() {
        guard let user = dataSource.fetchUser() else { return }
        view?.setUserInfo(with: user)
    }
}
