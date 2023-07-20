//
//  MainTrainingPresenter.swift.swift
//  WordsFactory
//
//  Created by Алёна Максимова on 13.07.2023.
//

import Foundation

protocol MainTrainingViewPresenter {
    init(view: MainTrainingView)
    func viewDidLoad()
    //func deleteWord(for index: Int)
}

class MainTrainingPresenter: MainTrainingViewPresenter {
    weak var view: MainTrainingView?
//    private var items = [UIWord]()
    
    
    
    // MARK: - Private methods
    
    
    
    
    // MARK: - Protocol methods
    required init(view: MainTrainingView) {
        self.view = view
    }
    
    func viewDidLoad() {
    }
    
}

