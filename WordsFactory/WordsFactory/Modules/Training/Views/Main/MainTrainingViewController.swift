//
//  MainTrainingViewController.swift
//  WordsFactory
//
//  Created by Алёна Максимова on 13.07.2023.
//

import UIKit

protocol MainTrainingView: AnyObject {
    
}

final class MainTrainingViewController: UIViewController {
    var presenter: MainTrainingViewPresenter!
    
    private lazy var dictionaryLabel: UILabel = {
        let label = UILabel()
        let numberOfWords = 25
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "There are \(numberOfWords) words\n in your Dictionary."
        label.partTextColorChange(fullText: label.text!, changeText: "\(numberOfWords)")
        label.font = .boldSystemFont(ofSize: 28)
        label.textAlignment = .center
        label.numberOfLines = 2
        
        return label
    }()
    
    private lazy var callToActionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Start the Training?"
        label.font = .boldSystemFont(ofSize: 28)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var startTrainingButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start", for: .normal)
        button.titleLabel?.textColor = UIColor(named: "Color") ?? .white
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = UIColor(named: "PrimaryColor") ?? .black
        
        return button
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
            
        startTrainingButton.layer.cornerRadius = 12
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(dictionaryLabel)
        view.addSubview(callToActionLabel)
        view.addSubview(startTrainingButton)

        startTrainingButton.addTarget(self, action: #selector(didStartTraining), for: .touchUpInside)
        
        view.backgroundColor = UIColor(named: "BackgroundColor")
        NSLayoutConstraint.activate(staticConstraints())
        
        
        presenter.viewDidLoad()
    }
    
    func staticConstraints() -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(contentsOf: [
            dictionaryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dictionaryLabel.bottomAnchor.constraint(equalTo: callToActionLabel.topAnchor, constant: -24),
            callToActionLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            callToActionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startTrainingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startTrainingButton.topAnchor.constraint(equalTo: callToActionLabel.bottomAnchor, constant: 160),
            startTrainingButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            startTrainingButton.heightAnchor.constraint(equalToConstant: 48),
            
        ])
        
        return constraints
    }
    
}

// MARK: - Protocol implementation
extension MainTrainingViewController: MainTrainingView {
    @objc func didStartTraining() {
        let quizView = QuizViewController()
        present(quizView, animated: true)
    }
}

