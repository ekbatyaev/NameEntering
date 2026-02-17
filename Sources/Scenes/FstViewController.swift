//
//  FstViewController.swift
//  BaseApp
//
//  Created by Aleksandr Grachev on 31.01.2026.
//

import UIKit

class FstViewController: UIViewController {
    
    // MARK: - Properties
    
    var text: String? = "Some text"
    let images: [String] = ["raven-1"]
    
    // MARK: - Subviews
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Ворона HSE 🐦‍⬛"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 50, weight: .bold)
        label.textColor = .black
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.textColor = .black
        label.font = .systemFont(ofSize: 26)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var first_button: UIButton = {
        let button = UIButton()
        button.setTitle("Ввести имя", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.addAction(
            .init { [weak self] _ in
                self?.go_second_view_controller()
            }, for: .touchUpInside)
        return button
    }()
    
    private lazy var second_button: UIButton = {
        let button = UIButton()
        button.setTitle("Выбрать день недели", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.addAction(
            .init { [weak self] _ in
                self?.go_third_view_controller()
            }, for: .touchUpInside)
        return button
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: images[0])
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Methods
    
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(label)
        view.addSubview(imageView)
        view.addSubview(resultLabel)
        view.addSubview(first_button)
        view.addSubview(second_button)
        
        NSLayoutConstraint.activate([
            // Label
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            // ImageView
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 30),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            // ResultLabel
            resultLabel.heightAnchor.constraint(equalToConstant: 56),
            resultLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),
            
            // First Button
            first_button.heightAnchor.constraint(equalToConstant: 56),
            first_button.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 30),
            first_button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            first_button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),
            
            // Second Button - ИСПРАВЛЕНО!
            second_button.heightAnchor.constraint(equalToConstant: 56),
            second_button.topAnchor.constraint(equalTo: first_button.bottomAnchor, constant: 20),
            second_button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            second_button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36)
        ])
    }
    
    private func go_second_view_controller() {
        let controller = ScndViewController()
        controller.title = "Регистрация имени"
        controller.name = "Введите имя"
        controller.setTextAction = { [weak self] text in
            self?.resultLabel.text = "Привет, \(text)!"
        }
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func go_third_view_controller() {
        let controller = TrdViewController()
        controller.title = "Выбрать день недели"
        navigationController?.pushViewController(controller, animated: true)
    }
}
