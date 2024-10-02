enum CalculatorError: Error {
    case divisionByZero
    case invalidOperation
}

struct SimpleCalculatorUseCase {
    func execute(operation: String, firstNumber: Double, secondNumber: Double) throws -> Double {
        switch operation {
        case "+":
            return firstNumber + secondNumber
        case "-":
            return firstNumber - secondNumber
        case "×":
            return firstNumber * secondNumber
        case "÷":
            if secondNumber != 0 {
                return firstNumber / secondNumber
            } else {
                throw CalculatorError.divisionByZero
            }
        default:
            throw CalculatorError.invalidOperation
        }
    }
}
