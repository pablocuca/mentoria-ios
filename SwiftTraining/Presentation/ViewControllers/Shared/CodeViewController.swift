import UIKit

class CodeViewController: UIViewController {

    private let textView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.font = UIFont(name: "Menlo", size: 14) // Fonte monoespaçada
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    var codeText: String

    init(codeText: String, exerciseTitle: String) {
        self.codeText = codeText
        super.init(nibName: nil, bundle: nil)
        self.title = "Código - \(exerciseTitle)"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(textView)
        setupConstraints()
        textView.text = codeText
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
