import UIKit

class ExercisesListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // MARK: - Properties
    
    private let tableView = UITableView()
    private var exercises: [Exercise] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Lista de Exercícios"
        
        setupExercises()
        setupTableView()
    }
    
    private func loadExercisesFromJSON() -> [Exercise]? {
        guard let path = Bundle.main.path(forResource: "exercises", ofType: "json") else {
            return nil
        }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            let exercises = try decoder.decode([Exercise].self, from: data)
            return exercises
        } catch {
            print("Erro ao carregar o JSON: \(error)")
            return nil
        }
    }
    
    private func setupExercises() {
        if let exercises = loadExercisesFromJSON() {
            self.exercises = exercises
        } else {
            // Tratamento de erro
            print("Não foi possível carregar os exercícios.")
        }
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ExerciseCell")

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath)
        let exercise = exercises[indexPath.row]
        cell.textLabel?.text = exercise.title
        cell.backgroundColor = exercise.color
        return cell
    }
    
    // Defina um tipo para o factory
    typealias ExerciseFactory = (Exercise) -> UIViewController

    // Crie um dicionário que mapeia o index para o factory
    let exerciseFactories: [Int: ExerciseFactory] = [
        1: { OddEvenCheckerViewController(exercise: $0) },
        2: { AgeClassificationViewController(exercise: $0) },
        3: { SimpleCalculatorViewController(exercise: $0) },
        4: { WeekdayIdentifierViewController(exercise: $0) },
        5: { EvenNumbersSumViewController(exercise: $0) },
        6: { MultiplicationTableViewController(exercise: $0) },
        7: { GuessingGameViewController(exercise: $0) },
        8: { PasswordVerificationViewController(exercise: $0) },
        9: { CountdownViewController(exercise: $0) },
        10: { FibonacciSequenceViewController(exercise: $0) }
        // Adicione outros exercícios aqui
    ]

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let exercise = exercises[indexPath.row]

        if let factory = exerciseFactories[exercise.index] {
            let viewController = factory(exercise)
            navigationController?.pushViewController(viewController, animated: true)
        } else {
            // Tratamento para exercício não encontrado
            let alert = UIAlertController(title: "Erro", message: "Exercício não encontrado.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
}
