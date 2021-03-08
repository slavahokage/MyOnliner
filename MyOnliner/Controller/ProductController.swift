import UIKit

class ProductController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var productModel: ProductModel?
    
    var category: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Products"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let closure: (Data) -> Void = { data in
             do {
                let products = try JSONDecoder().decode(Products.self, from: data)
                self.productModel = ProductModel(products: products)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                     
                 
             } catch {
                 print("Error during JSON serialization: \(error.localizedDescription)")
             }
         }
         
        NetworkService.getData(url: URL(string: "https://catalog.api.onliner.by/search/\(self.category!)?limit=30&page=1")!, callback: closure)
        
    }
    
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return productModel?.products.products.count ?? 0
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "cellProduct", for: indexPath) as! ProductCell
           
            let product = productModel?.products.products[indexPath.row]
    
           cell.setProduct(product: product!)
           
           return cell
       }
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let urlOfProduct = productModel?.products.products[indexPath.row].html_url
        
           if let url = URL(string: urlOfProduct!) {
               UIApplication.shared.open(url)
           }
       }
}

