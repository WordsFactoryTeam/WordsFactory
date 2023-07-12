//
//  DynamicTable.swift
//  WordsFactory
//
//  Created by Антон Нехаев on 04.07.2023.
//

import UIKit

final class DynamicTable: UITableView {
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
            setNeedsLayout()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        let height = min(.infinity, contentSize.height)
        return CGSize(width: contentSize.width, height: height)
    }
}
