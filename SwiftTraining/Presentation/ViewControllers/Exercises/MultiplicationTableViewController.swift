import UIKit

class MultiplicationTableViewController: ExerciseViewController {
    private let multiplicationTableUseCase: MultiplicationTableUseCaseProtocol
    
    init(exercise: Exercise, multiplicationTableUseCase: MultiplicationTableUseCaseProtocol) {
        self.multiplicationTableUseCase = multiplicationTableUseCase
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
        textField.placeholder = "Exemplo: 5"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let showTableButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Mostrar Tabela", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let tableLabelView: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    // MARK: - Overrides

    override func setupViews() {
        super.setupViews()

        view.addSubview(instructionLabel)
        view.addSubview(numberTextField)
        view.addSubview(showTableButton)
        view.addSubview(tableLabelView)

        showTableButton.addTarget(self, action: #selector(showTable), for: .touchUpInside)
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

            showTableButton.topAnchor.constraint(equalTo: numberTextField.bottomAnchor, constant: 20),
            showTableButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            tableLabelView.topAnchor.constraint(equalTo: showTableButton.bottomAnchor, constant: 20),
            tableLabelView.leadingAnchor.constraint(equalTo: instructionLabel.leadingAnchor),
            tableLabelView.trailingAnchor.constraint(equalTo: instructionLabel.trailingAnchor),
            tableLabelView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

    // MARK: - Actions

    @objc private func showTable() {
        // Fechar o teclado
        numberTextField.resignFirstResponder()

        // Obter o número fornecido
        guard let numberText = numberTextField.text, !numberText.isEmpty else {
            tableLabelView.text = "Por favor, insira um número inteiro."
            return
        }

        guard let number = Int(numberText) else {
            tableLabelView.text = "Por favor, insira um número inteiro válido."
            return
        }

        // Gerar a tabela de multiplicação
        let table = multiplicationTableUseCase.execute(for: number)

        // Exibir a tabela no TextView
        tableLabelView.text = table.joined(separator: "\n")
    }
}
