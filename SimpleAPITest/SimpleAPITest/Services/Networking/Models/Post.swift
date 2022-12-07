import Foundation

struct Post: Codable, Equatable {
    var id: Int
    var userId: Int
    var title: String
    var body: String
}
