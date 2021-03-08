import UIKit

class CategoryController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var catalogModel: CatalogModel?
    
    var categoryURL = URL(string: "https://catalog.api.onliner.by/schemas?limit=30&page=1")!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Category"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let closure: (Data) -> Void = { data in
            do {
                let catalog = try JSONDecoder().decode(Catalog.self, from: data)
                self.catalogModel = CatalogModel(catalog: catalog)
            
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
        }
    
        NetworkService.getData(url: categoryURL, callback: closure)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catalogModel?.catalog.schemas.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellСategory", for: indexPath)
        
        let catalogItemName = catalogModel?.catalog.schemas[indexPath.row].name
 
        
        cell.textLabel?.text = catalogItemName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productController = storyboard?.instantiateViewController(withIdentifier: "ProductController") as! ProductController
        productController.category = catalogModel?.catalog.schemas[indexPath.row].key

        show(productController, sender: self)
    }
    
}
