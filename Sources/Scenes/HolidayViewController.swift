//
//  HolidayViewController.swift
//  NameEntering
//
//  Created by Егор Батяев on 01.03.2026.
//

import UIKit

class HolidayViewController: UIViewController {
    
    // MARK: - Models of data
    
    struct Country: Decodable{
        let isoCode: String
    }
    
    struct HolidayName: Decodable{
        let language: String
        let text: String
    }
    struct Holiday: Decodable{
        let id: String
        let country: Country
        let name: [HolidayName]
    }
    
    // MARK: - Properties
    
    private var holidays: [Holiday] = []
    
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
        chosen_cell_text.font = .systemFont(ofSize: 20, weight: .bold)
        chosen_cell_text.translatesAutoresizingMaskIntoConstraints = false
        return chosen_cell_text
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchHolidays()   // ← ЭТОГО НЕ ХВАТАЕТ
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
    
    private func todayString() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: Date())
    }
    
    private func fetchHolidays(){
        let date = todayString()
        let url_string = "https://openholidaysapi.org/PublicHolidaysByDate?date=\(date)&languageIsoCode=RU"
        guard let url = URL(string: url_string) else {return}
        URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
            guard let data = data else {return}
            do {
                let decoded = try JSONDecoder().decode([Holiday].self, from: data)
                DispatchQueue.main.async{
                    self?.holidays = decoded
                    self?.tableView.reloadData()
                }
                
            } catch {
                print("Ошибка декодирования: ", error)
                
            }
        }.resume()
        
    }
    
}

// MARK: - UITableViewDataSource
extension HolidayViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return holidays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let holiday = holidays[indexPath.row]
        
        let name = holiday.name.first?.text ?? "Неизвестно"
        let country = holiday.country.isoCode
        
        cell.textLabel?.text = "\(country) - \(name)"
        cell.textLabel?.numberOfLines = 0
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension HolidayViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let holiday = holidays[indexPath.row]
        let name = holiday.name.first?.text ?? "Неизвестно"
        let country = holiday.country.isoCode
                
        chosen_cell_text.text = "Выбрано:\n\(country) — \(name)"
                
        print("Выбран праздник:", name)
    }
}

