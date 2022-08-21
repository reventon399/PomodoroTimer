//
//  ViewController.swift
//  PomodoroTimer
//
//  Created by Алексей Лосев on 21.08.2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    // MARK: - Outlets
    
    let timeLabel: UILabel = {
       let label = UILabel()
        label.text = "5"
        label.font = UIFont.systemFont(ofSize: 50)
        label.textAlignment = .center
        return label
    }()
    
    let startStopButton: UIButton = {
       let button = UIButton()
        let image = UIImage(systemName: "play")
        button.setImage(image, for: .normal)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
    }
    
    //MARK: - Hierarchy
    
    private func setupHierarchy() {
        view.backgroundColor = .white
        view.addSubview(timeLabel)
        view.addSubview(startStopButton)
    }
    //MARK: - Layout
    
    private func setupLayout() {
        timeLabel.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
        
        startStopButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(timeLabel.snp.bottom).offset(10)
        }
    }
    
    // MARK: - Animation
    
    let shapeLayer = CAShapeLayer()

}

