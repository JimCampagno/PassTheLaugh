//
//  DrawingToolsView.swift
//  PassTheLaugh

import UIKit
import ACEDrawingView

final class DrawingToolsView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var redoButton: UIButton!
    @IBOutlet weak var undoButton: UIButton!
    
    weak var drawingView: ACEDrawingView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
}

// MARK: - Action Functions
extension DrawingToolsView {
    
    @IBAction func buttonTapped(sender: UIButton) {
        switch sender.drawType {
        case .Redo: drawingView.redoLatestStep()
        case .Undo: drawingView.undoLatestStep()
        case .Alpha: print("Alpha Tapped.")
        case .Thick: print("Thickness tapped.")
        case .Color: print("Color tapped.")
        case .Info: print("Info tapped.")
        case .Unknown: print("Unknown tapped.")
        }
        
        updateButtonStatus()
    }
    
    func updateButtonStatus() {
        undoButton.enabled = drawingView.canUndo()
        redoButton.enabled = drawingView.canRedo()
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
        contentView.backgroundColor = Color.ToolViewColor
    }
    
    private func changeBackgroundcolorOfAllButtons() {
        for view in stackView.subviews {
            switch view {
            case is UIButton:
                let v: UIButton = view as! UIButton
                v.backgroundColor = Color.ToolButtonColor
                v.setTitleColor(Color.ToolButtonTextColor, forState: .Normal)
            default: continue
            }
        }
    }

}

// MARK: - Adding a DrawType to UIButton
extension UIButton {
    
    enum DrawType: String {
        case Redo, Undo, Alpha, Thick, Color, Info, Unknown
    }
    
    var drawType: DrawType {
        let titleLabelText = accessibilityIdentifier ?? "Unknown"
        let type = DrawType(rawValue: titleLabelText) ?? DrawType.Unknown
        return type
    }
    
}