import UIKit

class EvenNumbersSumViewController: ExerciseViewController {
    private let evenNumbersSumUseCase: EvenNumbersSumUseCaseProtocol
    
    init(exercise: Exercise, evenNumbersSumUseCase: EvenNumbersSumUseCaseProtocol) {
        self.evenNumbersSumUseCase = evenNumbersSumUseCase
        super.init(exercise: exercise)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Elements

    private let instructionLabel: UILabel = {
        let label = UILabel()
        label.text = "Digite um número inteiro N:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let numberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Exemplo: 10"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let calculateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Calcular Soma", for: .normal)
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
        view.addSubview(calculateButton)
        view.addSubview(resultLabel)

        calculateButton.addTarget(self, action: #selector(calculateSum), for: .touchUpInside)
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

            calculateButton.topAnchor.constraint(equalTo: numberTextField.bottomAnchor, constant: 20),
            calculateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            resultLabel.topAnchor.constraint(equalTo: calculateButton.bottomAnchor, constant: 30),
            resultLabel.leadingAnchor.constraint(equalTo: instructionLabel.leadingAnchor),
            resultLabel.trailingAnchor.constraint(equalTo: instructionLabel.trailingAnchor)
        ])
    }

    // MARK: - Actions

    @objc private func calculateSum() {
        // Fechar o teclado
        numberTextField.resignFirstResponder()

        // Obter o valor de N
        guard let numberText = numberTextField.text, !numberText.isEmpty else {
            resultLabel.text = "Por favor, insira um número inteiro."
            return
        }

        guard let n = Int(numberText), n >= 1 else {
            resultLabel.text = "Por favor, insira um número inteiro válido maior ou igual a 1."
            return
        }

        // Calcular a soma usando o Use Case
        let sum = evenNumbersSumUseCase.execute(upTo: n)

        // Exibir o resultado
        resultLabel.text = "A soma dos números pares de 1 até \(n) é: \(sum)."
    }

    // MARK: - Método para exibir o código-fonte

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = exercise.title

        setupViews()
        setupConstraints()
    }
}
