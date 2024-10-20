import UIKit

class GuessingGameViewController: ExerciseViewController {
    private var guessingGameUseCase: GuessingGameUseCaseProtocol
    
    init(exercise: Exercise, guessingGameUseCase: GuessingGameUseCaseProtocol) {
        self.guessingGameUseCase = guessingGameUseCase
        super.init(exercise: exercise)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: - UI Elements

    private let instructionLabel: UILabel = {
        let label = UILabel()
        label.text = "Tente adivinhar o número de 1 a 10:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let guessTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Seu palpite"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let guessButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Enviar Palpite", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let resultLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Reiniciar Jogo", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Overrides

    override func setupViews() {
        super.setupViews()

        view.addSubview(instructionLabel)
        view.addSubview(guessTextField)
        view.addSubview(guessButton)
        view.addSubview(resultLabel)
        view.addSubview(resetButton)

        guessButton.addTarget(self, action: #selector(makeGuess), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetGame), for: .touchUpInside)
    }

    override func setupConstraints() {
        super.setupConstraints()
        NSLayoutConstraint.activate([
            instructionLabel.topAnchor.constraint(equalTo: super.descriptionLabel.bottomAnchor, constant: 20),
            instructionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            instructionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            guessTextField.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 10),
            guessTextField.leadingAnchor.constraint(equalTo: instructionLabel.leadingAnchor),
            guessTextField.trailingAnchor.constraint(equalTo: instructionLabel.trailingAnchor),

            guessButton.topAnchor.constraint(equalTo: guessTextField.bottomAnchor, constant: 20),
            guessButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            resultLabel.topAnchor.constraint(equalTo: guessButton.bottomAnchor, constant: 20),
            resultLabel.leadingAnchor.constraint(equalTo: instructionLabel.leadingAnchor),
            resultLabel.trailingAnchor.constraint(equalTo: instructionLabel.trailingAnchor),

            resetButton.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 20),
            resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    // MARK: - Actions

    @objc private func makeGuess() {
        // Fechar o teclado
        guessTextField.resignFirstResponder()

        // Obter o palpite do usuário
        guard let guessText = guessTextField.text, !guessText.isEmpty else {
            resultLabel.text = "Por favor, insira um número de 1 a 10."
            return
        }

        guard let guess = Int(guessText), (1...10).contains(guess) else {
            resultLabel.text = "Por favor, insira um número válido entre 1 e 10."
            return
        }

        // Fazer o palpite usando o Use Case
        let response = guessingGameUseCase.makeGuess(guess)

        // Exibir a resposta
        resultLabel.text = response

        // Limpar o campo de texto
        guessTextField.text = ""
    }

    @objc private func resetGame() {
        guessingGameUseCase.resetGame()
        resultLabel.text = "O jogo foi reiniciado. Tente adivinhar o novo número."
    }
}
