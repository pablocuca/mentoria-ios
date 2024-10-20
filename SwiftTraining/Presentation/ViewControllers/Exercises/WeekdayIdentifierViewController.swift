import UIKit

class WeekdayIdentifierViewController: ExerciseViewController {
    private let weekdayIdentifierUseCase: WeekdayIdentifierUseCaseProtocol
    
    init(exercise: Exercise, weekdayIdentifierUseCase: WeekdayIdentifierUseCaseProtocol) {
        self.weekdayIdentifierUseCase = weekdayIdentifierUseCase
        super.init(exercise: exercise)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Elements

    private let instructionLabel: UILabel = {
        let label = UILabel()
        label.text = "Digite um número de 1 a 7:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let numberTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let identifyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Identificar Dia", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let resultLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Overrides

    override func setupViews() {
        super.setupViews()
        view.addSubview(instructionLabel)
        view.addSubview(numberTextField)
        view.addSubview(identifyButton)
        view.addSubview(resultLabel)

        identifyButton.addTarget(self, action: #selector(identifyDay), for: .touchUpInside)
    }

    override func setupConstraints() {
        super.setupConstraints()
        NSLayoutConstraint.activate([
            instructionLabel.topAnchor.constraint(equalTo: super.descriptionLabel.bottomAnchor, constant: 20),
            instructionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            instructionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            numberTextField.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 10),
            numberTextField.leadingAnchor.constraint(equalTo: instructionLabel.leadingAnchor),
            numberTextField.trailingAnchor.constraint(equalTo: instructionLabel.trailingAnchor),

            identifyButton.topAnchor.constraint(equalTo: numberTextField.bottomAnchor, constant: 20),
            identifyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            resultLabel.topAnchor.constraint(equalTo: identifyButton.bottomAnchor, constant: 30),
            resultLabel.leadingAnchor.constraint(equalTo: instructionLabel.leadingAnchor),
            resultLabel.trailingAnchor.constraint(equalTo: instructionLabel.trailingAnchor)
        ])
    }

    // MARK: - Actions
    
    @objc private func identifyDay() {
        // Fechar o teclado
        numberTextField.resignFirstResponder()

        // Obter o texto do campo de número
        guard let numberText = numberTextField.text, !numberText.isEmpty else {
            resultLabel.text = "Por favor, insira um número de 1 a 7."
            numberTextField.text = ""
            return
        }

        // Remover espaços em branco
        let trimmedNumberText = numberText.trimmingCharacters(in: .whitespacesAndNewlines)

        // Converter o texto para um número inteiro
        guard let number = Int(trimmedNumberText) else {
            resultLabel.text = "Por favor, insira um número válido."
            numberTextField.text = ""
            return
        }

        // Verificar se o número está entre 1 e 7
        guard number >= 1 && number <= 7 else {
            resultLabel.text = "O número deve estar entre 1 e 7."
            numberTextField.text = ""
            return
        }

        // Identificar o dia da semana usando switch/case
        let dayOfWeek: String

        dayOfWeek = weekdayIdentifierUseCase.execute(number: number)
        
        numberTextField.text = ""

        // Exibir o resultado
        resultLabel.text = "O dia correspondente é: \(dayOfWeek)."
    }
}
