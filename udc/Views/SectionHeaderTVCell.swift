//
//  SectionHeaderTVCell.swift
//  udc
//
//  Created by 도로맥 on 2021/07/22.
//

import UIKit


final class SectionHeaderTVCell: UITableViewHeaderFooterView {
    
    let titleLabel = UILabel(text: "", font: .bold25, color: .white)

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    private func setup() {
        contentView.backgroundColor = .bgBlack
        contentView.addSubview(titleLabel)
        
        let views = ["titleLabel": titleLabel]
        contentView.addConstraints("H:|-24-[titleLabel]-24-|", views: views)
        contentView.addConstraints("V:|-24-[titleLabel]-(10@750)-|", views: views)
    }

}
