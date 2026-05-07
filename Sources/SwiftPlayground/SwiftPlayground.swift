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
        \"\(title)\": author: \(author), pages: \(pages).
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

/// Prints a list of options.
func printMenu() {
    print("""
    What would you like to do?
    A) Add a new book
    B) Add a new user
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
    /// Adds only available books to a new list.
    let availableBooks = list.filter { book in
        book.available == true
    }
    /// Adds only unavailable books to a new list.
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
        print()
        return true
    // Tells user to enter again if the string is more than 50 letters.
    } else if string.count > 50 {
        print("Input is too long, please enter a different one.")
        print()
        return true
    // Otherwise, the string is deemed valid and user will escape the while loop.
    } else {
        print()
        return false
    }
}


/// Steps of asking the user for properties to build a new book instance.
/// 
/// Returns: A new book instance.
func addNewBook() -> Book {
    /// Setting property variables to default values.
    var title = ""
    var author = ""
    print("< Add a new book >")
    print()
    /// While loop will keep cycling until this variable is equal to false.
    var askingForBookTitle: Bool = true
    while askingForBookTitle {
        // Asks for book title and puts it through a function to check it's valid.
        print("Enter the title of the book: ", terminator: "")
        title = readLine()!
        askingForBookTitle = checkString(string: title)
    }
    /// While loop will keep cycling until this variable is equal to false.
    var askingForBookAuthor: Bool = true
    while askingForBookAuthor {
        // Asks for book author and puts it through a function to check it's valid.
        print("Enter the author of the book: ", terminator: "")
        author = readLine()!
        askingForBookAuthor = checkString(string: author)
    }
    /// Asks for the number of pages through a function.
    let pages = askForBookPages()
    print("Created new book: (title: \(title), author: \(author), pages: \(pages))")
    print()
    // Returns a new book instance with properties the user entered.
    return Book(title: title, author: author, pages: pages, available: true)
}

func askForBookPages() -> Int {
    var askingForBookPages: Bool = true
    while askingForBookPages {
        print("Enter the number of pages in the book: ", terminator: "")
        let pagesInput = readLine()!
        print()
        if pagesInput.count > 0 {
            if let pages = Int(pagesInput) {
                if pages > 0 {
                    askingForBookPages = false
                    return pages
                } else {
                    print("There must be atleast 1 page in the book, please try again.")
                    print()
                }
            } else {
                print("Please enter a whole number.")
                print()
            }
        } else {
            print("No input entered, please try again.")
            print()
        }
    }
}

/// Steps of asking the user for properties to register a new user instance.
/// 
/// Returns: A new user instance.
func addNewUser() -> User {
    /// Setting property variables to default values.
    var firstName = ""
    var lastName = ""
    print("< Add a new user >")
    print()
    // While loop will keep cycling until this variable is equal to false.
    var askingForFirstName: Bool = true
    while askingForFirstName {
        // Asks for user's first name and puts it through a function to check it's valid.
        print("Enter the user's first name: ", terminator: "")
        firstName = readLine()!
        askingForFirstName = checkString(string: firstName)
    }
    // While loop will keep cycling until this variable is equal to false.
    var askingForLastName: Bool = true
    while askingForLastName {
        // Asks for user's last name and puts it through a function to check it's valid.
        print("Enter the user's last name: ", terminator: "")
        lastName = readLine()!
        askingForLastName = checkString(string: lastName)
    }
    print("Added new user: (first name: \(firstName), last name: \(lastName))")
    print()
    // Returns a new user instance with properties the user entered.
    return User(firstName: firstName, lastName: lastName)
}

func searchForBook(list: [Book]) {
    var title = ""
    var searchingForBook: Bool = true
    while searchingForBook {
        var askingForBookTitle: Bool = true
        while askingForBookTitle {
            print("Enter the title of the book: ", terminator: "")
            title = readLine()!
            askingForBookTitle = checkString(string: title)
        }
        let booksWithMatchingTitle = list.filter { book in
            book.title == title
        }
        if booksWithMatchingTitle.count > 0 {
            print("Book(s) found:")
            print(booksWithMatchingTitle)
            askingForBookTitle = false
        } else {
            print("No books found with title \(title).")
        }
        print()
        var leavingBookSearch: Bool = true
        while leavingBookSearch {
            print("Would you like to search for another book? (Y/N) ", terminator: "")
            let leaveBookSearch = readLine()
            if leaveBookSearch?.uppercased() == "Y" {
                print("You chose to search for another book.")
                print()
                leavingBookSearch = false
            } else if leaveBookSearch?.uppercased() == "N" {
                print("You chose to leave the book search.")
                print()
                leavingBookSearch = false
                searchingForBook = false
            } else {
                print("Invalid answer, please try again.")
                print()
            }
        }
    }
}

func searchForUser(list: [User]) {
    var firstName = ""
    var searchingForUser: Bool = true
    while searchingForUser {
        var askingForUserFirstName: Bool = true
        while askingForUserFirstName {
            print("Enter the first name of the user: ", terminator: "")
            firstName = readLine()!
            askingForUserFirstName = checkString(string: firstName)
        }
        let usersWithMatchingFirstName = list.filter { user in
            user.firstName == firstName
        }
        if usersWithMatchingFirstName.count > 0 {
            print("User(s) found:")
            print(usersWithMatchingFirstName)
            askingForUserFirstName = false
        } else {
            print("No users found with first name \(firstName).")
        }
        print()
        var leavingUserSearch: Bool = true
        while leavingUserSearch {
            print("Would you like to search for another user? (Y/N) ", terminator: "")
            let leaveUserSearch = readLine()
            if leaveUserSearch?.uppercased() == "Y" {
                print("You chose to search for another user.")
                print()
                leavingUserSearch = false
            } else if leaveUserSearch?.uppercased() == "N" {
                print("You chose to leave the book search.")
                print()
                leavingUserSearch = false
                searchingForUser = false
            } else {
                print("Invalid answer, please try again.")
                print()
            }
        }
    }
}

func issueBook() {
    print("What book would you like to issue? ", terminator: "")
    let issuedBook = readLine()
    
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

        var users: [User] = []

        let optionLetters: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K"]

        print("Welcome to the library!")
        print()
        
        // While loop for whole program.
        var programRunning = true
        while programRunning {
            printMenu()
            // While loop to ask for the user's option.
            var askingForUserOption: Bool = true
            while askingForUserOption {
                // Space for the user to enter their option.
                print("Enter the letter linked with the option: ", terminator: "")
                let userOption = readLine()!

                // Only consider input if it's not null.
                if userOption.count > 0 {
                    // Checks if the input is a possible option.
                    if optionLetters.contains(userOption.uppercased()) {
                        // Different responses for each possible option.
                        print()
                        switch userOption.uppercased() {
                            case "A": books.append(addNewBook())
                            case "B": users.append(addNewUser())
                            case "C": print("Issue a book"); issueBook()
                            case "D": print("Return a book")
                            case "E": showAvailableBooks(list: books)
                            case "F": print("Search for a book"); searchForBook(list: books)
                            case "G": print("Search for a user"); searchForUser(list: users)
                            case "H": print("Edit a book's details")
                            case "I": print("Edit a user's details")
                            case "J": print("Delete a book")
                            case "K": print("Delete a user")
                            default: print("Error has occured")
                        }
                        // Leaves while loop.
                        askingForUserOption = false
                    } else {
                        // Error message is given.
                        print("Invalid answer, please try again.")
                        print()
                    }
                // If input is null, error messasge is given.
                } else {
                    print("No input given, please try again.")
                    print()
                }
            }

            // While loop to check if the user would like to quit the program.
            var askingForKeepGoing: Bool = true
            while askingForKeepGoing {
                
                // Gives input space
                print("Would you like to do another thing? (Y/N) ", terminator: "")
                let keepGoing = readLine()!
                print()

                // If user enters yes, this loop ends and user cycles to start of main loop.
                if keepGoing.uppercased() == "Y" {
                    askingForKeepGoing = false

                // If user enters no, this loop ends and so does the main loop.
                } else if keepGoing.uppercased() == "N" {
                    askingForKeepGoing = false
                    programRunning = false

                // Otherwise, the input must be invalid.
                } else {
                    print("Invalid input, please try again.")
                    print()
                }
            }
        }
    }
}