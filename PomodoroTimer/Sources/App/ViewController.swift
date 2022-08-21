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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

