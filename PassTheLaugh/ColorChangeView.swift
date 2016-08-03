//
//  ColorChangeView.swift
//  PassTheLaugh

import UIKit

protocol ColorChangeViewDelegate {
    func colorChanged(to color: UIColor)
}

final class ColorChangeView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var color1Button: UIButton!
    @IBOutlet weak var color2Button: UIButton!
    @IBOutlet weak var color3Button: UIButton!
    @IBOutlet weak var color4Button: UIButton!
    @IBOutlet weak var color5Button: UIButton!
    var colorDelegate: ColorChangeViewDelegate!
    
    var colorPalette: ColorPalette! {
        didSet { setupColorPalette() }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

}

// MARK: - Action Methods
extension ColorChangeView {
    
    @IBAction func colorChangeWithButton(sender: UIButton) {
        colorDelegate.colorChanged(to: sender.backgroundColor!)
    }
    
}

// MARK: - Setup Functions
extension ColorChangeView {
    
    private func commonInit() {
        NSBundle.mainBundle().loadNibNamed("ColorChangeTableViewCell", owner: self, options: nil)
        addSubview(contentView)
        contentView.backgroundColor = UIColor.clearColor()
        self.backgroundColor = UIColor.clearColor()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leftAnchor.constraintEqualToAnchor(leftAnchor).active = true
        contentView.rightAnchor.constraintEqualToAnchor(rightAnchor).active = true
        contentView.bottomAnchor.constraintEqualToAnchor(bottomAnchor).active = true
        contentView.topAnchor.constraintEqualToAnchor(topAnchor).active = true
        
        setupTheButtons()
    }
    
}

// MARK: Setup Buttons
extension ColorChangeView {
    
    private func setupTheButtons() {
        roundTheEdgesOfAllTheButtons()
    }
    
    private func roundTheEdgesOfAllTheButtons() {
        let allTheButtons = [color1Button, color2Button, color3Button, color4Button, color5Button]
        
        for button in allTheButtons {
            let height = button.frame.size.height
            button.clipsToBounds = true
            button.layer.cornerRadius = height / 2
        }
    }
    
}

// MARK: - Color Palette Functions
extension ColorChangeView {
    
    private func setupColorPalette() {
        color1Button.backgroundColor = colorPalette.first
        color2Button.backgroundColor = colorPalette.second
        color3Button.backgroundColor = colorPalette.third
        color4Button.backgroundColor = colorPalette.fourth
        color5Button.backgroundColor = colorPalette.fifth
    }
}