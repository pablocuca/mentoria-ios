import UIKit

class ExerciseViewController: UIViewController {

    // MARK: - Properties

    var exercise: Exercise
    
    internal let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.backgroundColor = .systemGray4
        return label
    }()

    // MARK: - Initialization

    init(exercise: Exercise) {
        self.exercise = exercise
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = exercise.title
        
        // Adicionar o botão "Ver Código" na barra de navegação
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Ver Código", style: .plain, target: self, action: #selector(showCode))

        setupViews()
        setupConstraints()
    }

    // MARK: - Setup Methods

    func setupViews() {
        descriptionLabel.text = exercise.description
        view.addSubview(descriptionLabel)
        // Subclasses irão implementar este método para adicionar suas views
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        // Subclasses irão implementar este método para configurar as constraints
    }
    
    @objc private func showCode() {
        if let code = loadCode() {
            let codeVC = CodeViewController(codeText: code, exerciseTitle: exercise.title)
            navigationController?.pushViewController(codeVC, animated: true)
        } else {
            let alert = UIAlertController(title: "Erro", message: "Não foi possível carregar o código.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }

    private func loadCode() -> String? {
        guard let path = Bundle.main.path(forResource: "Exercise\(exercise.index)", ofType: "txt") else {
            return nil
        }
        do {
            let code = try String(contentsOfFile: path, encoding: .utf8)
            return code
        } catch {
            print("Erro ao carregar o código: \(error)")
            return nil
        }
    }
}
