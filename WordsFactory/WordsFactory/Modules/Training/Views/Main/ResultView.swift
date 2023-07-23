//
//  ResultView.swift
//  WordsFactory
//
//  Created by Алёна Максимова on 14.07.2023.
//

import UIKit

class ResultView: UIView {
    
    private lazy var trainingImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "FinishTrainingImage.png")
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    private lazy var finishTrainingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Training is finished"
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var correctAnswersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "SecondaryTextColor") ?? .black
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var incorrectAnswersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "SecondaryTextColor") ?? .black
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var goBackButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Again", for: .normal)
        button.titleLabel?.textColor = UIColor(named: "Color") ?? .white
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = UIColor(named: "PrimaryColor") ?? .black
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(trainingImage)
        addSubview(finishTrainingLabel)
        addSubview(correctAnswersLabel)
        addSubview(incorrectAnswersLabel)
        addSubview(goBackButton)
        
        NSLayoutConstraint.activate(staticConstraints())
        
    }
    
    func setAnswers(correctAnswers: Int, incorrectAnswers: Int) {
        correctAnswersLabel.text = "Correct: \(correctAnswers)"
        incorrectAnswersLabel.text = "Incorrect: \(incorrectAnswers)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func staticConstraints() -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(contentsOf: [
            trainingImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 80),
            trainingImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            trainingImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            finishTrainingLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            finishTrainingLabel.topAnchor.constraint(equalTo: trainingImage.bottomAnchor, constant: 16),
            correctAnswersLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            correctAnswersLabel.topAnchor.constraint(equalTo: finishTrainingLabel.bottomAnchor, constant: 32),
            incorrectAnswersLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            incorrectAnswersLabel.topAnchor.constraint(equalTo: correctAnswersLabel.bottomAnchor, constant: 8),
            goBackButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            goBackButton.topAnchor.constraint(equalTo: incorrectAnswersLabel.bottomAnchor, constant: 120),
            goBackButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
            goBackButton.heightAnchor.constraint(equalToConstant: 48),
        ])
        
        return constraints
    }
    
    @objc func goBack() {
        print("dsfsf")
        window?.rootViewController?.dismiss(animated: true)
    }
}
