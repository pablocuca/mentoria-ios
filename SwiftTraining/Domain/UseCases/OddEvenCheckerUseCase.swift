protocol OddEvenCheckerUseCaseProtocol {
    func execute(number: Int) -> String
}

struct OddEvenCheckerUseCase: OddEvenCheckerUseCaseProtocol {
    func execute(number: Int) -> String {
        if number % 2 == 0 {
            return "O número \(number) é **par**."
        } else {
            return "O número \(number) é **ímpar**."
        }
    }
}
