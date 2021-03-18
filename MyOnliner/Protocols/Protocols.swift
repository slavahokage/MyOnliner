import Foundation

protocol ProductControllerProtocol: Upadatable {
    func getCategory() -> String
}

protocol Upadatable: AnyObject {
    func updateUI()
}

protocol CategoryPresenterProtocol: AnyObject {
    func getCountOfCategory() -> Int
    func loadCategory()
    func getCategoryInformation(index: Int) -> CatalogInformation?
}

protocol ProductPresenterProtocol {
    func getCountOfProducts() -> Int
    func loadProducts()
    func getProduct(index: Int) -> Product?
    func cellTapped(index: Int) -> URL?
}
