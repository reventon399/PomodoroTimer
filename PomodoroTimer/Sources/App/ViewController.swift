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
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "play")
        button.setImage(image, for: .normal)
        button.addTarget(Any?.self, action: #selector(startStopButtonPressed), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
        configureCircle()
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
    
    //MARK: - Timer
    
    var timer = Timer()
    var durationTimer = 10
    
    //MARK: - Action
    
    @objc func startStopButtonPressed() {
        basicAnimation()
        
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(timerAction),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @objc func timerAction() {
        
        durationTimer -= 1
        timeLabel.text = "\(durationTimer)"
    }
    
    // MARK: - Animation
    
    let shapeLayer = CAShapeLayer()
    
    private func configureCircle() {
        
        let center = view.center
        let endAngle = CGFloat.pi * 2
        let startAngle = -CGFloat.pi / 2
        
        let circlePath = UIBezierPath(arcCenter: center,
                                      radius: 138,
                                      startAngle: startAngle,
                                      endAngle: endAngle,
                                      clockwise: true)
        
        let trackShape = CAShapeLayer()
        trackShape.path = circlePath.cgPath
        trackShape.fillColor = UIColor.clear.cgColor
        trackShape.lineWidth = 5
        trackShape.strokeColor = UIColor.lightGray.cgColor
        view.layer.addSublayer(trackShape)
        
        shapeLayer.path = circlePath.cgPath
        shapeLayer.lineWidth = 5
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 0
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeColor = UIColor.systemBlue.cgColor
        view.layer.addSublayer(shapeLayer)
    }
    
    private func basicAnimation() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 0
        animation.duration = CFTimeInterval(durationTimer)
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        shapeLayer.add(animation, forKey: "animation")
    }

}

