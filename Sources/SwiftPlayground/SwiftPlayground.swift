// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

struct Book: Identifiable {
    let id = UUID()
    let title: String
    let author: String
    let pages: Int
    var available: Bool
}

struct User: Identifiable {
    let id = UUID()
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
            Book(title: "Fish School", author: "Tom Rose", pages: 32, available: true),
            Book(title: "Undercover Steve", author: "Lily Waterton", pages: 145, available: false),
            Book(title: "The Living Computer", author: "Tom Rose", pages: 87, available: true),
            Book(title: "Fifty Questions", author: "Tracy Parker", pages: 32, available: false)
        ]
        showAvailableBooks(list: books)
        print("""
        Welcome to the library

        What would you like to do?
        A) Add a new book
        B) Delete a loan
        C) Register a new user
        D) Issue a book
        E) Return a book
        F) View available/unavailable books
        G) Search for a book
        H) Search for a user
        I) Edit a book's details
        J) Edit a user's details
        """)
        
    }
}