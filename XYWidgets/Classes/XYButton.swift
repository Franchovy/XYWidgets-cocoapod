//
//  XYButton.swift
//  XYWidgets
//
//  Created by Maxime Franchot on 10/07/2021.
//

import UIKit

@IBDesignable
public class XYButton: UIButton {
    private let contentView = UIView()

    private var gradientBorderLayer: CAGradientLayer?
    private var gradientBackgroundLayer: CAGradientLayer?
    private var gradientBorderShapeLayer: CAShapeLayer?
    private var backgroundLayer = CALayer()

    private var isAnimating = false
    
    // Public properties
    @IBInspectable public var animates: Bool = true
    @IBInspectable public var hapticsEnabled: Bool = true
    @IBInspectable public var padding: UIEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    
    @IBInspectable public var backgroundGradient: [UIColor]? {
        didSet {
            if (backgroundGradient == nil) {
                return
            }
            
            if (gradientBackgroundLayer == nil) {
                gradientBackgroundLayer = CAGradientLayer()
                
                gradientBackgroundLayer!.startPoint = CGPoint(x: 0.0, y: 0.8)
                gradientBackgroundLayer!.endPoint = CGPoint(x: 1.0, y: 0.2)
                
                contentView.layer.insertSublayer(
                    gradientBackgroundLayer!,
                    above: backgroundLayer
                )
            }
            
            gradientBackgroundLayer!.colors = backgroundGradient!.map({ $0.cgColor })
        }
    }
    
    @IBInspectable public var borderGradient: [UIColor]? {
        didSet {
            if (borderGradient == nil) {
                return
            }
            
            if (gradientBorderLayer == nil) {
                gradientBorderLayer = CAGradientLayer()
                gradientBorderShapeLayer = CAShapeLayer()
                gradientBorderShapeLayer!.fillColor = UIColor.clear.cgColor
                gradientBorderShapeLayer!.borderColor = UIColor.black.cgColor
                
                gradientBorderLayer!.startPoint = CGPoint(x: 0.0, y: 0.8)
                gradientBorderLayer!.endPoint = CGPoint(x: 1.0, y: 0.2)
                gradientBorderLayer!.mask = gradientBorderShapeLayer!
                
                gradientBorderShapeLayer!.borderWidth = 2
                contentView.layer.insertSublayer(gradientBorderLayer!, above: imageView?.layer)
            }
            
            gradientBorderLayer!.colors = borderGradient!.map({ $0.cgColor })
        }
    }
    
    public override var backgroundColor: UIColor? {
        set {
            backgroundLayer.backgroundColor = newValue?.cgColor
        }
        get {
            if backgroundLayer.backgroundColor == nil { return nil}
            else { return UIColor(cgColor: backgroundLayer.backgroundColor!) }
        }
    }
    
    init(title: String? = nil, font: UIFont? = nil) {
        super.init(frame: .zero)
        
        commonInit(title: title, font: font)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        //let title = coder.value(forKey: "title") as? String
        //let font = coder.value(forKey: "font") as? UIFont
        
        commonInit(title: nil, font: nil)
    }
    
    private func commonInit(title: String? = nil, font: UIFont? = nil) {
        if (title != nil) {
            setTitle(title, for: .normal)
        }
        if (font != nil) {
            titleLabel?.font = font
        }
        
        if let imageView = imageView {
            insertSubview(contentView, belowSubview: imageView)
        } else {
            addSubview(contentView)
        }
        contentView.isUserInteractionEnabled = false
        
        imageView?.contentMode = .scaleAspectFill
        
        contentView.layer.masksToBounds = false
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 1, height: 1)
        contentView.layer.shadowRadius = 1
        contentView.layer.shadowOpacity = 0.6
        
        // Text button stuff
        contentVerticalAlignment = .center
        contentHorizontalAlignment = .center
        
        // Image button stuff
        contentMode = .scaleAspectFill
        
        backgroundLayer.masksToBounds = true
        contentView.layer.addSublayer(backgroundLayer)
        
    }
    
    public override func layoutSubviews() {
        guard !isAnimating else {
            return
        }
        
        // Adjust size to fit padding
        if (frame.size.width != intrinsicContentSize.width + padding.left + padding.right) {
            let prevWidth = frame.size.width
            frame.size.width = intrinsicContentSize.width + padding.left + padding.right
            let diffWidth = prevWidth - frame.size.width
            frame.origin.x += diffWidth/2
        }
        if (frame.size.height != intrinsicContentSize.height + padding.top + padding.bottom) {
            let prevHeight = frame.size.height
            frame.size.height = intrinsicContentSize.height + padding.top + padding.bottom
            let diffHeight = prevHeight - frame.size.height
            frame.origin.y += diffHeight/2
        }
        
        
        super.layoutSubviews()
        
        contentView.frame = self.bounds
        
        backgroundLayer.frame = bounds
        backgroundLayer.cornerRadius = height/2
        
        gradientBackgroundLayer?.frame = bounds
        gradientBackgroundLayer?.cornerRadius = height/2
        
        gradientBorderLayer?.frame = bounds
        gradientBorderLayer?.cornerRadius = height/2
        
        gradientBorderShapeLayer?.frame = bounds
        gradientBorderShapeLayer?.cornerRadius = height/2
    }
    
    public func increaseTouchSize(by amount: CGFloat) {
        contentEdgeInsets = UIEdgeInsets(top: amount, left: amount, bottom: amount, right: amount)
    }
    
    public override func sizeToFit() {
        super.sizeToFit()
        
        // If text button
        frame.size.width = intrinsicContentSize.width + padding.left + padding.right
        frame.size.height = intrinsicContentSize.height + padding.top + padding.bottom
    }
    
    private func animateSelect() {
        alpha = 0.8
        isAnimating = true
        
        UIView.animate(withDuration: 0.1) {
            self.contentView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            self.titleLabel?.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            self.imageView?.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        } completion: { (done) in
            if done {
                self.isAnimating = false
            }
        }
    }
    
    private func animateDeselect() {
        alpha = 1.0
        isAnimating = true
        
        UIView.animate(withDuration: 0.2) {
            self.contentView.transform = .identity
            self.titleLabel?.transform = .identity
            self.imageView?.transform = .identity
        } completion: { (done) in
            if done {
                self.isAnimating = false
            }
        }
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
                
        //HapticsManager.shared.vibrateImpact(for: .light)
        
        animateSelect()
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        if isSelected {
            //HapticsManager.shared.vibrateImpact(for: .rigid)
        }
        
        animateDeselect()
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        animateDeselect()
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)

        if isHighlighted {
            animateSelect()
        } else {
            animateDeselect()
        }
    }
    
    public override var isEnabled: Bool {
        didSet {
            alpha = isEnabled ? 1.0 : 0.4
        }
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        // Setup colors
    }
}
