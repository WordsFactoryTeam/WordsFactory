//
//  DynamicTableCell.swift
//  WordsFactory
//
//  Created by Антон Нехаев on 04.07.2023.
//


import UIKit


final class DynamicTableCell: UITableViewCell {
    private let title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .gray
        
        return title
    }()
    
    
    var detailsLabel: UILabel = {
        let detailsLabel = UILabel()
        detailsLabel.translatesAutoresizingMaskIntoConstraints = false
        detailsLabel.textColor = .black
        detailsLabel.numberOfLines = 0
        detailsLabel.font = .init(name:"HelveticaNeue", size: 18.0)
        
        return detailsLabel
    }()
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    func setInfo(title: String, details: String) {
        self.title.text = title
        self.detailsLabel.text = details
    }
    
    func setInfo(info: UIWord) {
        self.title.text = info.wordOriginal
        self.detailsLabel.text = info.wordTranslations.joined(separator: ", ")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(title)
        contentView.addSubview(detailsLabel)
        
        self.backgroundColor = .white
        NSLayoutConstraint.activate(staticConstraints())
    }
    
    func staticConstraints() -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(contentsOf: [
            title.topAnchor.constraint(equalTo: contentView.topAnchor,
                                       constant: 5.0),
            title.heightAnchor.constraint(lessThanOrEqualToConstant: 18),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                           constant: 5),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        constraints.append(contentsOf: [
            detailsLabel.topAnchor.constraint(equalTo: title.bottomAnchor,
                                              constant: 8.0),
            detailsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                 constant: -12.0),
            detailsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                  constant: 5),
            detailsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                   constant: -45)
        ])
        
        return constraints
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

