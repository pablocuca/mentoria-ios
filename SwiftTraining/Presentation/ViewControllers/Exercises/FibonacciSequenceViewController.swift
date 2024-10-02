import UIKit

class FibonacciSequenceViewController: ExerciseViewController {

    // MARK: - UI Elements

    private let instructionLabel: UILabel = {
        let label = UILabel()
        label.text = "Digite o valor limite para a sequência de Fibonacci:"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    private let limitTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Exemplo: 100"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let generateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Gerar Sequência", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let sequenceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Properties

    private let fibonacciSequenceUseCase = FibonacciSequenceUseCase()

    // MARK: - Overrides

    override func setupViews() {
        super.setupViews()

        view.addSubview(instructionLabel)
        view.addSubview(limitTextField)
        view.addSubview(generateButton)
        view.addSubview(sequenceLabel)

        generateButton.addTarget(self, action: #selector(generateSequence), for: .touchUpInside)
    }

    override func setupConstraints() {
        super.setupConstraints()
        NSLayoutConstraint.activate([
            instructionLabel.topAnchor.constraint(equalTo: super.descriptionLabel.bottomAnchor, constant: 20),
            instructionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            instructionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            limitTextField.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 10),
            limitTextField.leadingAnchor.constraint(equalTo: instructionLabel.leadingAnchor),
            limitTextField.trailingAnchor.constraint(equalTo: instructionLabel.trailingAnchor),

            generateButton.topAnchor.constraint(equalTo: limitTextField.bottomAnchor, constant: 20),
            generateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            sequenceLabel.topAnchor.constraint(equalTo: generateButton.bottomAnchor, constant: 20),
            sequenceLabel.leadingAnchor.constraint(equalTo: instructionLabel.leadingAnchor),
            sequenceLabel.trailingAnchor.constraint(equalTo: instructionLabel.trailingAnchor),
            sequenceLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

    // MARK: - Actions

    @objc private func generateSequence() {
        // Fechar o teclado
        limitTextField.resignFirstResponder()

        // Obter o limite fornecido
        guard let limitText = limitTextField.text, !limitText.isEmpty else {
            sequenceLabel.text = "Por favor, insira um número inteiro."
            return
        }

        guard let limit = Int(limitText), limit >= 0 else {
            sequenceLabel.text = "Por favor, insira um número inteiro válido maior ou igual a zero."
            return
        }

        // Gerar a sequência de Fibonacci
        let sequence = fibonacciSequenceUseCase.generateSequence(upTo: limit)

        // Exibir a sequência no Label
        sequenceLabel.text = "Sequência de Fibonacci até \(limit):\n" + sequence.map { String($0) }.joined(separator: ", ")
    }
}
