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
    }

    @IBAction func redSliderChanged() {
        setColorToView()
        setValue(toLabel: redLabel, fromSlider: redSlider)
    }
    @IBAction func greenSliderChanged() {
        setColorToView()
        setValue(toLabel: greenLabel, fromSlider: greenSlider)
    }
    @IBAction func blueSliderChanged() {
        setColorToView()
        setValue(toLabel: blueLabel, fromSlider: blueSlider)
    }

    private func setColorToView() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    private func setValue(toLabel label: UILabel, fromSlider slider: UISlider) {
        label.text = String(format: "%.2f", slider.value)
    }
}

