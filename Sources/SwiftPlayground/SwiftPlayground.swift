// The Swift Programming Language
// https://docs.swift.org/swift-book

struct Book {
    let id: Int
    let title: String
    let author: String
    let pages: Int
    let available: Bool
}

struct Borrower {
    let id: Int
    let firstName: String
    let lastName: String
}

struct Borrow {
    let bookId: Int
    let borrowerId: Int
    let borrowLength: Int
}
@main
struct SwiftPlayground {
    static func main() {
        print("Hello, world!")
    }
}
