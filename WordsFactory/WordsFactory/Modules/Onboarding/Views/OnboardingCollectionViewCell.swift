//
//  OnboardingCollectionViewCell.swift
//  WordsFactory
//
//  Created by Антон Нехаев on 15.07.2023.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: OnboardingCollectionViewCell.self)
    
    // MARK: - private properties
    private let slideImageView: UIImageView = {
        let slideImageView = UIImageView()
        slideImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return slideImageView
    }()
    
    private let slideTitleLabel: UILabel = {
        let slideTitleLabel = UILabel()
        slideTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        slideTitleLabel.textAlignment = .center
        slideTitleLabel.numberOfLines = 0
        slideTitleLabel.font = UIFont(name: "Rubik-Medium", size: 24)
        
        return slideTitleLabel
    }()
    
    private let slideDescriptionLabel: UILabel = {
        let slideDescriptionLabel = UILabel()
        slideDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        slideDescriptionLabel.textAlignment = .center
        slideDescriptionLabel.numberOfLines = 0
        slideDescriptionLabel.font = UIFont(name: "Rubik", size: 14)
        slideDescriptionLabel.textColor = UIColor(named: "SecondaryTextColor")
        
        return slideDescriptionLabel
    }()
    
    
    // MARK: - UI set up
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        contentView.addSubview(slideImageView)
        contentView.addSubview(slideTitleLabel)
        contentView.addSubview(slideDescriptionLabel)
        NSLayoutConstraint.activate(staticConstraints())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func staticConstraints() -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(contentsOf: [
            slideImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            slideImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6),
//            slideImageView.heightAnchor.constraint(equalToConstant: 229),
//            slideImageView.widthAnchor.constraint(equalToConstant: 333),
            slideImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            slideImageView.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
        
        constraints.append(contentsOf: [
            slideTitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            slideTitleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            slideTitleLabel.topAnchor.constraint(equalTo: slideImageView.bottomAnchor, constant: 20)
        ])
        
        constraints.append(contentsOf: [
            slideDescriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            slideDescriptionLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            slideDescriptionLabel.topAnchor.constraint(equalTo: slideTitleLabel.bottomAnchor, constant: 20)
        ])
        return constraints
    }
    
    // MARK: - Public methods
    func setUp(_ slide: OnboardingSlide) {
        slideImageView.image = slide.image
        slideTitleLabel.text = slide.title
        slideDescriptionLabel.text = slide.description
    }
}
