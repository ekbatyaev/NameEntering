//
//  ScndViewController.swift
//  BaseApp
//
//  Created by Aleksandr Grachev on 31.01.2026.
//

import UIKit

protocol ScndViewControllerDelagate: AnyObject {
    func setText(_ text: String)
}

class ScndViewController: UIViewController {
    
    // MARK: - Properties
    
    var name: String?
    var setTextAction: ((String) -> Void)?
    
    weak var delegate: ScndViewControllerDelagate?
    
    // MARK: - Subviews
    
    private lazy var saveButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Сохранить", for: .normal)
            button.backgroundColor = .systemBlue
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
            button.layer.cornerRadius = 12
            button.layer.masksToBounds = true
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
            return button
        }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите ваше имя"
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 24)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clearButtonMode = .always
        return textField
    }()
    
    private lazy var label: UILabel = {
       let label = UILabel()
        label.text = name
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        textField.becomeFirstResponder()
    }
    
    // MARK: - Methods
    
    private func configureUI() {
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        view.addSubview(textField)
        
        NSLayoutConstraint.activate([
            
            textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 30),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            textField.heightAnchor.constraint(equalToConstant: 44),
        ])
        
        view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 30),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 200),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
        
    @objc private func saveButtonTapped() {
        guard let text = textField.text, !text.isEmpty else {
                let alert = UIAlertController(
                        title: "Ошибка",
                        message: "Пожалуйста, введите имя",
                        preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                present(alert, animated: true)
                return
            }
            
            print("Сохраняем текст: \(text)")
            
            setTextAction?(text)
            
            navigationController?.popViewController(animated: true)
        }
}
