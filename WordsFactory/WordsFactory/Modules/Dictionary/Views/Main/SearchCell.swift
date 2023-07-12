//
//  SearchCell.swift
//  WordsFactory
//
//  Created by Антон Нехаев on 04.07.2023.
//

import UIKit

final class SearchCell: UITableViewCell {
    private let placeHolder: UIView = {
        var placeHolder = UIView()
        placeHolder.translatesAutoresizingMaskIntoConstraints = false
        placeHolder.layer.borderWidth = 1
        placeHolder.layer.cornerRadius = 12
        placeHolder.layer.borderColor = UIColor(named: "SecondaryTextColor")?.cgColor
        
        return placeHolder
    }()
    
    private let searchField: UITextField = {
        let searchField = UITextField()
        searchField.translatesAutoresizingMaskIntoConstraints = false
        searchField.textColor = UIColor(named: "SecondaryTextColor") ?? .black
        
        return searchField
    }()
    
    
    private let searchImage: UIImageView = {
        let searchImage = UIImageView()
        
        searchImage.translatesAutoresizingMaskIntoConstraints = false
        
        searchImage.image = UIImage(named: "SearchIcon") ?? UIImage(systemName: "magnifyingglass")
        
        return searchImage
    }()
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(placeHolder)
        placeHolder.addSubview(searchField)
//        placeHolder.addSubview(searchImage)
        
        //        searchField.delegate = self
        
        self.backgroundColor = .white
        NSLayoutConstraint.activate(staticConstraints())
    }
    
    func staticConstraints() -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(contentsOf: [
            placeHolder.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.95),
            placeHolder.heightAnchor.constraint(equalToConstant: 40),
            placeHolder.topAnchor.constraint(equalTo: contentView.topAnchor),
            placeHolder.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
        ])
        
        constraints.append(contentsOf: [
            searchField.leadingAnchor.constraint(equalTo: placeHolder.leadingAnchor, constant: 10),
            searchField.trailingAnchor.constraint(equalTo: placeHolder.trailingAnchor, constant: -10),
            searchField.topAnchor.constraint(equalTo: placeHolder.topAnchor),
            searchField.bottomAnchor.constraint(equalTo: placeHolder.bottomAnchor)
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
