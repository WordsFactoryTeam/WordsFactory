//
//  UITableView+Extension.swift
//  WordsFactory
//
//  Created by Антон Нехаев on 04.07.2023.
//

import UIKit

public extension UITableView{
    func setEmptyDataView(image: UIImage, title: String){
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        
        let picture = UIImageView()
        let titleLabel = UILabel()
        
        picture.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        picture.image = image
        picture.contentMode = .scaleAspectFit
        
        titleLabel.text = title
        
        
        titleLabel.textColor = UIColor(named: "SecondaryTextColor") ?? UIColor.black
        
        
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textAlignment = .center
        
        emptyView.addSubview(picture)
        emptyView.addSubview(titleLabel)
        
        let constraints = [
            picture.widthAnchor.constraint(equalToConstant: 375),
            picture.heightAnchor.constraint(equalToConstant: 253),
            picture.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -100),
            picture.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: picture.bottomAnchor, constant: 10)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        self.backgroundView = emptyView
        
    }
    
    func removeEmptyDataView(){
        self.backgroundView = nil
    }
}
