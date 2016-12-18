//
//  DrawingToolsView.swift
//  PassTheLaugh

import UIKit
import ACEDrawingView

protocol ColorChangeRequestDelegate {
    func requestToChangeColor()
    func requestToChangeAlpha()
    func requestToLookAtInfo()
}

final class DrawingToolsView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var redoButton: UIButton!
    @IBOutlet weak var undoButton: UIButton!
    var colorDelegate: ColorChangeRequestDelegate!
    
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
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        switch sender.drawType {
        case .Redo: drawingView.redoLatestStep()
        case .Undo: drawingView.undoLatestStep()
        case .Alpha: colorDelegate.requestToChangeAlpha()
        case .Thick: print("Thickness tapped.")
        case .Color: colorDelegate.requestToChangeColor()
        case .Info: colorDelegate.requestToLookAtInfo()
        case .Unknown: print("Unknown tapped.")
        }
        
        updateButtonStatus()
    }
    
    func updateButtonStatus() {
        undoButton.isEnabled = drawingView.canUndo()
        redoButton.isEnabled = drawingView.canRedo()
    }
    
}

// MARK: - Setup Functions
extension DrawingToolsView {
    
    fileprivate func commonInit() {
        Bundle.main.loadNibNamed("DrawingToolsView", owner: self, options: nil)
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        // TODO: Remove anything below this done when ready to deploy app
        test()
    }
    
}


// TODO: Remove this Dev Stage Function section when ready to deply app
// MARK: - Development Stage Functions
extension DrawingToolsView {
    
    fileprivate func test() {
        changeBackgroundColorOfContentView()
        changeBackgroundcolorOfAllButtons()
    }
    
    fileprivate func changeBackgroundColorOfContentView() {
        contentView.backgroundColor = Color.ToolViewColor
    }
    
    fileprivate func changeBackgroundcolorOfAllButtons() {
        for view in stackView.subviews {
            switch view {
            case is UIButton:
                let v: UIButton = view as! UIButton
                v.backgroundColor = Color.ToolButtonColor
                v.setTitleColor(Color.ToolButtonTextColor, for: UIControlState())
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
