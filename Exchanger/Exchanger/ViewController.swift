//
//  ViewController.swift
//  Exchanger
//
//  Created by Александр on 21.05.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var firstCurrencyLabel: UILabel!
    @IBOutlet weak var secondCurrencyLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var firstCurrencyPicker: UIPickerView!
    @IBOutlet weak var pickerView: UIView!
    @IBOutlet weak var darkSwitcher: UISwitch!
    @IBOutlet weak var firstValueLabel: UILabel!
    @IBOutlet weak var equalLabel: UILabel!
    @IBOutlet weak var titleImage: UIImageView!
    
    var dataManager = DataManager()
    var  firstCurrency = "AUD"
    var secondCurrency = "AUD"
    var isToggleOn = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataManager.delegate = self
        firstCurrencyPicker.delegate = self
        firstCurrencyPicker.dataSource = self
        firstCurrencyLabel.text = dataManager.currencyArray.first
        secondCurrencyLabel.text = dataManager.currencyArray.first
        resultLabel.text = "1"
        darkSwitcher.addTarget(self, action: #selector(darkModeSwitcher(_:)), for: .touchUpInside)
        darkSwitcher.onTintColor = .black
    }
    
}


extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        dataManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        dataManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == 0 {
            firstCurrency = dataManager.currencyArray[row]
        } else {
            secondCurrency = dataManager.currencyArray[row]
        }

        dataManager.getCoinPrice(for: firstCurrency, in: secondCurrency)

    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        pickerView.layer.bounds.width / 2
    }
    
    @objc func darkModeSwitcher(_ toggle: UISwitch) {
       
        if isToggleOn {
        view.backgroundColor = #colorLiteral(red: 0.1404870152, green: 0.1208023354, blue: 0.1255404055, alpha: 1)
        firstCurrencyLabel.textColor = .white
        secondCurrencyLabel.textColor = .white
        resultLabel.textColor = .white
        equalLabel.textColor = .white
        firstValueLabel.textColor = .white
        firstCurrencyPicker.setValue(UIColor.white, forKey: "textColor")
        titleImage.image = UIImage(named: "ExchangerDark")
        isToggleOn = false
        } else {
            view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            firstCurrencyLabel.textColor = .black
            secondCurrencyLabel.textColor = .black
            resultLabel.textColor = .black
            equalLabel.textColor = .black
            firstValueLabel.textColor = .black
            firstCurrencyPicker.setValue(UIColor.black, forKey: "textColor")
            titleImage.image = UIImage(named: "Exchanger")
            isToggleOn = true
        }
    }
}


extension ViewController: CoinManagerDelegate {
    
    func didUpdateData(data: Double, firstCurrency: String, secondCurrency: String) {
        DispatchQueue.main.async {
            self.resultLabel.text = String(format: "%.2f", data)
            self.firstCurrencyLabel.text = firstCurrency
            self.secondCurrencyLabel.text = secondCurrency
        }
    }
}

