//
//  ViewController.swift
//  Bullseye
//
//  Created by Kurt Christopher on 9/21/23.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue: Int = 0
    var targetValue: Int = 0
    var score = 0
    var round = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let roundedValue = slider.value.rounded()
        currentValue = Int(roundedValue)
        startNewGame()
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = UIImage(named: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage?.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = UIImage(named: "SliderTrackRight")
        let trackRightResizable = trackRightImage?.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackRightResizable, for: .normal)
//deal with for: norm and highlighted
    }
    
    @IBAction func showAlert() {
        
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        
        score += points
        
        let title: String
        if difference == 0 {
            title = "Perfect!"
            points += 100
        } else if difference < 5 {
            title = "You almost had it!"
            if difference == 1 {
                points += 50
            }
        } else if difference < 10 {
            title = "Pretty not close."
        } else {
            title = "Super not close..."
        }
        
        let message = "You scored \(points) points"
        
        let alert = UIAlertController(title: title, message: message,
                                      preferredStyle: .alert)
        
        let action = UIAlertAction(title: "hmm", style: .default, handler: {
            action in
            self.startNewRound()
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        
        let roundedValue = slider.value.rounded()
        currentValue = Int(roundedValue)
    }
    func startNewRound() {
        round += 1
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabels()
    }
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    @IBAction func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }
}





