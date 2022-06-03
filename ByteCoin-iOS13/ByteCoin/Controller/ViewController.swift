//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, CoinManagerDelegate {
    
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var bitcoinLabel: UILabel!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
        //Pega o preço para o primeiro item da Array
        coinManager.getCoinPrice(for: "AUD")
    }
    //Numero de colunas
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // numero de itens no pickerview
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    //delegate methods - Titulo para cada linha
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    // A linha selecionada
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let chosenCoin = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: chosenCoin)
    }
    
    
    //MARK: - COIN MANAGER DELEGATE
    func didUpdateCoin(_ coinManager: CoinManager, _ coin: CoinModel) {
        DispatchQueue.main.async {
            self.currencyLabel.text = coin.currency
            self.bitcoinLabel.text = coin.priceString
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }

}

