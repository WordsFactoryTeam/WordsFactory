//
//  QuizViewController.swift
//  WordsFactory
//
//  Created by Алёна Максимова on 13.07.2023.
//

import UIKit

class QuizViewController: UIViewController {
    
    let timer: TimerCircle = TimerCircle()
    var currentWord = 0
    let numberOfWords = 5
    
    
    private lazy var dictionaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "There are \(numberOfWords) words\n in your Dictionary."
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var counterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "\(currentWord) of \(numberOfWords)"
        label.textColor = UIColor(named: "InactiveTabBarItemColor")
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        
        return stackView
        
    }()
    
    private lazy var progressBar: UIProgressView = {
        let bar = UIProgressView()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.setProgress(0, animated: true)
        bar.progressTintColor = UIColor(named: "PrimaryColor")
        bar.transform = bar.transform.scaledBy(x: 1, y: 2)
        
        return bar
    }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(timer)
        timer.startTimer(complition: {
            self.timer.removeFromSuperview()
            self.setUpViews()
        })
        
        view.backgroundColor = UIColor(named: "BackgroundColor")
        NSLayoutConstraint.activate(timerConstraints())
        
    }
    
    func timerConstraints() -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(contentsOf: [
            timer.heightAnchor.constraint(equalToConstant: 150),
            timer.widthAnchor.constraint(equalToConstant: 150),
            timer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timer.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        return constraints
    }
    
    func staticConstraints() -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(contentsOf: [
            counterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            counterLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 140),
            dictionaryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dictionaryLabel.topAnchor.constraint(equalTo: counterLabel.bottomAnchor, constant: 16),
            dictionaryLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            buttonsStackView.topAnchor.constraint(equalTo: dictionaryLabel.bottomAnchor, constant: 120),
            buttonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            progressBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            progressBar.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
        ])
        
        return constraints
    }
    
    func updateProgress(currentValue: Float, maxValue: Float) {
        let progress = currentValue / maxValue
        progressBar.setProgress(progress, animated: true)
    }
    
    func setUpViews() {
        NSLayoutConstraint.deactivate(timerConstraints())
        
        setUpButtons()
        view.addSubview(dictionaryLabel)
        view.addSubview(counterLabel)
        view.addSubview(buttonsStackView)
        view.addSubview(progressBar)
        NSLayoutConstraint.activate(staticConstraints())
    }
    
    private func setUpButtons() {
        let firstOptionButton = UIButton()
        firstOptionButton.translatesAutoresizingMaskIntoConstraints = false
        firstOptionButton.layer.cornerRadius = 12
        firstOptionButton.layer.borderWidth = 1
        firstOptionButton.layer.borderColor = UIColor(named: "SecondaryTextColor")?.cgColor ?? UIColor.black.cgColor
        firstOptionButton.setTitle("Option 1", for: .normal)
        firstOptionButton.titleLabel?.textAlignment = .center
      
        firstOptionButton.setTitleColor(UIColor(named: "SecondaryTextColor") ?? .black, for: .normal)
        firstOptionButton.addTarget(self, action: #selector(showNextWord), for: .touchUpInside)
        
        let secondOptionButton = UIButton()
        secondOptionButton.translatesAutoresizingMaskIntoConstraints = false
        secondOptionButton.layer.cornerRadius = 12
        secondOptionButton.layer.borderWidth = 1
        secondOptionButton.layer.borderColor = UIColor(named: "SecondaryTextColor")?.cgColor ?? UIColor.black.cgColor
        secondOptionButton.setTitle("Option 2", for: .normal)
        secondOptionButton.titleLabel?.textAlignment = .center

        secondOptionButton.setTitleColor(UIColor(named: "SecondaryTextColor") ?? .black, for: .normal)

        secondOptionButton.addTarget(self, action: #selector(showNextWord), for: .touchUpInside)
        
        let thirdOptionButton = UIButton()
        thirdOptionButton.translatesAutoresizingMaskIntoConstraints = false
        thirdOptionButton.layer.cornerRadius = 12
        thirdOptionButton.layer.borderWidth = 1
        thirdOptionButton.layer.borderColor = UIColor(named: "SecondaryTextColor")?.cgColor ?? UIColor.black.cgColor
        thirdOptionButton.setTitle("Option 3", for: .normal)
        thirdOptionButton.titleLabel?.textAlignment = .center
      
        thirdOptionButton.setTitleColor(UIColor(named: "SecondaryTextColor") ?? .black, for: .normal)
      
        thirdOptionButton.addTarget(self, action: #selector(showNextWord), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            firstOptionButton.heightAnchor.constraint(equalToConstant: 50),
            secondOptionButton.heightAnchor.constraint(equalToConstant: 50),
            thirdOptionButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        buttonsStackView.addArrangedSubview(firstOptionButton)
        buttonsStackView.addArrangedSubview(secondOptionButton)
        buttonsStackView.addArrangedSubview(thirdOptionButton)
    }
    
    @objc func showNextWord() {
        if (currentWord+1 == numberOfWords) {
            view.subviews.forEach { subView in
                subView.removeFromSuperview()
            }
            let resultView = ResultView()
            resultView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(resultView)
            NSLayoutConstraint.deactivate(staticConstraints())
            
            NSLayoutConstraint.activate([
                resultView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                resultView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                resultView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1)
            ])
        }
        currentWord += 1
        counterLabel.text = "\(currentWord) of \(numberOfWords)"
        updateProgress(currentValue: Float(currentWord), maxValue: Float(numberOfWords))
    }

}
