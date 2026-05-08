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
/// - summary: small description of the book
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

/// Prints a list of options.
func printMenu() {
    print("""
    What would you like to do?
    A) Add a new book
    B) Add a new user
    C) View available/unavailable books
    D) Search for a book
    E) Search for a user

    """)
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

/// Asks for no of pages in a new book and runs it through conditions.
/// 
/// Returns: The pages value entered.
func askForBookPages() -> Int {
    // While loop will keep cycling until this variable is false.
    var askingForBookPages: Bool = true
    while askingForBookPages {
        // Gives user a space to enter a number.
        print("Enter the number of pages in the book: ", terminator: "")
        let pagesInput = readLine()!
        print()
        // The code passes if it's not nil.
        if pagesInput.count > 0 {
            // Checks that the user entered a whole number.
            if let pages = Int(pagesInput) {
                // Confirms is there is atleast 1 page entered.
                if pages > 0 {
                    // User escapes loop and their pages value is returned.
                    askingForBookPages = false
                    return pages
                // If less than 1 page, error message.
                } else {
                    print("There must be atleast 1 page in the book, please try again.")
                    print()
                }
            // If whole number not entered, error message.
            } else {
                print("Please enter a whole number.")
                print()
            }
        // If nil, error message.
        } else {
            print("No input entered, please try again.")
            print()
        }
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
                print("You chose to leave the user search.")
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
        // Initial list of users.
        var users: [User] = []
        // Letters corresponding with each option.
        let optionLetters: [String] = ["A", "B", "C", "D", "E"]

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
                            case "C": showAvailableBooks(list: books)
                            case "D": print("< Search for a book >"); searchForBook(list: books)
                            case "E": print("< Search for a user >"); searchForUser(list: users)
                            default: print("Error has occured")
                        }
                        // Leaves while loop.
                        askingForUserOption = false
                    } else {
                        // Error message is given.
                        print("Invalid answer, please try again.")
                        print()
                    }
                // If input is nil, error message is given.
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