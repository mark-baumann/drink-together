//
//  CardView.swift
//  tinder-clone
//
//  Created by Mark Baumann on 16.03.21.
//

import UIKit


enum SwipeDirection: Int {
    case left = -1
    case right = 1
}

class CardView: UIView {
    
    
    
    
    
    private let gardientLayer = CAGradientLayer()
    
    private let viewModel: CardViewModel
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.attributedText = viewModel.infoText
        
        
        return label
    }()
    
    
    private lazy var infoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "info_icon").withRenderingMode(.alwaysOriginal), for: .normal)
    return button
    }()
    
    init(viewModel: CardViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        
        configurePanGesture()
     
        imageView.image = viewModel.user.images.first
        
        
        backgroundColor = .systemPurple
        layer.cornerRadius = 10
        clipsToBounds = true
        
        
        configureGradientLayer()
        
        addSubview(imageView)
        imageView.fillSuperview()
        
        addSubview(infoLabel)
        infoLabel.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 16, paddingRight: 16)
        
        addSubview(infoButton)
        infoButton.setDimensions(height: 40, width: 40)
        infoButton.centerY(inView: infoLabel)
        infoButton.anchor(right: rightAnchor, paddingRight: 16)
        
        
        
    }
    
    override func layoutSubviews() {
        gardientLayer.frame = self.frame
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func handlePanGesture(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: nil)
        
        switch sender.state {
        case .began:
            superview?.subviews.forEach({$0.layer.removeAllAnimations()})
        case .changed:
            PanCard(sender: sender)
        case .ended:
            resetCardPosition(sender: sender)
        default:
            break
        }
    }
    
    func PanCard(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: nil)
        let degrees: CGFloat = translation.x / 20
        let angle = degrees * .pi / 180
        let rotaationalTransform = CGAffineTransform(rotationAngle: angle)
        self.transform = rotaationalTransform.translatedBy(x: translation.x, y: translation.y)
    }
    
    @objc func handleChangePhoto(sender: UITapGestureRecognizer) {
        
    }
    
    
    func resetCardPosition(sender: UIPanGestureRecognizer){
       
        let direction: SwipeDirection = sender.translation(in: nil).x > 100 ?.right : .left
        let shouldDismissCard = abs(sender.translation(in: nil).x) > 100
        
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut) {
            
            if shouldDismissCard {
                let xTranslation = CGFloat(direction.rawValue) * 1000
                let offscreenTransform = self.transform.translatedBy(x: xTranslation, y: 0)
                self.transform = .identity
            }else{
                self.transform = .identity
            }
        
        } completion: { _ in
            if shouldDismissCard {
                self.removeFromSuperview()
            }
        }

    }
    
    func configureGradientLayer() {
        gardientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gardientLayer.locations = [0.5, 1.1]
        layer.addSublayer(gardientLayer)

    }
    
    
    func configurePanGesture() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        
        addGestureRecognizer(pan)
        
        let tab = UITapGestureRecognizer(target: self, action: #selector(handleChangePhoto))
        
    }
    
}
