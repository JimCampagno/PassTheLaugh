//
//  ViewController.swift
//  PassTheLaugh
//
//  Created by Jim Campagno on 7/31/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

// MARK: - Test Out Image Download Methods
extension ViewController {
    
    fileprivate func test() {
        setupImageView()
        displayTestImage()
    }
    
    fileprivate func setupImageView() {
        imageView = UIImageView(frame: CGRect.zero)
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.contentMode = .scaleAspectFit
    }
    
    fileprivate func displayTestImage() {
        FirebaseAPIclient.downloadImageAtURL(Constants.testimage) { [unowned self] image in
            guard let image = image else { return }
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
    
}
