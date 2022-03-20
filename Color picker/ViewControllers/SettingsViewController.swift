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

        addDoneButton(for: redTextField)
        addDoneButton(for: greenTextField)
        addDoneButton(for: blueTextField)
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
        view.endEditing(true)
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
//MARK: Textfield methods
extension SettingsViewController: UITextFieldDelegate {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, var value = Float(text) else {
            alert(
                title: "Sorry, you have not entered a number",
                message: "Please, enter a number"
            )
            return }
        if !(0...1).contains(value) {
            textField.text = "0.0"
            value = 0.0
            alert(
                title: "Sorry, wrong number",
                message: "Please, enter a number from 0 to 1. Set number to 0"
            )
        }
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

//MARK: Done button
extension SettingsViewController {

    private func addDoneButton(for textField: UITextField) {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneButtonAction)
        )
        let flexSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        toolbar.items = [flexSpace, doneButton]
        textField.inputAccessoryView = toolbar
    }

    @objc private func doneButtonAction() {
        view.endEditing(true)
    }
}

//MARK: Alert
extension SettingsViewController {

    private func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
