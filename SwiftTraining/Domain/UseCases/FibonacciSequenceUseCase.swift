protocol FibonacciSequenceUseCaseProtocol {
    func generateSequence(upTo limit: Int) -> [Int]
}

struct FibonacciSequenceUseCase: FibonacciSequenceUseCaseProtocol {
    func generateSequence(upTo limit: Int) -> [Int] {
        var sequence: [Int] = []
        var a = 0
        var b = 1

        while a <= limit {
            sequence.append(a)
            let nextNumber = a + b
            a = b
            b = nextNumber
        }

        return sequence
    }
}
