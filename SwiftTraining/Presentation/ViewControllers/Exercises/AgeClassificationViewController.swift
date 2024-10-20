import UIKit

class AgeClassificationViewController: ExerciseViewController {
    private let ageClassificationUseCase: AgeClassificationUseCaseProtocol
    
    init(exercise: Exercise, ageClassificationUseCase: AgeClassificationUseCaseProtocol) {
        self.ageClassificationUseCase = ageClassificationUseCase
        super.init(exercise: exercise)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Elements

    private let instructionLabel: UILabel = {
        let label = UILabel()
        label.text = "Digite sua idade:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let ageTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let classifyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Classificar", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let resultLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Overrides

    override func setupViews() {
        super.setupViews()
        view.addSubview(instructionLabel)
        view.addSubview(ageTextField)
        view.addSubview(classifyButton)
        view.addSubview(resultLabel)

        classifyButton.addTarget(self, action: #selector(classifyAge), for: .touchUpInside)
    }

    override func setupConstraints() {
        super.setupConstraints()
        NSLayoutConstraint.activate([
            instructionLabel.topAnchor.constraint(equalTo: super.descriptionLabel.bottomAnchor, constant: 20),
            instructionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            instructionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            ageTextField.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 10),
            ageTextField.leadingAnchor.constraint(equalTo: instructionLabel.leadingAnchor),
            ageTextField.trailingAnchor.constraint(equalTo: instructionLabel.trailingAnchor),

            classifyButton.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 20),
            classifyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            resultLabel.topAnchor.constraint(equalTo: classifyButton.bottomAnchor, constant: 20),
            resultLabel.leadingAnchor.constraint(equalTo: instructionLabel.leadingAnchor),
            resultLabel.trailingAnchor.constraint(equalTo: instructionLabel.trailingAnchor)
        ])
    }

    // MARK: - Actions
    
    @objc private func classifyAge() {
        // Fechar o teclado
        ageTextField.resignFirstResponder()
        
        // Obter o texto do campo de idade
        guard let ageText = ageTextField.text, !ageText.isEmpty else {
            resultLabel.text = "Por favor, insira sua idade."
            return
        }
        
        // Remover espaços em branco
        let trimmedAgeText = ageText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Converter o texto para um número inteiro
        guard let age = Int(trimmedAgeText) else {
            resultLabel.text = "Por favor, insira um número válido."
            ageTextField.text = ""
            return
        }
        
        // Verificar se a idade é um número válido
        if age < 0 {
            resultLabel.text = "A idade não pode ser negativa."
            ageTextField.text = ""
            return
        }
        
        // Determinar a categoria de idade
        let category: String
        
        category = ageClassificationUseCase.execute(age: age)
        
        ageTextField.text = ""
        
        // Exibir o resultado
        resultLabel.text = "Você é considerado: \(category)."
    }
}
