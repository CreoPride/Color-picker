    //
    //  SettingsViewController.swift
    //  Color picker
    //
    //  Created by Konstantin Fomenkov on 05.03.2022.
    //

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var colorView: UIView!

    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!

    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!

    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!

    var mainViewColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getColor(from: mainViewColor)
        setColorToView()

        redLabel.text = string(fromSlider: redSlider)
        greenLabel.text = string(fromSlider: greenSlider)
        blueLabel.text = string(fromSlider: blueSlider)

        redTextField.text = string(fromSlider: redSlider)
        greenTextField.text = string(fromSlider: greenSlider)
        blueTextField.text = string(fromSlider: blueSlider)
    }

    @IBAction func sliderChanged(_ sender: UISlider) {
        setColorToView()
        switch sender.tag {
        case 0:
            redLabel.text = string(fromSlider: sender)
            redTextField.text = string(fromSlider: sender)
        case 1:
            greenLabel.text = string(fromSlider: sender)
            greenTextField.text = string(fromSlider: sender)
        default:
            blueLabel.text = string(fromSlider: sender)
            blueTextField.text = string(fromSlider: sender)
        }
    }

    private func getColor(from mainColor: UIColor) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        guard mainColor.getRed(&red, green: &green, blue: &blue, alpha: nil) else { return }
        redSlider.value = Float(red)
        greenSlider.value = Float(green)
        blueSlider.value = Float(blue)
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

