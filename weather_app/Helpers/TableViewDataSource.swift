//
//  TableViewDataSource.swift
//  weather_app
//
//  Created by Shaxobiddin on 21/02/24.
//

import UIKit

class TableViewDataSource<CellType, Data>: NSObject, UITableViewDataSource where CellType: UITableViewCell {
    
    let cellIdentifier: String
    var items: [Data]
    let configureCell: (CellType, Data) -> ()
    
    init(cellIdentifier: String, items: [Data], configureCell: @escaping (CellType, Data) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items = items
        self.configureCell = configureCell
    }
    
    func updateIetms(_ items: [Data]) {
        self.items = items
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CellType else {
            fatalError("Cell not found")
        }
        
        let data = items[indexPath.row]
        configureCell(cell, data)
        return cell
    }
}
