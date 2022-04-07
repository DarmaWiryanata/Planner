//
//  PlanViewModel.swift
//  Planner
//
//  Created by Darma Wiryanata on 06/04/22.
//

import Foundation

class PlanViewModel: ObservableObject {
    
    @Published var items: [Plan] = [] {
        didSet {
            saveItems()
        }
    }
    
    let itemsKey: String = "plans"
    
    init() {
        getItems()
    }
    
    func getItems() {
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([Plan].self, from: data)
        else { return }
        
        self.items = savedItems
    }
    
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
    
    func createItem(title: String, date: Date, time: Date, note: String, isCompleted: Bool) {
        let newItem = Plan(title: title, date: date, time: time, note: note, isCompleted: isCompleted)
        self.items.append(newItem)
    }
    
}
