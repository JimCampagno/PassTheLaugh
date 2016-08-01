//
//  ColorChangeView.swift
//  PassTheLaugh

import UIKit

final class ColorChangeView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var color1Button: UIButton!
    @IBOutlet weak var color2Button: UIButton!
    @IBOutlet weak var color3Button: UIButton!
    @IBOutlet weak var color4Button: UIButton!
    @IBOutlet weak var color5Button: UIButton!
    
    var colorPalette: ColorPalette!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

}

// MARK: - Setup Functions
extension ColorChangeView {
    
    private func commonInit() {
        NSBundle.mainBundle().loadNibNamed("ColorChangeTableViewCell", owner: self, options: nil)
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leftAnchor.constraintEqualToAnchor(leftAnchor).active = true
        contentView.rightAnchor.constraintEqualToAnchor(rightAnchor).active = true
        contentView.bottomAnchor.constraintEqualToAnchor(bottomAnchor).active = true
        contentView.topAnchor.constraintEqualToAnchor(topAnchor).active = true
    }
    
}

// MARK: - Color Palette Functions
extension ColorChangeView {
    
    
    
}