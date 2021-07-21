//
//  ExImageView.swift
//  udc
//
//  Created by 도로맥 on 2021/07/21.
//

import Foundation
import UIKit
import Kingfisher


class EXImageView: UIView {
    
    var defaultImageView = UIImageView(named: "noimg01") // TODO
    private let placeholderView = UIView(bgColor: .surfaceBlack)
    
    fileprivate var imageView: UIImageView!

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    init(contentMode: UIView.ContentMode) {
        super.init(frame: CGRect.zero)
        setup(contentMode: contentMode)
    }
    
    func setup(contentMode: UIView.ContentMode = .scaleAspectFill) {
        translatesAutoresizingMaskIntoConstraints = false
        defaultImageView.translatesAutoresizingMaskIntoConstraints = false
        placeholderView.addSubview(defaultImageView)
        defaultImageView.activateCenterConstraints(to: placeholderView)
        placeholderView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.contentMode = .scaleAspectFit // .scaleAspectFill
        imageView.contentMode = contentMode
        imageView.clipsToBounds = true

        addSubview(imageView)
        addSubview(placeholderView)
        let views = ["placeholderView": placeholderView, "imageView": imageView!]
        addConstraints("H:|[placeholderView]|", views: views)
        addConstraints("V:|[placeholderView]|", views: views)
        addConstraints("H:|[imageView]|", views: views)
        addConstraints("V:|[imageView]|", views: views)
    }
    
    var imageUrl: URL? {
        didSet {
            guard let imageUrl = imageUrl else {
                addSubview(placeholderView)
                imageView.image = nil
                return
            }
            
//            imageUrl.deletePathExtension()
//            imageUrl.appendPathExtension("")
            
            
            addSubview(imageView)
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: imageUrl, placeholder: nil, options: [.transition(.fade(0.2))]) {result in
                if case let .failure(error) = result {
                    debugE("EXImageView.imageUrl.didSet failed: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func setLocalImageUrl(url: URL?){
        guard let url = url else { return }
        let provider = LocalFileImageDataProvider(fileURL: url)
        addSubview(imageView)
        imageView.kf.setImage(with: provider,placeholder: nil, options: [.transition(.fade(0.2))]) {_ in
        }
    }
    
    var image: UIImage? {
        didSet {
            guard let image = image else {
                addSubview(placeholderView)
                imageView.image = nil
                return
            }
            
            addSubview(imageView)
            imageView.image = image
        }
    }
    
}


final class EXContentImageView: EXImageView {
    override func setup(contentMode: UIView.ContentMode = .scaleAspectFill) {
        super.setup(contentMode: contentMode)
        isUserInteractionEnabled = true
        imageView.layer.borderColor = UIColor.imageBorder.cgColor
        imageView.layer.borderWidth = 0.5
    }
}


final class EXImageTVCell: EXTableViewCell {
    
    let contentImageView = EXImageView()
    
    override func setup() {
        super.setup()
        
        contentView.addSubview(contentImageView)
        
        let views = ["contentImageView": contentImageView]
        contentView.addConstraints("H:|[contentImageView]|", views: views)
        contentView.addConstraints("V:|[contentImageView]|", views: views)
    }
    
}
