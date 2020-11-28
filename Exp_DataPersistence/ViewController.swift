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
        
        NotificationCenter.default.addObserver(self, selector: #selector(onUbiquitousKeyValueStoreDidChangeExternally), name: NSUbiquitousKeyValueStore.didChangeExternallyNotification, object: NSUbiquitousKeyValueStore.default)
        
        NSUbiquitousKeyValueStore.default.synchronize()
        
        refreshUI()
    }
    
    @objc func onUbiquitousKeyValueStoreDidChangeExternally(notification: Notification) {
        let changeReason = notification.userInfo![NSUbiquitousKeyValueStoreChangeReasonKey] as! Int
        let changedKeys = notification.userInfo![NSUbiquitousKeyValueStoreChangedKeysKey] as! [String]
        
        
        switch changeReason {
        case NSUbiquitousKeyValueStoreInitialSyncChange, NSUbiquitousKeyValueStoreServerChange, NSUbiquitousKeyValueStoreAccountChange:
            
            refreshUI()
            
        case NSUbiquitousKeyValueStoreQuotaViolationChange:
            // Reduce amount of data store in iCloud Key-Value Store
            print("Your data takes too much space")
            
        default:
            break
        }
        
    }


    @IBAction func saveButtonTapped(_ sender: UIButton) {
        NSUbiquitousKeyValueStore.default.setValue(fullNameTextField.text, forKey: "fullName")
        NSUbiquitousKeyValueStore.default.setValue(emailTextField.text, forKey: "email")
        NSUbiquitousKeyValueStore.default.setValue(phoneTextField.text, forKey: "phone")
        
        let dataSaved = UIAlertController(title: "Data saved! 🙌", message: "Your details has been saved.", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Good", style: .default) { (action) in
            print("Ok, UserDefaults work.")
        }
        
        dataSaved.addAction(okAction)
        
        if fullNameTextField.text != "" || emailTextField.text != "" {
            present(dataSaved, animated: true, completion: nil)
            
            NSUbiquitousKeyValueStore.default.synchronize()
        }
    }
    
    func refreshUI() {
        fullNameTextField.text = NSUbiquitousKeyValueStore.default.string(forKey: "fullName")
        emailTextField.text = NSUbiquitousKeyValueStore.default.string(forKey: "email")
        phoneTextField.text = NSUbiquitousKeyValueStore.default.string(forKey: "phone")
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
        
        NSUbiquitousKeyValueStore.default.removeObject(forKey: "fullName")
        NSUbiquitousKeyValueStore.default.removeObject(forKey: "email")
        NSUbiquitousKeyValueStore.default.removeObject(forKey: "phone")
    }
    
}

