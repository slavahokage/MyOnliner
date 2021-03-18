import Foundation

class CategoryPresenter: CategoryPresenterProtocol {
    
    private var networkService: NetworkService?
    
    private var catalogModel: CatalogModel?
    
    private unowned var categoryView: Upadatable
    
    private var categoryURL = URL(string: "https://catalog.api.onliner.by/schemas?limit=30&page=1")!
    
    init(categoryView: CategoryController) {
        self.categoryView = categoryView
        loadCategory()
    }
    
    func getCountOfCategory() -> Int {
        return catalogModel?.catalog.schemas.count ?? 0
    }
    
    func getCategoryInformation(index: Int) -> CatalogInformation? {
        return catalogModel?.catalog.schemas[index]
    }
    
    func loadCategory() {
        let closure: (Data) -> Void = { data in
            do {
                let catalog = try JSONDecoder().decode(Catalog.self, from: data)
                self.catalogModel = CatalogModel(catalog: catalog)
            
                DispatchQueue.main.async {
                    self.categoryView.updateUI()
                }
                
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
        }
    
        NetworkService.getData(url: categoryURL, callback: closure)
    }
}
