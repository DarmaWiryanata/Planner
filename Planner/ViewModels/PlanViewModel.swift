//
//  PlanViewModel.swift
//  Planner
//
//  Created by Darma Wiryanata on 06/04/22.
//

import Foundation

class PlanViewModel: ObservableObject {
    
    @Published var plans: [Plan] = [] {
        didSet {
            saveItems()
        }
    }
        
    let itemsKey: String = "items_list"
    
    init() {
        getItems()
    }
    
    func getItems() {
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            var savedItems = try? JSONDecoder().decode([Plan].self, from: data)
        else { return }
        
        
        savedItems = savedItems.sorted(by: {
            $0.date?.compare($1.date ?? Date().addingTimeInterval(60 * 60 * 24 * 30 * 12 * 100)) == .orderedAscending
        })
        self.plans = savedItems
        
        print(savedItems)
    }
    
    func deletePlan(indexSet: IndexSet) {
        plans.remove(atOffsets: indexSet)
        saveItems()
    }
    
    func deletePlanById(id: String) {
        if let index = plans.firstIndex(where: { $0.id == id }) {
            plans.remove(at: index)
        }
        saveItems()
    }
    
    func movePlan(from: IndexSet, to: Int) {
        plans.move(fromOffsets: from, toOffset: to)
    }
    
    func createPlan(title: String) -> Plan {
        let newPlan = Plan(title: title, note: "", isCompleted: false)
        plans.append(newPlan)
        
        return newPlan
    }
    
    func updatePlan(id: String, title: String, date: Date, note: String, isCompleted: Bool) {
        if let index = plans.firstIndex(where: { $0.id == id }) {
            plans[index] = Plan(title: title, date: date, note: note, isCompleted: isCompleted)
        }
    }
    
    func updateIsCompleted(plan: Plan) {
//        if let index = items.firstIndex { (existingItem) -> Bool in
//            return existingItem.id == item.id
//        } {
//
//        }

        if let index = plans.firstIndex(where: { $0.id == plan.id }) {
            plans[index] = plan.updateCompletion()
        }
    }
    
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(plans) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
    
}
