//
//  TaskBarViewController.swift
//  NameEntering
//
//  Created by Егор Батяев on 17.02.2026.
//

import UIKit

class TaskBarViewController: UIViewController {
    
    // MARK: - Properties
    
    var onButtonTap: ((Int) -> Void)?
    private var selectedIndex = 0
    
    // MARK: - Subviews
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.15, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 24
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var homeButton: UIButton = createButton(
        title: "Главная",
        imageName: "house.fill",
        tag: 0
    )
    
    private lazy var firstButton: UIButton = createButton(
        title: "Опция 1",
        imageName: "magnifyingglass",
        tag: 1
    )
    
    private lazy var secondButton: UIButton = createButton(
        title: "Опция 2",
        imageName: "star.fill",
        tag: 2
    )
    
    private lazy var thirdButton: UIButton = createButton(
        title: "Опция 3",
        imageName: "person.fill",
        tag: 3
    )
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        selectButton(at: 0)
    }
    
    // MARK: - Methods
    
    private func setupUI() {
        view.backgroundColor = .clear
        
        view.addSubview(backgroundView)
        view.addSubview(stackView)
        
        [homeButton, firstButton, secondButton, thirdButton].forEach {
            stackView.addArrangedSubview($0)
        }
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12),
            
            stackView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 4),
            stackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 4),
            stackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -4),
            stackView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -4)
        ])
    }
    
    private func createButton(title: String, imageName: String, tag: Int) -> UIButton {
        var configuration = UIButton.Configuration.plain()
        configuration.title = title
        configuration.image = UIImage(systemName: imageName)
        configuration.imagePadding = 4
        configuration.imagePlacement = .top
        
        // Уменьшаем размер текста
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 9, weight: .medium) // ОЧЕНЬ МАЛЕНЬКИЙ ТЕКСТ
            return outgoing
        }
        
        let button = UIButton(configuration: configuration)
        button.tag = tag
        button.tintColor = .lightGray
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        selectButton(at: sender.tag)
        onButtonTap?(sender.tag)
    }
    
    func selectButton(at index: Int) {
        selectedIndex = index
        
        [homeButton, firstButton, secondButton, thirdButton].enumerated().forEach { (i, button) in
            button.tintColor = i == index ? .white : .lightGray
        }
    }
}
