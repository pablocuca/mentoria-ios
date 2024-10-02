struct AgeClassificationUseCase {
    func execute(age: Int) -> String {
        if age < 12 {
            return "Criança"
        } else if age <= 18 {
            return "Adolescente"
        } else {
            return "Adulto"
        }
    }
}
