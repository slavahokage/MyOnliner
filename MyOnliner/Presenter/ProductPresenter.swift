import Foundation

class ProductPresenter: ProductPresenterProtocol {
    
    private var networkService: NetworkService?
    
    private var productModel: ProductModel?
    
    private unowned var productView: ProductControllerProtocol
    
    var categoryURL = URL(string: "https://catalog.api.onliner.by/schemas?limit=30&page=1")!
    
    init(productView: ProductControllerProtocol) {
        self.productView = productView
        loadProducts()
    }
    
    func getCountOfProducts() -> Int {
        return productModel?.products.products.count ?? 0
    }
    
    func getProduct(index: Int) -> Product? {
        return productModel?.products.products[index]
    }
    
    func cellTapped(index: Int) -> URL? {
        let urlOfProduct = productModel?.products.products[index].html_url
        
        return URL(string: urlOfProduct!)
    }
    
    func loadProducts() {
        
        let closure: (Data) -> Void = { data in
             do {
                let products = try JSONDecoder().decode(Products.self, from: data)
                self.productModel = ProductModel(products: products)
                
                DispatchQueue.main.async {
                    self.productView.updateUI()
                }
                     
                 
             } catch {
                 print("Error during JSON serialization: \(error.localizedDescription)")
             }
         }
         
        NetworkService.getData(url: URL(string: "https://catalog.api.onliner.by/search/\(self.productView.getCategory())?limit=30&page=1")!, callback: closure)
    }
}

