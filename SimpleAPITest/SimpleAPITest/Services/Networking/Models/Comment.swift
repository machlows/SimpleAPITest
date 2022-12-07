import Foundation

struct Comment: Codable, Equatable {
    var id: Int
    var postId: Int
    var name: String
    var email: String
    var body: String
}
