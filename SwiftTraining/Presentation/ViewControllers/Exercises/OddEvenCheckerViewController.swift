import UIKit

class OddEvenCheckerViewController: ExerciseViewController {
    private let oddEvenCheckerUseCase: OddEvenCheckerUseCaseProtocol
    
    init(exercise: Exercise, oddEvenCheckerUseCase: OddEvenCheckerUseCaseProtocol) {
        self.oddEvenCheckerUseCase = oddEvenCheckerUseCase
        super.init(exercise: exercise)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Elements

    private let instructionLabel: UILabel = {
        let label = UILabel()
        label.text = "Digite um número inteiro:"
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

    private let checkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Verificar", for: .normal)
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
        view.addSubview(numberTextField)
        view.addSubview(checkButton)
        view.addSubview(resultLabel)

        checkButton.addTarget(self, action: #selector(checkNumber), for: .touchUpInside)
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

            checkButton.topAnchor.constraint(equalTo: numberTextField.bottomAnchor, constant: 20),
            checkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            resultLabel.topAnchor.constraint(equalTo: checkButton.bottomAnchor, constant: 20),
            resultLabel.leadingAnchor.constraint(equalTo: instructionLabel.leadingAnchor),
            resultLabel.trailingAnchor.constraint(equalTo: instructionLabel.trailingAnchor)
        ])
    }

    // MARK: - Actions
    
    @objc private func checkNumber() {
        // Fechar o teclado
        numberTextField.resignFirstResponder()
        
        guard let text = numberTextField.text, let number = Int(text) else {
            resultLabel.text = "Por favor, insira um número válido."
            numberTextField.text = ""
            return
        }

        resultLabel.text = oddEvenCheckerUseCase.execute(number: number)
        
        numberTextField.text = ""
    }
}
