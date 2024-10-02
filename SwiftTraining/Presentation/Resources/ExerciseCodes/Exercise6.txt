struct MultiplicationTableUseCase {
    func execute(for number: Int) -> [String] {
        var table: [String] = []
        for i in 1...10 {
            let result = number * i
            table.append("\(number) x \(i) = \(result)")
        }
        return table
    }
}
