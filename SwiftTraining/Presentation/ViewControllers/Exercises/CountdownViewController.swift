import UIKit

class CountdownViewController: ExerciseViewController {

    // MARK: - UI Elements

    private let countdownLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 64, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Iniciar Contagem Regressiva", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Properties

    private var countdownUseCase = CountdownUseCase()
    private var isCounting = false

    // MARK: - Overrides

    override func setupViews() {
        super.setupViews()

        view.addSubview(countdownLabel)
        view.addSubview(startButton)

        startButton.addTarget(self, action: #selector(startCountdown), for: .touchUpInside)
    }

    override func setupConstraints() {
        super.setupConstraints()
        NSLayoutConstraint.activate([
            countdownLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countdownLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 50),

            startButton.topAnchor.constraint(equalTo: countdownLabel.bottomAnchor, constant: 50),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    // MARK: - Actions

    @objc private func startCountdown() {
        guard !isCounting else { return }
        isCounting = true
        countdownUseCase = CountdownUseCase() // Reinicia a contagem
        startButton.isEnabled = false
        countdownLabel.text = ""

        countdownUseCase.startCountdown { [weak self] (value, finished) in
            DispatchQueue.main.async {
                if finished {
                    self?.countdownLabel.text = "Feliz\nAno Novo!"
                    self?.startButton.isEnabled = true
                    self?.isCounting = false
                } else {
                    self?.countdownLabel.text = "\(value)"
                }
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Parar o timer se a view controller for descartada
        countdownUseCase.stopCountdown()
    }
}
