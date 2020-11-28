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
        
        let dataSaved = UIAlertController(title: "Data saved! 🙌", message: "Your details has been saved.", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Good", style: .default) { (action) in
            print("Ok, UserDefaults work.")
        }
        
        dataSaved.addAction(okAction)
        
        if fullNameTextField.text != "" || emailTextField.text != "" {
            present(dataSaved, animated: true, completion: nil)
        }
    }
    
    @IBAction func clearDataButtonTapped(_ sender: UIBarButtonItem) {
        
        let dataClear = UIAlertController(title: "Wanna clear your details? 🧐", message: "This will permanently erase your data.", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes, clear details", style: .destructive) { (action) in
            self.clearData()
        }
        
        let noAction = UIAlertAction(title: "No", style: .cancel) { (action) in
            print("Clearing the data was so close. Phew! 😅")
        }
        
        dataClear.addAction(yesAction)
        dataClear.addAction(noAction)
        present(dataClear, animated: true, completion: nil)
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

