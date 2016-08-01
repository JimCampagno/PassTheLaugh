//
//  DrawingToolsView.swift
//  PassTheLaugh

import UIKit

final class DrawingToolsView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
}

// MARK: - Button Tapped Functions
extension DrawingToolsView {
    
    @IBAction func buttonTapped(sender: UIButton) {
        switch sender.drawType {
        case .Info: print("Info tapped.")
        case .Undo: print("Undo tapped.")
        case .Alpha: print("Alpha Tapped.")
        case .Thick: print("Thickness tapped.")
        case .Color: print("Color tapped.")
        case .Ready: print("Ready tapped.")
        case .Unknown: print("Unknown tapped.")
        }
    }
    
}

// MARK: - Setup Functions
extension DrawingToolsView {
    
    private func commonInit() {
        NSBundle.mainBundle().loadNibNamed("DrawingToolsView", owner: self, options: nil)
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leftAnchor.constraintEqualToAnchor(leftAnchor).active = true
        contentView.rightAnchor.constraintEqualToAnchor(rightAnchor).active = true
        contentView.topAnchor.constraintEqualToAnchor(topAnchor).active = true
        contentView.bottomAnchor.constraintEqualToAnchor(bottomAnchor).active = true
        
        // TODO: Remove anything below this done when ready to deploy app
        test()
    }
    
}

// TODO: Remove this Dev Stage Function section when ready to deply app
// MARK: - Development Stage Functions
extension DrawingToolsView {
    
    private func test() {
        changeBackgroundColorOfContentView()
        changeBackgroundcolorOfAllButtons()
    }
    
    private func changeBackgroundColorOfContentView() {
        contentView.backgroundColor = UIColor.grayColor()
    }
    
    private func changeBackgroundcolorOfAllButtons() {
        for view in stackView.subviews {
            print("We have a view.")
            switch view {
            case is UIButton: print("It's a BUTTON!"); view.backgroundColor = UIColor.greenColor()
            default: continue
            }
        }
    }

}

// MARK: - Adding a DrawType to UIButton
extension UIButton {
    
    enum DrawType: String {
        case Info, Undo, Alpha, Thick, Color, Ready, Unknown
    }
    
    var drawType: DrawType {
        let titleLabelText = accessibilityIdentifier ?? "Unknown"
        let type = DrawType(rawValue: titleLabelText) ?? DrawType.Unknown
        return type
    }
    
}