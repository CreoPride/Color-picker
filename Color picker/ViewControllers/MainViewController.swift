//
//  MainViewController.swift
//  Color picker
//
//  Created by Konstantin Fomenkov on 19.03.2022.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    



    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.mainViewColor = view.backgroundColor
    }

    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        let settingsVC = segue.source as? SettingsViewController
        view.backgroundColor = settingsVC?.mainViewColor
    }

}
