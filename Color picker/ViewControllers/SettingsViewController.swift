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
    var delegate: SettingsViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getColor(from: mainViewColor)
        setColor()
        setValuesToLabelAndTF()
    }

    @IBAction func sliderChanged(_ sender: UISlider) {
        setColor()
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
    @IBAction func doneButtonPressed() {
        delegate.setColor(mainViewColor)
        dismiss(animated: true)
    }

    private func getColor(from mainColor: UIColor) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        mainColor.getRed(&red, green: &green, blue: &blue, alpha: nil)
        redSlider.value = Float(red)
        greenSlider.value = Float(green)
        blueSlider.value = Float(blue)
    }

    private func setColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
        mainViewColor = colorView.backgroundColor
    }

    private func setValuesToLabelAndTF() {
        redLabel.text = string(fromSlider: redSlider)
        greenLabel.text = string(fromSlider: greenSlider)
        blueLabel.text = string(fromSlider: blueSlider)

        redTextField.text = string(fromSlider: redSlider)
        greenTextField.text = string(fromSlider: greenSlider)
        blueTextField.text = string(fromSlider: blueSlider)
    }

    private func string(fromSlider slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}

extension SettingsViewController: UITextFieldDelegate {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, let value = Float(text) else { return }
        switch textField.tag {
        case 0:
            redSlider.setValue(value, animated: true)
            redLabel.text = string(fromSlider: redSlider)
        case 1:
            greenSlider.setValue(value, animated: true)
            greenLabel.text = string(fromSlider: greenSlider)
        default:
            blueSlider.setValue(value, animated: true)
            blueLabel.text = string(fromSlider: blueSlider)
        }
        setColor()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
