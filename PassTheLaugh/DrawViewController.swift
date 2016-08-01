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
        drawingView.backgroundColor = Color.DisplayViewColor
    }
    
}

// MARK: - DrawingView Delegate
extension DrawViewController: ACEDrawingViewDelegate {
    
    func drawingView(view: ACEDrawingView!, didEndDrawUsingTool tool: ACEDrawingTool!) {
        toolsView.updateButtonStatus()
    }

}

