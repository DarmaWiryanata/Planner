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
//        let newItems = [
//            ItemModel(title: "This is the first title!", isCompleted: false),
//            ItemModel(title: "This is the second!", isCompleted: true),
//            ItemModel(title: "Third!", isCompleted: false)
//        ]
//        items.append(contentsOf: newItems)
        
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([Plan].self, from: data)
        else { return }
        
        self.plans = savedItems
    }
    
    func deletePlan(indexSet: IndexSet) {
        plans.remove(atOffsets: indexSet)
        saveItems()
    }
    
    func movePlan(from: IndexSet, to: Int) {
        plans.move(fromOffsets: from, toOffset: to)
    }
    
    func createPlan(title: String) -> Plan {
        let newPlan = Plan(title: title, isCompleted: false)
        plans.append(newPlan)
        
        return newPlan
    }
    
    func updatePlan(plan: Plan) {
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
