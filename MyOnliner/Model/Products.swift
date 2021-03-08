import Foundation

struct Products: Codable {
    var products: [Product]
}

struct Product: Codable {
    var key: String
    var name: String
    var description: String
    var images: ImageInformation
    var html_url: String
}

struct ImageInformation: Codable {
    var header: String
}
