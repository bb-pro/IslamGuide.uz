//
//  ChooseLanguageViewController.swift
//  Islam Guide
//
//  Created by Bektemur Mamashayev on 26/05/23.
//

import UIKit



final class ChooseLanguageViewController: UIViewController, UIPickerViewDelegate {

    @IBOutlet var pickerView: UIPickerView!
    private let languageOptions = LanguageOptions.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    
    @IBAction func cancelAction() {
        dismiss(animated: true)
    }
    @IBAction func saveButtonPressed() {
        let index = pickerView.selectedRow(inComponent: 0)
        setPreferredLanguage(index)
        showAlert(title: "Alert".localize(), message: "The language of the app is changed to see the updated version please reopen the app".localize())
    }
    private func setPreferredLanguage(_ index: Int) {
        var languageCode = ""
        switch index {
            case 0:
                languageCode = "en"
            case 1:
                languageCode = "uz-Cyrl"
            default:
                languageCode = "ru"
        }
        UserDefaults.standard.set([languageCode], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
}

//MARK: - UIPickerViewDataSource
extension ChooseLanguageViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        languageOptions.languages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languageOptions.languages[row] // The title for the specified row
    }
}
