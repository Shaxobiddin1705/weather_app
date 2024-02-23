//
//  SettingsViewController.swift
//  weather_app
//
//  Created by Shaxobiddin on 20/02/24.
//

import UIKit

protocol SettingsDelegate {
    func settingsDone(vm: SettingsViewModel)
}

class SettingsViewController: UIViewController {
    
    private var _settingsViewModel = SettingsViewModel()
    var delegate: SettingsDelegate?
    @IBOutlet weak var settingsTB: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingsTB.delegate = self
        self.settingsTB.dataSource = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let delegate = delegate {
            delegate.settingsDone(vm: _settingsViewModel)
        }
    }

}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _settingsViewModel.units.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath)
        let unit = _settingsViewModel.units[indexPath.row]
        cell.textLabel?.text = unit.displayName
        
        if unit == _settingsViewModel.selectedUnit {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _settingsViewModel.selectedUnit = _settingsViewModel.units[indexPath.row]
        settingsTB.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.dismiss(animated: true)
            }
    }
    
}
