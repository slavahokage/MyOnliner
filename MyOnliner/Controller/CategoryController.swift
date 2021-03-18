import UIKit

class CategoryController: UIViewController, UITableViewDataSource, UITableViewDelegate, Upadatable {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var categoryPresenter: CategoryPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Category"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.categoryPresenter = CategoryPresenter(categoryView: self)
        self.categoryPresenter?.loadCategory()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryPresenter?.getCountOfCategory() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellСategory", for: indexPath)
        
        let catalogItemName = categoryPresenter?.getCategoryInformation(index: indexPath.row)!.name
 
        
        cell.textLabel?.text = catalogItemName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productController = storyboard?.instantiateViewController(withIdentifier: "ProductController") as! ProductController
        let category = categoryPresenter?.getCategoryInformation(index: indexPath.row)!.key
        productController.setCategory(category: category!)

        show(productController, sender: self)
    }
    
    func updateUI() {
        self.tableView.reloadData()
    }
}

