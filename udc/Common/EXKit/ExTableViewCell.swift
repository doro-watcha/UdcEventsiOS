//
//  ExTableViewCell.swift
//  udc
//
//  Created by 도로맥 on 2021/07/21.
//

import Foundation
import UIKit


class EXTableViewCell: UITableViewCell {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    
    @objc dynamic func setup() {
        selectionStyle = .none
    }
    
}

