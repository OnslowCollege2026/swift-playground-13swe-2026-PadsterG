// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

/// A book at the library.
///
/// Properties:
/// - id: the book's unique identifier.
/// - title: the full title of the book.
/// - author: who wrote the book.
/// - pages: the number of pages in the book.
/// - available: whether the book is currently on loan or not.
struct Book: Identifiable {
    let id = UUID()
    let title: String
    let author: String
    let pages: Int
    var available: Bool
    var summary: String {
        """
        \"\(title)\": author: \(author), pages: \(pages), available: \(available).
        """
    }
}

/// A person who can borrow books
///
/// Properties:
/// - id: the user's unique identifier.
/// - firstName: the user's first name
/// - lastName: the user's last name
struct User: Identifiable {
    let id = UUID()
    let firstName: String
    let lastName: String
}

/// A loan between a user and a book.
///
/// Properties:
/// - bookId: what book is being borrowed. 
/// - userId: what user is borrowing the book.
/// - loanLength: how many days until the book should be returned.
struct Loan {
    let bookId: Int
    let userId: Int
    let loanLength: Int
}

func showAvailableBooks(list: [Book]) {
    let availableBooks = list.filter { book in
        book.available == true
    }
    let unavailableBooks = list.filter { book in
        book.available == false
    }

    print("< Available books >")
    print()
    for book in availableBooks {
        print(book.summary)
        print()
    }

    print("< Unavailable books >")
    print()
    for book in unavailableBooks {
        print(book.summary)
        print()
    }
}

func addNewBook() -> Book {
    print("Enter the title of the book:", terminator: "")
    let bookTitle = readLine()!
    print("Enter the author of the book:", terminator: "")
    let bookAuthor = readLine()!
    print("Enter the number of pages in the book:", terminator: "")
    let bookPages = Int(readLine()!)!
    return Book(title: bookTitle, author: bookAuthor, pages: bookPages, available: true)
}

@main
struct SwiftPlayground {
    static func main() {
        var books: [Book] = [
            Book(title: "Fish School", author: "Tom Rose", pages: 32, available: true),
            Book(title: "Undercover Steve", author: "Lily Waterton", pages: 145, available: false),
            Book(title: "The Living Computer", author: "Tom Rose", pages: 87, available: true),
            Book(title: "Fifty Questions", author: "Tracy Parker", pages: 32, available: false)
        ]

        print("""
        Welcome to the library

        What would you like to do?
        A) Add a new book
        B) Register a new user
        C) Issue a book
        D) Return a book
        E) View available/unavailable books
        F) Search for a book
        G) Search for a user
        H) Edit a book's details
        I) Edit a user's details
        J) Delete a book
        K) Delete a user

        """)

        var askingForUserChoice: Bool = true
        while askingForUserChoice {
            print("Enter the letter linked with the option: ", terminator: "")
            let userOption = readLine()!
            print()
            if userOption.count > 0 {
                switch userOption.uppercased() {
                    case "A": print("Add a new book"); books.append(addNewBook()); showAvailableBooks(list: books); askingForUserChoice = false; break
                    case "B": print("Register a new user"); askingForUserChoice = false; break
                    case "C": print("Issue a book"); askingForUserChoice = false; break
                    case "D": print("Return a book"); askingForUserChoice = false; break
                    case "E": showAvailableBooks(list: books); askingForUserChoice = false; break;
                    case "F": print("Search for a book"); askingForUserChoice = false; break
                    case "G": print("Search for a user"); askingForUserChoice = false; break
                    case "H": print("Edit a book's details"); askingForUserChoice = false; break
                    case "I": print("Edit a user's details"); askingForUserChoice = false; break
                    case "J": print("Delete a book"); askingForUserChoice = false; break
                    case "K": print("Delete a user"); askingForUserChoice = false; break
                    default: print("Invalid answer, please try again."); print()
                }
            } else {
                print("No input given, please try again.")
                print()
            }
        }
    }
}