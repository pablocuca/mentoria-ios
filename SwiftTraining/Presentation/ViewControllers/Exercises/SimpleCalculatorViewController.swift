import UIKit

class SimpleCalculatorViewController: ExerciseViewController {

    // MARK: - UI Elements

    private let firstNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Primeiro número"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let secondNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Segundo número"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let operationSegmentedControl: UISegmentedControl = {
        let items = ["+", "−", "×", "÷"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()

    private let calculateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Calcular", for: .normal)
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
        view.addSubview(firstNumberTextField)
        view.addSubview(secondNumberTextField)
        view.addSubview(operationSegmentedControl)
        view.addSubview(calculateButton)
        view.addSubview(resultLabel)

        calculateButton.addTarget(self, action: #selector(calculateResult), for: .touchUpInside)
    }

    override func setupConstraints() {
        super.setupConstraints()
        NSLayoutConstraint.activate([
            firstNumberTextField.topAnchor.constraint(equalTo: super.descriptionLabel.bottomAnchor, constant: 20),
            firstNumberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            firstNumberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            secondNumberTextField.topAnchor.constraint(equalTo: firstNumberTextField.bottomAnchor, constant: 15),
            secondNumberTextField.leadingAnchor.constraint(equalTo: firstNumberTextField.leadingAnchor),
            secondNumberTextField.trailingAnchor.constraint(equalTo: firstNumberTextField.trailingAnchor),

            operationSegmentedControl.topAnchor.constraint(equalTo: secondNumberTextField.bottomAnchor, constant: 20),
            operationSegmentedControl.leadingAnchor.constraint(equalTo: firstNumberTextField.leadingAnchor),
            operationSegmentedControl.trailingAnchor.constraint(equalTo: firstNumberTextField.trailingAnchor),

            calculateButton.topAnchor.constraint(equalTo: operationSegmentedControl.bottomAnchor, constant: 25),
            calculateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            resultLabel.topAnchor.constraint(equalTo: calculateButton.bottomAnchor, constant: 30),
            resultLabel.leadingAnchor.constraint(equalTo: firstNumberTextField.leadingAnchor),
            resultLabel.trailingAnchor.constraint(equalTo: firstNumberTextField.trailingAnchor)
        ])
    }

    // MARK: - Actions

    private let simpleCalculatorUseCase = SimpleCalculatorUseCase()
    
    @objc private func calculateResult() {
        // Fechar o teclado
        firstNumberTextField.resignFirstResponder()
        secondNumberTextField.resignFirstResponder()

        // Obter os valores dos campos de texto
        guard let firstText = firstNumberTextField.text, !firstText.isEmpty,
              let secondText = secondNumberTextField.text, !secondText.isEmpty else {
            resultLabel.text = "Por favor, insira ambos os números."
            return
        }

        // Remover espaços em branco
        let trimmedFirstText = firstText.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedSecondText = secondText.trimmingCharacters(in: .whitespacesAndNewlines)

        // Converter os textos para Double
        guard let firstNumber = Double(trimmedFirstText),
              let secondNumber = Double(trimmedSecondText) else {
            resultLabel.text = "Por favor, insira números válidos."
            return
        }

        // Obter a operação selecionada
        let operationIndex = operationSegmentedControl.selectedSegmentIndex
        let operation: String

        switch operationIndex {
        case 0:
            operation = "+"
        case 1:
            operation = "-"
        case 2:
            operation = "×"
        case 3:
            operation = "÷"
        default:
            operation = "+"
        }

        // Realizar o cálculo com base na operação
        var result: Double?

        do {
            result = try simpleCalculatorUseCase.execute(operation: operation, firstNumber: firstNumber, secondNumber: secondNumber)
        } catch CalculatorError.divisionByZero {
            resultLabel.text = "Erro: Divisão por zero."
        } catch CalculatorError.invalidOperation {
            resultLabel.text = "Erro: Operação inválida."
        } catch {
            resultLabel.text = "Erro desconhecido."
        }
        
        // Formatar o resultado para evitar casas decimais desnecessárias
        if let resultValue = result {
            let formattedResult = String(format: "%.2f", resultValue)
            resultLabel.text = "Resultado: \(formattedResult)"
        } else {
            resultLabel.text = "Erro ao calcular o resultado."
        }
    }
}
