//
//  MainContainerViewController.swift
//  NameEntering
//
//  Created by Егор Батяев on 17.02.2026.
//

import UIKit
import SwiftUI


class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    var name: String?
    
    // Контроллеры для переключения
    private lazy var homeViewController: FstViewController = {
        let vc = FstViewController()
        return vc
    }()
    
    private lazy var collection1ViewController: UIViewController = {
        let vc = FthViewController()
        return vc
    }()
    
    private lazy var collection2ViewController: UIViewController = {
        let swiftUIView = FfthView(name: name)
        let hostingController = UIHostingController(rootView: swiftUIView)
        hostingController.title = "Опция 2"
        return hostingController
    }()
    
    private lazy var collection3ViewController: UIViewController = {
        let vc = TrdViewController()
        return vc
    }()
    
    private var currentViewController: UIViewController?
    
    // MARK: - Subviews
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private lazy var taskBarController: TaskBarViewController = {
        let controller = TaskBarViewController()
        controller.onButtonTap = { [weak self] tag in
            self?.switchToViewController(at: tag)
        }
        return controller
    }()
    
    private lazy var taskBarContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTaskBar()
        
        switchToViewController(at: 0)
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupTaskBar() {
        view.addSubview(taskBarContainer)
        addChild(taskBarController)
        taskBarContainer.addSubview(taskBarController.view)
        taskBarController.view.frame = taskBarContainer.bounds
        taskBarController.view.translatesAutoresizingMaskIntoConstraints = false
        taskBarController.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
            containerView.bottomAnchor.constraint(equalTo: taskBarContainer.topAnchor),
            
            taskBarContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            taskBarContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            taskBarContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            taskBarContainer.heightAnchor.constraint(equalToConstant: 80),
            
            taskBarController.view.topAnchor.constraint(equalTo: taskBarContainer.topAnchor),
            taskBarController.view.leadingAnchor.constraint(equalTo: taskBarContainer.leadingAnchor),
            taskBarController.view.trailingAnchor.constraint(equalTo: taskBarContainer.trailingAnchor),
            taskBarController.view.bottomAnchor.constraint(equalTo: taskBarContainer.bottomAnchor)
        ])
    }
    
    // MARK: - View Controller Switching
    
    private func switchToViewController(at index: Int) {
        currentViewController?.willMove(toParent: nil)
        currentViewController?.view.removeFromSuperview()
        currentViewController?.removeFromParent()
        
        let newViewController: UIViewController
        
        switch index {
        case 0:
            newViewController = homeViewController
        case 1:
            newViewController = collection1ViewController
        case 2:
            newViewController = collection2ViewController
        case 3:
            newViewController = collection3ViewController
        default:
            return
        }
        
        addChild(newViewController)
        containerView.addSubview(newViewController.view)
        newViewController.view.frame = containerView.bounds
        newViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            newViewController.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            newViewController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            newViewController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            newViewController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        newViewController.didMove(toParent: self)
        currentViewController = newViewController
        
        taskBarController.selectButton(at: index)
    }
}
