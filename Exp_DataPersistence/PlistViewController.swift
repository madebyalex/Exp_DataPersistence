//
//  PlistViewController.swift
//  Exp_DataPersistence
//
//  Created by Alexander on 28.11.2020.
//

import UIKit

struct Settings: Codable {
    var currentAppTheme: String
    let lightTheme: Theme
    let darkTheme: Theme
}

struct Theme: Codable {
    let textRGB: [CGFloat]
    let backgroundRGB: [CGFloat]
}

class PlistViewController: UIViewController {

    @IBOutlet weak var themeControl: UISegmentedControl!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var subheadlineLabel: UILabel!
    
    var settings: Settings?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let bundledSettingsURL = Bundle.main.url(forResource: "settings", withExtension: "plist")!
        
        let settingsURL = try! FileManager
            .default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("settings.plist")
        
        if FileManager.default.fileExists(atPath: settingsURL.path) == false {
            try! FileManager.default.copyItem(at: bundledSettingsURL, to: settingsURL)
        }
        
        let data = try! Data(contentsOf: settingsURL)
        
        let decoder = PropertyListDecoder()
        self.settings = try! decoder.decode(Settings.self, from: data)
        
        setTheme()
    }

    func saveSettings() {
        let settingsURL = try! FileManager
            .default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        
        let encoder = PropertyListEncoder()
        let encodedSettings = try! encoder.encode(self.settings)
        
        try! encodedSettings.write(to: settingsURL)
    }
    
    @IBAction func themeControlValueChanged(_ sender: UISegmentedControl) {
        self.settings?.currentAppTheme = self.themeControl.selectedSegmentIndex == 0 ? "Light" : "Dark"
        
        setTheme()
    }
    
    
    func setTheme() {
        guard let settings = self.settings else { return }
        
        if settings.currentAppTheme == "Light" {
            self.themeControl.selectedSegmentIndex = 0
            self.view.backgroundColor = UIColor.colorWithRedValue(redValue: settings.lightTheme.backgroundRGB[0], greenValue: settings.lightTheme.backgroundRGB[1], blueValue: settings.lightTheme.backgroundRGB[2], alpha: 1.0)
            
            let textColor = UIColor.colorWithRedValue(redValue: settings.lightTheme.textRGB[0], greenValue: settings.lightTheme.textRGB[1], blueValue: settings.lightTheme.textRGB[2], alpha: 1.0)
            
            headlineLabel.textColor = textColor
            
        } else {
            self.themeControl.selectedSegmentIndex = 1
            self.view.backgroundColor = UIColor.colorWithRedValue(redValue: settings.darkTheme.backgroundRGB[0], greenValue: settings.darkTheme.backgroundRGB[1], blueValue: settings.darkTheme.backgroundRGB[2], alpha: 1.0)
            
            let textColor = UIColor.colorWithRedValue(redValue: settings.darkTheme.textRGB[0], greenValue: settings.darkTheme.textRGB[1], blueValue: settings.darkTheme.textRGB[2], alpha: 1.0)
            
            headlineLabel.textColor = textColor
        }
    }
}

extension UIColor {
    static func colorWithRedValue(redValue: CGFloat, greenValue: CGFloat, blueValue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: redValue/255.0, green: greenValue/255.0, blue: blueValue/255.0, alpha: alpha)
    }
}
