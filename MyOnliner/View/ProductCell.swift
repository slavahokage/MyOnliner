import UIKit

class ProductCell: UITableViewCell {
    
    @IBOutlet weak var imageViewProduct: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descriptionProduct: UILabel!
    
    func setProduct(product: Product) {
        title.text = product.name
        descriptionProduct.text = product.description
        
        imageViewProduct.downloaded(from: "https:\(product.images.header)")
        //imageViewProduct.image = UIImage(named: "apple")
    }
}

extension UIImageView {
    
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    return
                    
            }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
