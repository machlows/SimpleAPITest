import Foundation

enum Request {
    static let baseURL = URL(string: "https://jsonplaceholder.typicode.com/")!
    
    case posts
    case post(Int)
    case comments(Int)
    case user(Int)
    case users
    
    var url: URL {
        switch self {
        case .posts:
            return Request.baseURL.appendingPathComponent("posts")
        case .post(let postId):
            return Request.baseURL.appendingPathComponent("posts/\(postId)")
        case .comments(let postId):
            return Request.baseURL.appendingPathComponent("posts/\(postId)/comments")
        case .user(let userId):
            return Request.baseURL.appendingPathComponent("user/\(userId)")
        case .users:
            return Request.baseURL.appendingPathComponent("users")
        }
    }
}
