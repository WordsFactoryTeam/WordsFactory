//
//  ViewController.swift
//  WordsFactory
//
//  Created by Антон Нехаев on 01.07.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        let circleView = TimerCircle()
        circleView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(circleView)
        
        NSLayoutConstraint.activate([
            circleView.heightAnchor.constraint(equalToConstant: 150),
            circleView.widthAnchor.constraint(equalToConstant: 150),
            circleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            circleView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        print(circleView.frame)
        circleView.startTimer { [weak self] in
            self?.view.backgroundColor = .orange
        }
    }


}

