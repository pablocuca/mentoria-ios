class PasswordVerificationUseCase {
    private let correctPassword = "123456"
    private var attempts = 0
    private var isAuthenticated = false

    func verify(password: String) -> Bool {
        attempts += 1
        if password == correctPassword {
            isAuthenticated = true
            return true
        } else {
            return false
        }
    }

    func reset() {
        attempts = 0
        isAuthenticated = false
    }

    func hasAuthenticated() -> Bool {
        return isAuthenticated
    }

    func getAttempts() -> Int {
        return attempts
    }
}
