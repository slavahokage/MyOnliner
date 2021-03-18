import UIKit

class ProductController: UIViewController, UITableViewDataSource, UITableViewDelegate, ProductControllerProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var productPresenter: ProductPresenterProtocol?
    
    private var category: String?
    
        override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Products"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.productPresenter = ProductPresenter(productView: self)
        self.productPresenter?.loadProducts()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productPresenter?.getCountOfProducts() ?? 0
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellProduct", for: indexPath) as! ProductCell
           
        let product = productPresenter?.getProduct(index: indexPath.row)
    
        cell.setProduct(product: product!)
           
        return cell
       }
       
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let url = productPresenter?.cellTapped(index: indexPath.row)
        UIApplication.shared.open(url!)
    }
    
    func getCategory() -> String {
        return category!
    }
    
    func setCategory(category: String) {
        self.category = category
    }
    
    func updateUI() {
        self.tableView.reloadData()
    }
}
