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

func printMenu() {
    print("""
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
}

/// Filters through the list of books to seperate available and unavailable books.
/// 
/// Parameters:
/// - list: The list of books to filter through.
func showAvailableBooks(list: [Book]) {

    // Adds only available books to a new list.
    let availableBooks = list.filter { book in
        book.available == true
    }
    
    // Adds only unavailable books to a new list.
    let unavailableBooks = list.filter { book in
        book.available == false
    }

    // Prints a condensed format of all available books.
    print("< Available books >")
    print()
    for book in availableBooks {
        print(book.summary)
        print()
    }

    // Prints a condensed format of all unavailable books.
    print("< Unavailable books >")
    print()
    for book in unavailableBooks {
        print(book.summary)
        print()
    }
}

/// Takes a string value entered and tests if it meets valid conditions.
/// 
/// Parameters:
/// - string: The user's input.
/// Returns: If the while loop condition should remain true or not.
func checkString(string: String) -> Bool {

    // Tells user to enter again if nothing is entered.
    if string.count <= 0 {
        print("No input entered, please try again.")
        return true
        
    // Tells user to enter again if the string is more than 50 letters.
    } else if string.count > 50 {
        print("Input is too long, please enter a different one.")
        return true
    
    // Otherwise, the string is deemed valid and user will escape the while loop.
    } else {
        return false
    }
}

/// Steps of asking the user for properties to build a new book instance.
/// 
/// Returns: A new book instance.
func addNewBook() -> Book {

    // Variables for the properties start at default values.
    var bookTitle = ""
    var bookAuthor = ""
    let bookPages = 0

    // While loop will keep cycling until this variable is equal to false.
    var askingForBookTitle: Bool = true
    while askingForBookTitle {

        // Asks for book title and puts it through a function to check it's valid.
        print("Enter the title of the book: ", terminator: "")
        bookTitle = readLine()!
        askingForBookTitle = checkString(string: bookTitle)
    }

    // While loop will keep cycling until this variable is equal to false.
    var askingForBookAuthor: Bool = true
    while askingForBookAuthor {
        
        // Asks for book author and puts it through a function to check it's valid.
        print("Enter the author of the book: ", terminator: "")
        bookAuthor = readLine()!
        askingForBookAuthor = checkString(string: bookAuthor)
    }

    // While loop will keep cycling until this variable is equal to false.
    var askingForBookPages: Bool = true
    while askingForBookPages {

        // Asks for the number of pages in the book.
        print("How many pages does the book have? ", terminator: "")

        // Checks the answer is an integer.
        if let bookPages = readLine(), let bookPages = Int(bookPages) {
            
            // Ensures there is atleast one page, if there is, the while loop ends.
            if bookPages <= 0 {
                print("There must be atleast 1 page in the book, please try again.")
            } else {
                askingForBookPages = false
            }
        
        // Otherwise, an error message is given and user is asked again.
        } else {
            print("Please enter a whole positive number.")
        }
    }

    // Returns a new book instance with properties the user entered.
    return Book(title: bookTitle, author: bookAuthor, pages: bookPages, available: true)
}

@main
struct SwiftPlayground {
    static func main() {

        // Initial list of books.
        var books: [Book] = [
            Book(title: "Fish School", author: "Tom Rose", pages: 32, available: true),
            Book(title: "Undercover Steve", author: "Lily Waterton", pages: 145, available: false),
            Book(title: "The Living Computer", author: "Tom Rose", pages: 87, available: true),
            Book(title: "Fifty Questions", author: "Tracy Parker", pages: 32, available: false)
        ]

        print("Welcome to the library!")
        print()
        
        // While loop for whole program.
        var programRunning = true
        while programRunning {
            printMenu()

            var askingForUserChoice: Bool = true
            while askingForUserChoice {
                print("Enter the letter linked with the option: ", terminator: "")
                let userOption = readLine()!
                print()
                if userOption.count > 0 {
                    switch userOption.uppercased() {
                        case "A": print("Add a new book"); books.append(addNewBook()); askingForUserChoice = false; break
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

            var askingForKeepGoing: Bool = true
            while askingForKeepGoing {

                print("Would you like to do another thing? (Y/N) ", terminator: "")
                let keepGoing = readLine()!
                print()

                if keepGoing.uppercased() == "Y" {
                    askingForKeepGoing = false

                } else if keepGoing.uppercased() == "N" {
                    askingForKeepGoing = false
                    programRunning = false

                } else {
                    print("Invalid input, please try again.")
                    print()
                }
            }
        }
    }
}