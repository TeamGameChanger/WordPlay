import Foundation
import FirebaseAuth // <-- Import Firebase Auth

@Observable // <-- Make class observable
class AuthManager: ObservableObject {

    // A property to store the logged in user. User is an object provided by FirebaseAuth framework
    var user: User?

    // Determines if AuthManager should use mocked data
    let isMocked: Bool

    var userEmail: String? {

        // If mocked, return a mocked email string, otherwise return the users email if available
        isMocked ? "kingsley@dog.com" : user?.email
    }

    init(isMocked: Bool = false) {

       self.isMocked = isMocked

       // TODO: Check for cached user for persisted login
    }

    // https://firebase.google.com/docs/auth/ios/start#sign_up_new_users
    func signUp(email: String, password: String) async -> Bool {
        do {
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            user = authResult.user // <-- Set the user
            return true // Successful sign up
        } catch {
            print(error)
            return false // Unsuccessful sign up
        }
    }

    // https://firebase.google.com/docs/auth/ios/start#sign_in_existing_users
    func signIn(email: String, password: String) async -> Bool {
        do {
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            user = authResult.user // <-- Set the user
            return true // Successful login
        } catch {
            print(error)
            return false // Unsuccessful login
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            user = nil // <-- Set user to nil after sign out
        } catch {
            print(error)
        }
    }
}
