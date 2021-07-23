//
//  ProfileHeaderView.swift
//  udc
//
//  Created by 도로맥 on 2021/07/23.
//


import UIKit
import MarqueeLabel

final class ProfileHeaderView: UIView {
    
    var user: User? {
        didSet {
            guard let user = user else { return }
//            posterImageView.imageUrl = user.coverUrl
//            profileImageView.imageUrl = user.avatarUrl
//            titleLabel.text = user.name
//            subtitleLabel.text = "@" + user.userName
//            bioLabel.text = user.bio
//            settingButton.isHidden = user.isNotMe
        }
    }
    
    /**
    AboutVC에서는 About 버튼이나 Setting버튼이 아닌 Share 버튼을
    표시해주어야 하기 때문에 이 변수를 사용해서 초기에 설정
    생성자로 Set 가능
    
    - Author: MJ
    */
    private var isUsedInAbout : Bool = false
    
    var aboutTapHandler: (() -> Void)?
    var settingTapHandler: (() -> Void)?
    var shareTapHandler: (() -> Void)?

    private let posterImageView = EXImageView()
    private let profileImageView = ProfileImageView(icon: .profile_120)
    private let titleLabel = UILabel(text: "", font: .bold15, color: .white)
    private let subtitleLabel = UILabel(text: "", font: .bold12, color: .white)
    private let bioLabel = MarqueeLabel(text: "", font: .regular13, color: .white)
    private let aboutButton = UIButton(named: "accountCircleSmall")
    private let settingButton = UIButton(named: "optionsSmall")
    private let shareButton = UIButton(named: "share")

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(isUsedInAbout : Bool = false){
        self.isUsedInAbout = isUsedInAbout
        super.init(frame: .zero)
        setup()
    }
    
    private func setup() {
        /// Hero for Transition
        self.posterImageView.hero.id = "CoverImageView"
        self.profileImageView.hero.id = "ProfileImageView"
        
        self.backgroundColor = .surfaceBlack
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let buttonStack : UIStackView
        if isUsedInAbout{
            buttonStack = UIStackView(arrangedSubviews: [shareButton])
        }else{
            buttonStack = UIStackView(arrangedSubviews: [aboutButton, settingButton])
        }
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.axis = .horizontal
        buttonStack.spacing = 10
        
        aboutButton.addTarget(self, action: #selector(aboutButtonTapped), for: .touchUpInside)
        settingButton.addTarget(self, action: #selector(settingButtonTapped), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)

        addSubview(posterImageView)
        addSubview(profileImageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(bioLabel)
        addSubview(buttonStack)

        bioLabel.numberOfLines = 2
        bioLabel.fadeLength = 10

        profileImageView.imageView.layer.borderColor = UIColor.surfaceBlack.cgColor
        profileImageView.imageView.layer.borderWidth = 3

        let views = ["posterImageView": posterImageView, "profileImageView": profileImageView,
                     "titleLabel": titleLabel, "subtitleLabel": subtitleLabel, "bioLabel": bioLabel,
                     "buttonStack": buttonStack]
        
        addConstraints("H:|[posterImageView]|", views: views)
        addConstraints("V:|[posterImageView]-10-[titleLabel]-[subtitleLabel]-[bioLabel]-(>=5@750)-|", views: views)
        posterImageView.heightAnchor.constraint(equalToConstant: LayoutHelper.shared.adjustedValueForTemplateValue(130)).isActive = true

        addConstraints("H:|-10-[profileImageView]", views: views)
        addConstraints("V:[profileImageView]-5-|", views: views)

        addConstraints("H:[profileImageView]-[titleLabel]", views: views)
        addConstraints("H:[profileImageView]-[subtitleLabel]-|", views: views)
        addConstraints("H:[profileImageView]-[bioLabel]-|", views: views)

        buttonStack.setContentHuggingPriority(.required, for: .horizontal)
        addConstraints("H:[titleLabel]-[buttonStack(50@1000)]-12@1000-|", options: .alignAllCenterY, metrics: nil, views: views)
    }
    
    @objc func aboutButtonTapped() {
        aboutTapHandler?()
    }
    
    @objc func settingButtonTapped() {
        settingTapHandler?()
    }
    
    @objc func shareButtonTapped(){
        shareTapHandler?()
    }
}
