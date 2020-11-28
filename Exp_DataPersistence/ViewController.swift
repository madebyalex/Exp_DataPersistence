//
//  ViewController.swift
//  Exp_DataPersistence
//
//  Created by Alexander on 28.11.2020.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fullNameTextField.text = UserDefaults.standard.string(forKey: "fullName")
        emailTextField.text = UserDefaults.standard.string(forKey: "email")
        phoneTextField.text = UserDefaults.standard.string(forKey: "phone")
    }
    
    

    @IBAction func saveButtonTapped(_ sender: UIButton) {
        UserDefaults.standard.setValue(fullNameTextField.text, forKey: "fullName")
        UserDefaults.standard.setValue(emailTextField.text, forKey: "email")
        UserDefaults.standard.setValue(phoneTextField.text, forKey: "phone")
    }
    
    @IBAction func clearDataButtonTapped(_ sender: UIBarButtonItem) {
        clearData()
    }
    
    func clearData() {
        fullNameTextField.text = ""
        emailTextField.text = ""
        phoneTextField.text = ""
        
        UserDefaults.standard.removeObject(forKey: "fullName")
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "phone")
    }
    
}

