//
//  PlannerView.swift
//  Planner
//
//  Created by Darma Wiryanata on 06/04/22.
//

import SwiftUI

struct PlannerView: View {
    
    @EnvironmentObject var planViewModel: PlanViewModel
    @State var showSheet: Bool = false
    @State var plan: Plan?
    
    var body: some View {
        NavigationView {
            ZStack {
                if planViewModel.plans.isEmpty {
                    Text("No items available")
                } else {
                    List(planViewModel.plans) { item in
                        PlanListView(plan: item)
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
            .sheet(isPresented: $showSheet) {
                DetailSheet(plan: plan ?? Plan(id: "1", title: "Abc", date: Date(), note: "", isCompleted: false))
            }
        }
    }
    
    func createPlan() {
        plan = planViewModel.createPlan(title: "New plan")
        showSheet.toggle()
    }
    
}

struct PlannerView_Previews: PreviewProvider {
    static var previews: some View {
        PlannerView(plan: Plan(id: "1", title: "Abc", date: Date(), note: "", isCompleted: false))
            .environmentObject(PlanViewModel())
    }
}
