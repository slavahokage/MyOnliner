import Foundation

struct Catalog: Codable {
    var schemas: [CatalogInformation]
}

struct CatalogInformation: Codable {
    var key: String
    var name: String
}
