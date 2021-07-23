//
//  ProfileImageView.swift
//  udc
//
//  Created by 도로맥 on 2021/07/23.
//


import UIKit
import Kingfisher

enum ProfileIcon: String {
    case profile_30
    case profile_120

    var width: CGFloat {
        get {
            switch self {
            case .profile_30: return 30
            case .profile_120: return 120
            }
        }
    }
}

final class ProfileImageView: UIView {
    
    var icon: ProfileIcon
    var imageView: UIImageView!
    private let defaultImage = UIImage(named: "noimg06") // TODO

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(icon: ProfileIcon = .profile_30) {
        self.icon = icon
        super.init(frame: .zero)
        setup()
    }

    func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        
        imageView = UIImageView(image: defaultImage)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .bgBlack
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 2
        imageView.layer.cornerRadius = icon.width / 2
        imageView.widthAnchor.constraint(equalToConstant: icon.width).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: icon.width).isActive = true
        
//        statusBadge.isHidden = true

        addSubview(imageView)
        
        let views = ["imageView": imageView!]
        addConstraints("H:|[imageView]|", views: views)
        addConstraints("V:|[imageView]|", views: views)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height/2
        self.layer.masksToBounds = true
    }

    // NOTE: 프로필 편집등 사진 업로드시 직접 image 세팅
//    var image: UIImage? {
//        didSet {
//            guard let image = image else {
//                imageView.image = defaultImage
//                return
//            }
//
//            imageView.image = image
//        }
//    }
    
    var imageUrl: URL? {
        didSet {
            guard let imageUrl = imageUrl else {
                imageView.image = defaultImage
                return
            }
            
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: imageUrl, placeholder: defaultImage, options: [.transition(.fade(0.2))]) {result in
                if case let .failure(error) = result {
                    debugE("ProfileImageView setImage failed: \(error.localizedDescription)")
                }
            }
        }
    }
    
    var user: User? {
        didSet {
            guard let user = user else {
                imageView.image = defaultImage
                return
            }

            if let imageUrl = user.avatarUrl {
                imageView.kf.setImage(with: imageUrl, placeholder: defaultImage, options: [.transition(.fade(0.2))]) {result in
                    if case let .failure(error) = result {
                        debugE("ProfileImageView.user.didSet: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    

}

