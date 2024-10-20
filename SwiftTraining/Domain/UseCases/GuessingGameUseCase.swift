protocol GuessingGameUseCaseProtocol {
    func makeGuess(_ guess: Int) -> String
    func resetGame()
    func getCorrectNumberForTesting() -> Int
}

class GuessingGameUseCase: GuessingGameUseCaseProtocol {
    private var targetNumber: Int
    private var attempts: Int

    init() {
        self.targetNumber = Int.random(in: 1...10)
        self.attempts = 0
    }

    func makeGuess(_ guess: Int) -> String {
        attempts += 1

        if guess < targetNumber {
            return "O número é maior que \(guess). Tente novamente."
        } else if guess > targetNumber {
            return "O número é menor que \(guess). Tente novamente."
        } else {
            return "Parabéns! Você acertou o número \(targetNumber) em \(attempts) tentativas."
        }
    }

    func resetGame() {
        self.targetNumber = Int.random(in: 1...10)
        self.attempts = 0
    }
    
    // Método usado apenas para fins de teste
    func getCorrectNumberForTesting() -> Int {
        return targetNumber
    }
}
