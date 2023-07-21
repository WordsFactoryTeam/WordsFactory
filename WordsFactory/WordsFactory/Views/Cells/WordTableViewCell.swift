//
//  SearchTableViewCell.swift
//  WordsFactory
//
//  Created by SHREDDING on 20.07.2023.
//

import UIKit

class WordTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var viewContainer: UIView!
    
    
    @IBOutlet weak var wordLabel: UILabel!
    
    @IBOutlet weak var detailsLabel: UILabel!
    
    
    
    @IBOutlet weak var speakButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewContainer.layer.shadowColor = UIColor.black.cgColor
        
        viewContainer.layer.shadowOpacity = 0.3
        viewContainer.layer.shadowOffset = CGSize(width: 0, height: 2)
        viewContainer.layer.shadowRadius = 5
        viewContainer.layer.cornerRadius = 20
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDictionaryInfo(info: Word) {
        self.wordLabel.text = info.word
        self.detailsLabel.text = info.meaning.map{
            $0.word
        }.joined(separator: ", ")
    }
    
}
