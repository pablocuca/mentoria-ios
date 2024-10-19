protocol EvenNumbersSumUseCaseProtocol {
    func execute(upTo n: Int) -> Int
}

struct EvenNumbersSumUseCase: EvenNumbersSumUseCaseProtocol {
    func execute(upTo n: Int) -> Int {
        guard n >= 2 else { return 0 }
        var sum = 0
        for number in 2...n {
            if number % 2 == 0 {
                sum += number
            }
        }
        return sum
    }
}
