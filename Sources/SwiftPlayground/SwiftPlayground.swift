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
        let books: [Book] = [
            Book(id: 1, title: "Fish School", author: "Tom Rose", pages: 32, available: true)
            Book(id: 2, title: "Undercover Steve", author: "Lily Waterton", pages: 145, available: true)
            Book(id: 3, title: "The Living Computer", author: "Tom Rose", pages: 87, available: true)
            Book(id: 4, title: "Fifty Questions", author: "Tracy Parker", pages: 32, available: true)
        ]
    }
}