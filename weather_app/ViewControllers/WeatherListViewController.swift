//
//  ViewController.swift
//  weather_app
//
//  Created by Shaxobiddin on 20/02/24.
//

import UIKit

class WeatherListViewController: UIViewController, AddWeatherDelegate, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    private var weatherViewModel = WeatherListViewModel()
    private var dataSource: TableViewDataSource<WeatherTableCell, WeatherData>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        dataSource = TableViewDataSource(cellIdentifier: "weatherTableCell", items: weatherViewModel.weatherData, configureCell: { cell, data in
            cell.setData(data: data)
        })
        tableView.dataSource = dataSource
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddWeatherViewController" {
            guard let nav = segue.destination as? UINavigationController else { return }
            
            guard let addWeatherVC = nav.viewControllers.first as? AddWeatherViewController else { return }
            
            addWeatherVC.delegate = self
        } else if segue.identifier == "SettingsViewController" {
            guard let nav = segue.destination as? UINavigationController else { return }
            
            guard let addWeatherVC = nav.viewControllers.first as? SettingsViewController else { return }
            
            addWeatherVC.delegate = self
        }
    }
    
    func sendWeatherData(data: WeatherData) {
        weatherViewModel.addWeather(data: data)
        dataSource.updateIetms(weatherViewModel.weatherData)
        tableView.reloadData()
    }
}

extension WeatherListViewController: SettingsDelegate {
    func settingsDone(vm: SettingsViewModel) {
        weatherViewModel.updateUnit(to: vm.selectedUnit)
        tableView.reloadData()
    }
    
}
