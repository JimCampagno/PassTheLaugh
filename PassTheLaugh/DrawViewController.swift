//
//  DrawViewController.swift
//  PassTheLaugh

import UIKit
import ACEDrawingView

final class DrawViewController: UIViewController {
    
    @IBOutlet weak var toolsView: DrawingToolsView!
    @IBOutlet weak var drawingView: ACEDrawingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawingView.delegate = self
        toolsView.drawingView = drawingView
        toolsView.colorDelegate = self
        drawingView.backgroundColor = Color.DisplayViewColor
    }
    
}

// MARK: - DrawingView Delegate
extension DrawViewController: ACEDrawingViewDelegate {
    
    func drawingView(view: ACEDrawingView!, didEndDrawUsingTool tool: ACEDrawingTool!) {
        toolsView.updateButtonStatus()
    }

}

// MARK: - ColorChangeRequest Delegate Methods
extension DrawViewController: ColorChangeRequestDelegate {
    
    func requestToChangeColor() {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let changeColorVC = main.instantiateViewControllerWithIdentifier("ChangeColorVC") as! ChangeColorViewController
        changeColorVC.modalPresentationStyle = .OverFullScreen
        changeColorVC.modalTransitionStyle = .CrossDissolve
        changeColorVC.updateColorDelegate = self
        presentViewController(changeColorVC, animated: true, completion: nil)
    }
    
}

// MARK: - UpdateColorDelegate Methods
extension DrawViewController: UpdateColorDelegate {
    
    func updateColor(to color: UIColor) {
        drawingView.lineColor = color
    }
    
}