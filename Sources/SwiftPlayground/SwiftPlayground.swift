// The Swift Programming Language
// https://docs.swift.org/swift-book

struct Book identifiable {
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

func showAvailableBooks(list: [Book]) {
    let availableBooks = list.filter { book in
        book.available == true
    }
    for book in availableBooks {
        print(book)
        print()
    }
}
@main
struct SwiftPlayground {
    static func main() {
        let books: [Book] = [
            Book(id: 1, title: "Fish School", author: "Tom Rose", pages: 32, available: true),
            Book(id: 2, title: "Undercover Steve", author: "Lily Waterton", pages: 145, available: false),
            Book(id: 3, title: "The Living Computer", author: "Tom Rose", pages: 87, available: true),
            Book(id: 4, title: "Fifty Questions", author: "Tracy Parker", pages: 32, available: false)
        ]
        showAvailableBooks(list: books)
    }
}