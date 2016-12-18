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
    
    @IBAction func colorChangeWithButton(_ sender: UIButton) {
        colorDelegate.colorChanged(to: sender.backgroundColor!)
    }
    
}

// MARK: - Setup Functions
extension ColorChangeView {
    
    fileprivate func commonInit() {
        Bundle.main.loadNibNamed("ColorChangeTableViewCell", owner: self, options: nil)
        addSubview(contentView)
        contentView.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.clear
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        setupTheButtons()
    }
    
}

// MARK: Setup Buttons
extension ColorChangeView {
    
    fileprivate func setupTheButtons() {
        roundTheEdgesOfAllTheButtons()
    }
    
    fileprivate func roundTheEdgesOfAllTheButtons() {
        let allTheButtons = [color1Button, color2Button, color3Button, color4Button, color5Button]
        
        for button in allTheButtons {
            let height = button?.frame.size.height
            button?.clipsToBounds = true
            button?.layer.cornerRadius = height! / 2
        }
    }
    
}

// MARK: - Color Palette Functions
extension ColorChangeView {
    
    fileprivate func setupColorPalette() {
        color1Button.backgroundColor = colorPalette.first
        color2Button.backgroundColor = colorPalette.second
        color3Button.backgroundColor = colorPalette.third
        color4Button.backgroundColor = colorPalette.fourth
        color5Button.backgroundColor = colorPalette.fifth
    }
}
