//
//  PlannerView.swift
//  Planner
//
//  Created by Darma Wiryanata on 06/04/22.
//

import SwiftUI

struct PlannerView: View {
    
    @EnvironmentObject var planViewModel: PlanViewModel
    @State private var showSheet: Bool = false
    @State private var plan: Plan?
    @State private var deleteAction = false

    var body: some View {
        NavigationView {
            ZStack {
                if planViewModel.plans.isEmpty {
                    Text("No items available")
                } else {
                    List {
                        ForEach(planViewModel.plans) { item in
                            PlanListView(plan: item)
                                .onTapGesture {
                                    plan = item
                                }
                        }
                        .onDelete(perform: planViewModel.deletePlan)
                        .onMove(perform: planViewModel.movePlan)
                    }
                    .refreshable {
                        self.planViewModel.getItems()
                    }
                }
            }
            
            .navigationTitle("All Plans")
            .navigationBarItems(
                leading: EditButton(),
                trailing:
                    Button("Add") {
                        createPlan()
                    }
            )
            .sheet(item: $plan) { item in
                DetailSheet(id: item.id, title: item.title, date: item.date ?? Date(), note: item.note ?? "", isCompleted: item.isCompleted)
            }
        }
    }
    
    func createPlan() {
        plan = planViewModel.createPlan(title: "New plan")
        showSheet.toggle()
    }
    
    func deletePlan() {
        
    }
    
}

struct PlannerView_Previews: PreviewProvider {
    static var previews: some View {
        PlannerView()
            .environmentObject(PlanViewModel())
    }
}
