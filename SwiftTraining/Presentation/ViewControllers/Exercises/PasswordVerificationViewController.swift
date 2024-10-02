import UIKit

class PasswordVerificationViewController: ExerciseViewController {

    // MARK: - UI Elements

    private let instructionLabel: UILabel = {
        let label = UILabel()
        label.text = "Digite a senha:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Senha"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let verifyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Verificar", for: .normal)
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
        button.setTitle("Reiniciar", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Properties

    private var passwordVerificationUseCase = PasswordVerificationUseCase()

    // MARK: - Overrides

    override func setupViews() {
        super.setupViews()

        view.addSubview(instructionLabel)
        view.addSubview(passwordTextField)
        view.addSubview(verifyButton)
        view.addSubview(resultLabel)
        view.addSubview(resetButton)

        verifyButton.addTarget(self, action: #selector(verifyPassword), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetVerification), for: .touchUpInside)
    }

    override func setupConstraints() {
        super.setupConstraints()
        NSLayoutConstraint.activate([
            instructionLabel.topAnchor.constraint(equalTo: super.descriptionLabel.bottomAnchor, constant: 20),
            instructionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            instructionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            passwordTextField.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 10),
            passwordTextField.leadingAnchor.constraint(equalTo: instructionLabel.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: instructionLabel.trailingAnchor),

            verifyButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            verifyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            resultLabel.topAnchor.constraint(equalTo: verifyButton.bottomAnchor, constant: 20),
            resultLabel.leadingAnchor.constraint(equalTo: instructionLabel.leadingAnchor),
            resultLabel.trailingAnchor.constraint(equalTo: instructionLabel.trailingAnchor),

            resetButton.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 20),
            resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    // MARK: - Actions

    @objc private func verifyPassword() {
        // Fechar o teclado
        passwordTextField.resignFirstResponder()

        // Obter a senha digitada
        guard let password = passwordTextField.text, !password.isEmpty else {
            resultLabel.text = "Por favor, insira uma senha."
            return
        }

        // Verificar a senha usando o Use Case
        let isCorrect = passwordVerificationUseCase.verify(password: password)

        if isCorrect {
            resultLabel.text = "Senha correta! Você acessou o sistema em \(passwordVerificationUseCase.getAttempts()) tentativa(s)."
            // Desabilitar o botão de verificação após sucesso
            verifyButton.isEnabled = false
        } else {
            resultLabel.text = "Senha incorreta. Tente novamente."
        }

        // Limpar o campo de texto
        passwordTextField.text = ""
    }

    @objc private func resetVerification() {
        passwordVerificationUseCase.reset()
        resultLabel.text = "A verificação foi reiniciada. Digite a senha novamente."
        verifyButton.isEnabled = true
    }
}
