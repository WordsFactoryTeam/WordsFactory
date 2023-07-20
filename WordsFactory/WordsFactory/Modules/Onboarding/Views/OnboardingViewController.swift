//
//  OnboardingViewController.swift
//  WordsFactory
//
//  Created by Антон Нехаев on 15.07.2023.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    var onExit: (() -> Void)? = nil
    
    // MARK: - Private properties
    
    private var slides: [OnboardingSlide] = []
    
    private var currentPage = 0 {
        didSet {
            if currentPage == slides.count - 1 {
                UIView.transition(with: nextButton,
                                  duration: 0.5,
                                  options: .transitionCrossDissolve,
                                  animations: {
                    self.nextButton.setTitle("Let's Start", for: .normal)
                }, completion: nil)
            } else if currentPage == slides.count - 2 && oldValue == slides.count - 1{
                UIView.transition(with: nextButton,
                                  duration: 0.5,
                                  options: .transitionCrossDissolve,
                                  animations: {
                    self.nextButton.setTitle("Next", for: .normal)
                }, completion: nil)
            } else {
                self.nextButton.setTitle("Next", for: .normal)
            }
            pageControl.currentPage = currentPage
        }
    }
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(
            OnboardingCollectionViewCell.self,
            forCellWithReuseIdentifier: OnboardingCollectionViewCell.identifier
        )
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        
        return collectionView
    }()
    
    private let nextButton: UIButton = {
        let nextButton = UIButton()
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.backgroundColor = UIColor(named: "PrimaryColor") ?? .orange
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.setTitleColor(UIColor(named: "InactiveTabBarItemColor"), for: .highlighted)
        nextButton.titleLabel?.font = UIFont(name: "Rubik-Medium", size: 16)
        
        nextButton.addTarget(self, action: #selector(nextBtnClicked), for: .touchUpInside)
        
        return nextButton
        
    }()
    
    @objc func nextBtnClicked() {
        if currentPage == slides.count - 1 {
            onExit?()
            return
        }
        currentPage += 1
        let indexPath = IndexPath(
            row: currentPage,
            section: 0
        )
        
        collectionView.scrollToItem(
            at: indexPath,
            at: .centeredHorizontally,
            animated: true
        )
    }
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        pageControl.pageIndicatorTintColor = UIColor(named: "InactiveTabBarItemColor") ?? .gray
        pageControl.currentPageIndicatorTintColor = UIColor(named: "PrimaryColor") ?? .orange
        pageControl.isUserInteractionEnabled = false
        
        return pageControl
    }()
    
    // MARK: - Set up UI
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slides = [
            OnboardingSlide(title: "Learn anytime\nand anywhere",
                            description: "All your words always with you!",
                            image: UIImage(named: "onboarding0")!),
            OnboardingSlide(title: "Find a course\n for you",
                            description: "Search for new words!",
                            image: UIImage(named: "onboarding1")!),
            OnboardingSlide(title: "Improve your skills",
                            description: "Train words to memorize them!",
                            image: UIImage(named: "onboarding2")!),
            
        ]
        
        currentPage = 0
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = currentPage
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(nextButton)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        NSLayoutConstraint.activate(staticConstraints())
    }
    
    override func viewDidLayoutSubviews() {
        nextButton.layer.cornerRadius = 18
    }
    
    func staticConstraints() -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        // collectionView constraints
        constraints.append(contentsOf: [
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
        ])
        
        // pageControl constraints
        constraints.append(contentsOf: [
            pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // nextButton constraints
        constraints.append(contentsOf: [
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            nextButton.heightAnchor.constraint(equalToConstant: 65),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        ])
        
        return constraints
    }
}

extension OnboardingViewController: UICollectionViewDelegate,
                                    UICollectionViewDataSource,
                                    UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: OnboardingCollectionViewCell.identifier,
            for: indexPath
        ) as? OnboardingCollectionViewCell else { return UICollectionViewCell() }
        cell.setUp(slides[indexPath.row])
        
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        slides.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height / 2)
    }
    
    
    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {
        let x = targetContentOffset.pointee.x
        currentPage = Int(x / view.frame.width)
        pageControl.currentPage = Int(x / view.frame.width)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 0
    }
}
