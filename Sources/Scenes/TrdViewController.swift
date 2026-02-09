//
//  TrdViewController.swift
//  NameEntering
//
//  Created by Егор Батяев on 09.02.2026.
//

import UIKit

class TrdViewController: UIViewController {
    
    // MARK: - Properties
    
    var name: String?
    
    private var data = ["Понедельник", "Вторник", "Среда", "Четверг",
                        "Пятница", "Суббота", "Воскресенье"]
    
    // MARK: - Subviews
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private lazy var chosen_cell_text: UILabel = {
        let chosen_cell_text = UILabel()
        chosen_cell_text.text = ""
        chosen_cell_text.textAlignment = .center
        chosen_cell_text.textColor = .white
        chosen_cell_text.font = .systemFont(ofSize: 30, weight: .bold)
        chosen_cell_text.translatesAutoresizingMaskIntoConstraints = false
        return chosen_cell_text
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Methods
    
    private func configureUI() {
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
                    tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                    tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200)
        ])
        
        view.addSubview(chosen_cell_text)
        
        NSLayoutConstraint.activate([
            chosen_cell_text.heightAnchor.constraint(equalToConstant: 40),
            chosen_cell_text.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 10),
            chosen_cell_text.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            chosen_cell_text.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36)
        ])
        
    }
    
}

// MARK: - UITableViewDataSource
extension TrdViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate
extension TrdViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        chosen_cell_text.text = data[indexPath.row]
        print("Выбрана ячейка: \(data[indexPath.row])")
    }
}
