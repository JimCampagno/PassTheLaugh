//
//  DrawViewController.swift
//  PassTheLaugh

import UIKit
import ACEDrawingView
import Firebase

final class DrawViewController: UIViewController {
    
    var gameClient: GameAPIclient! = nil
    
    @IBOutlet weak var toolsView: DrawingToolsView!
    @IBOutlet weak var drawingView: ACEDrawingView!
    
    let main = UIStoryboard(name: "Main", bundle: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        gameClient = GameAPIclient()
        gameClient.createGame()
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
        let changeColorVC = main.instantiateViewControllerWithIdentifier("ChangeColorVC") as! ChangeColorViewController
        changeColorVC.modalPresentationStyle = .OverFullScreen
        changeColorVC.modalTransitionStyle = .CrossDissolve
        changeColorVC.updateColorDelegate = self
        changeColorVC.widthOfSideBar = toolsView.frame.size.width
        presentViewController(changeColorVC, animated: true, completion: nil)
    }
    
    func requestToChangeAlpha() {
        let alphaVC = main.instantiateViewControllerWithIdentifier("AlphaVC") as! AlphaViewController
        alphaVC.modalPresentationStyle = .OverFullScreen
        alphaVC.modalTransitionStyle = .CrossDissolve
        alphaVC.currentColor = drawingView.lineColor
        alphaVC.currentAlphaValue = drawingView.lineAlpha
        alphaVC.widthOfSideBar = toolsView.frame.size.width
        alphaVC.updateAlphaDelegate = self
        presentViewController(alphaVC, animated: true, completion: nil)
    }
    
    func requestToLookAtInfo() {
        // TODO: This just present a view showcasing the name of the image to be drawn. Maybe a timer. Another button in this view to be able to submit the drawing. For now, I'm just having it take a screenshot and sending that up to Firebase.
        
        let drawingImage = drawingView.image
        FirebaseAPIclient.uploadImage(drawingImage) { _ in
            print("HI everyone.")
        }
        
        
        
    }
    
}

// MARK: - UpdateColorDelegate Methods
extension DrawViewController: UpdateColorDelegate {
    
    func updateColor(to color: UIColor) {
        drawingView.lineColor = color
    }
    
}

// MARK: - UpdateAlphaDelegate Methods
extension DrawViewController: UpdateAlphaDelegate {
    
    func updateAlpha(to alpha: CGFloat) {
        drawingView.lineAlpha = alpha
    }
}