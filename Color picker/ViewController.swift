    //
    //  ViewController.swift
    //  Color picker
    //
    //  Created by Konstantin Fomenkov on 05.03.2022.
    //

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var colorView: UIView!

    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!

    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setColorToView()
        redLabel.text = string(fromSlider: redSlider)
        greenLabel.text = string(fromSlider: greenSlider)
        blueLabel.text = string(fromSlider: blueSlider)
    }

    @IBAction func sliderChanged(_ sender: UISlider) {
        setColorToView()
        switch sender.tag {
        case 0:
            redLabel.text = string(fromSlider: sender)
        case 1:
            greenLabel.text = string(fromSlider: sender)
        default:
            blueLabel.text = string(fromSlider: sender)
        }
    }

    private func setColorToView() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    private func string(fromSlider slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}

