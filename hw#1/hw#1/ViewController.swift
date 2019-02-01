//
//  ViewController.swift
//  hw#1
//
//  Created by Myron on 1/19/19.
//  Copyright © 2019 Myron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billFeild: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBAction func BackgroungTap(_ sender: Any) {
        view.endEditing(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func CalculationT(_ sender: Any) {
        //Get Bill total
        let bill = Double(billFeild.text!) ?? 0
        // Calculate tip
        let tipPercents = [0.1, 0.18, 0.2]
        let tip = bill * tipPercents[tipControl.selectedSegmentIndex]
        //Calculate total
        let total = bill+tip
        totalLabel.text = String(format: "$%.2f", total)
        tipLabel.text = String(format: "$%.2f", tip)
    }
    
}

