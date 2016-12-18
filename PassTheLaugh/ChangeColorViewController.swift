//
//  ChangeColorViewController.swift
//  PassTheLaugh
//
//  Created by Jim Campagno on 8/2/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import UIKit

protocol UpdateColorDelegate {
    
    func updateColor(to color: UIColor)
    
}

final class ChangeColorViewController: UIViewController {
    
    var tableView: UITableView!
    var colorPalettes: [ColorPalette] = ColorPalette.dummyData()
    var updateColorDelegate: UpdateColorDelegate!
    let rowHeight: CGFloat = 106
    var widthOfSideBar: CGFloat!

    
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    
    fileprivate func setupView() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        setupTableView()
    }
    
}

// MARK: - ColorChangeView Delegate Methods
extension ChangeColorViewController: ColorChangeViewDelegate {
    
    func colorChanged(to color: UIColor) {
        updateColorDelegate.updateColor(to: color)
        dismiss(animated: true) { [unowned self] _ in
            self.updateColorDelegate = nil
        }
    }
    
}

// MARK: - Setup TableView
extension ChangeColorViewController {
    
    fileprivate func setupTableView() {
        tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.backgroundColor = UIColor.clear
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        let centerX = tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        centerX.constant -= widthOfSideBar / 2
        centerX.isActive = true
        tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ColorChangeCell.self, forCellReuseIdentifier: ColorChangeCell.identifier)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
    }
    
}

// MARK: - TableView Datasource Methods
extension ChangeColorViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colorPalettes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ColorChangeCell.identifier, for: indexPath) as! ColorChangeCell
        cell.colorChangeView.colorDelegate = self
        cell.backgroundColor = UIColor.clear
        return cell
    }

}


// MARK: - TableView Delegate Methods
extension ChangeColorViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let colorCell = cell as! ColorChangeCell
        print("CALLED!")
        colorCell.colorPalette = colorPalettes[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    
}
