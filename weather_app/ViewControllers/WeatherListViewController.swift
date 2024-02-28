//
//  ViewController.swift
//  weather_app
//
//  Created by Shaxobiddin on 20/02/24.
//

import UIKit

class WeatherListViewController: UIViewController, AddWeatherDelegate {
    
    @IBOutlet var tableView: UITableView!
    private var weatherViewModel = WeatherListViewModel()
    private var dataSource: TableViewDataSource<WeatherTableCell, WeatherDataEntity>!
    private var weatherData: [WeatherDataEntity] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistenContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        dataSource = TableViewDataSource(cellIdentifier: "weatherTableCell", items: weatherData, configureCell: { cell, data in
            cell.setData(data: data)
        })
        fetchFromDatabase()
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
        saveDatabase(data: data)
        fetchFromDatabase()
    }
    
    func saveDatabase(data: WeatherData) {
        let weather = WeatherDataEntity(context: self.context)
        weather.name = data.cityName.value
        weather.temperature = data.currentTemperature?.temperature.value ?? 0
        weather.isCelsius = false
        weatherViewModel.addWeather(data: weather)
        
        do {
            try self.context.save()
        } catch {
            print("Error while saving data in Database")
        }
    }
    
    func fetchFromDatabase() {
        do {
            weatherData = try context.fetch(WeatherDataEntity.fetchRequest())
            dataSource.updateIetms(weatherData)
            tableView.reloadData()
        }catch {
            print("Error while Fetching weathe data from Database")
        }
    }
    
    func deletFromDatabase(data: WeatherDataEntity) {
        context.delete(data)
        do {
            try self.context.save()
        } catch {
            let error = error as NSError
            print("Error while deleting data from database \(error.localizedDescription)")
        }
    }
}

extension WeatherListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [deleteData(at: indexPath)])
    }
    
    func deleteData(at index: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { action, view, completion in
            let data = self.weatherData[index.row]
            self.weatherData.remove(at: index.row)
            self.dataSource.updateIetms(self.weatherData)
            self.tableView.reloadData()
            self.deletFromDatabase(data: data)
            
            completion(true)
            action.backgroundColor = .red
        }
        return action
    }
}

extension WeatherListViewController: SettingsDelegate {
    func settingsDone(vm: SettingsViewModel) {
        weatherViewModel.updateUnit(to: vm.selectedUnit)
        tableView.reloadData()
    }
    
}
