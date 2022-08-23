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
        label.text = "10"
        label.font = UIFont.systemFont(ofSize: 70)
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
    
    var isWorkTime = false
    var isStarted = true
    var restTime = false
    
    @objc func startStopButtonPressed() {
        if isStarted {
            if isWorkTime {
                timer = Timer.scheduledTimer(timeInterval: 0.001,
                                             target: self,
                                             selector: #selector(timerAction),
                                             userInfo: nil,
                                             repeats: true)
                
                startStopButton.setImage(UIImage(systemName: "pause"), for: .normal)
                resumeAnimation()
                isWorkTime = false
            } else {
                basicAnimation()
                timer = Timer.scheduledTimer(timeInterval: 0.001,
                                             target: self,
                                             selector: #selector(timerAction),
                                             userInfo: nil,
                                             repeats: true)
                
                startStopButton.setImage(UIImage(systemName: "pause"), for: .normal)
            }
            
            isStarted = false
        } else {
            startStopButton.setImage(UIImage(systemName: "play"), for: .normal)
            timer.invalidate()
            pauseAnimation()
            
            isWorkTime = true
            isStarted = true
        }
    }
    
    @objc func timerAction() {
        if durationTimer <= 0, !isWorkTime {
            shapeLayer.strokeColor = UIColor.systemGreen.cgColor
            startStopButton.setImage(UIImage(systemName: "pause"), for: .normal)
            startStopButton.tintColor = .systemGreen
            timeLabel.tintColor = .systemGreen
            durationTimer = 5
            isWorkTime = true
            isStarted = false
            timeLabel.text = "\(durationTimer)"
            basicAnimation()
        } else if durationTimer <= 0, isWorkTime {
            isWorkTime = false
            durationTimer = 10
            timeLabel.tintColor = .systemBlue
            startStopButton.tintColor = .systemBlue
            isStarted = false
            startStopButton.setImage(UIImage(systemName: "pause"), for: .normal)
            
//            timer.invalidate()
            shapeLayer.strokeColor = UIColor.systemBlue.cgColor
            
            
            
            
            
            timeLabel.text = "\(durationTimer)"
            basicAnimation()
            
        } else {
            durationTimer -= 1
            timeLabel.text = "\(durationTimer)"
        }

//        if durationTimer <= 0 && isWorkTime {
//                    isWorkTime = false
////                    timeCounter = vacationTimeInSeconds
//                    timeLabel.textColor = .systemRed
//                    startStopButton.tintColor = .systemRed
//                    timer.invalidate()
//                    isStarted = false
//                    startStopButton.setImage(UIImage(systemName: "play"), for: .normal)
//                    timeLabel.text = "\(durationTimer)"
//                } else if durationTimer <= 0 && !isWorkTime {
//                    isWorkTime = true
////                    timeCounter = workTimeInSeconds
//                    shapeLayer.strokeColor = UIColor.systemGreen.cgColor
//                    timeLabel.textColor = .systemGreen
//                    startStopButton.tintColor = .systemGreen
//                    timer.invalidate()
//                    durationTimer = 5
//                    timeLabel.text = "\(durationTimer)"
//                    isStarted = false
//                    startStopButton.setImage(UIImage(systemName: "pause"), for: .normal)
//                } else {
//                    durationTimer -= 1
//                    timeLabel.text = "\(durationTimer)"
//                }
    }
    
    // MARK: - Animation
    
    private func pauseAnimation() {
        let pauseTimer = shapeLayer.convertTime(CACurrentMediaTime(), from: nil)
        shapeLayer.speed = 0
        shapeLayer.timeOffset = pauseTimer
    }
    
    private func resumeAnimation() {
        let pauseTimer = shapeLayer.timeOffset
        shapeLayer.speed = 1
        shapeLayer.timeOffset = 0
        shapeLayer.beginTime = 0
        let timeSincePause = shapeLayer.convertTime(CACurrentMediaTime(), from: nil) - pauseTimer
        shapeLayer.beginTime = timeSincePause
    }
    
    let shapeLayer = CAShapeLayer()
    
    private func configureCircle() {
        
        let trackLayer = CAShapeLayer()
        
        let center = view.center
        let startAngle = -CGFloat.pi / 2
        let endAngle = 2 * CGFloat.pi
        
        let circularPath = UIBezierPath(arcCenter: center,
                                        radius: 150,
                                        startAngle: startAngle,
                                        endAngle: endAngle,
                                        clockwise: true)
        
        trackLayer.path = circularPath.cgPath
        trackLayer.lineCap = CAShapeLayerLineCap.round
        trackLayer.lineWidth = 5
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        view.layer.addSublayer(trackLayer)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.lineWidth = 5
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.systemBlue.cgColor
        shapeLayer.strokeEnd = 0
        view.layer.addSublayer(shapeLayer)
        
    }
    
    private func basicAnimation() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.speed = 0.80
        animation.duration = CFTimeInterval(durationTimer)
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        shapeLayer.add(animation, forKey: "animation")
    }

}


