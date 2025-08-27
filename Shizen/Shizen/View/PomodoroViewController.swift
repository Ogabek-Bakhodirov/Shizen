//
//  PomodoroViewController.swift
//  Shizen
//
//  Created by Ogabek Bakhodirov on 26/08/25.
//
import UIKit

class PomodoroViewController: UIViewController {
    
    private var timer: Timer?
    private var remainingSeconds = 25 * 60  // 25 minutes
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 48, weight: .bold)
        label.textAlignment = .center
        label.text = "25:00"
        return label
    }()
    
    private let stopButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Stop", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 1.0, green: 59/255, blue: 48/255, alpha: 1.0) // #FF3B30
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 12
        button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 40, bottom: 12, right: 40)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupUI()
        startTimer()
        print(UserModel.shared.printAll())
    }
    
    private func setupUI() {
        view.addSubview(timeLabel)
        view.addSubview(stopButton)
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            
            stopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stopButton.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 40)
        ])
        
        stopButton.addTarget(self, action: #selector(stopButtonTapped), for: .touchUpInside)
    }
    
    private func startTimer() {
        updateTimeLabel()
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(updateTimer),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @objc private func updateTimer() {
        if remainingSeconds > 0 {
            remainingSeconds -= 1
            updateTimeLabel()
        } else {
            timer?.invalidate()
            timer = nil
        }
    }
    
    private func updateTimeLabel() {
        let minutes = remainingSeconds / 60
        let seconds = remainingSeconds % 60
        timeLabel.text = String(format: "%02d:%02d", minutes, seconds)
    }
    
    @objc private func stopButtonTapped() {
        let alert = UIAlertController(title: "Stop Timer?",
                                      message: "Are you really want to stop it?",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Stop", style: .destructive, handler: { _ in
            self.timer?.invalidate()
            self.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true)
    }
}


