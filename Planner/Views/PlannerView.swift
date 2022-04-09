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
    @State private var deletePlan: Plan?

    var body: some View {
        NavigationView {
            ZStack {
                if planViewModel.plans.isEmpty {
                    Text("No items available")
                } else {
                    List {
                        ForEach(planViewModel.plans) { item in
                            PlanListView(plan: item)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    plan = item
                                }
                                .contextMenu {
                                        Button {
                                            plan = item
                                        } label: {
                                            Label("Edit", systemImage: "pencil")
                                        }

                                        Button(role: .destructive) {
                                            deletePlan = item
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                    }
                        }
                        .onDelete(perform: planViewModel.deletePlan)
//                        .onMove(perform: planViewModel.movePlan)
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
            .actionSheet(item: $deletePlan) { item in
                ActionSheet(
                    title: Text("Delete \"\(item.title)\"?"),
                    message: Text("This item will be deleted permanently"),
                    buttons: [
                        .destructive(Text("Delete anyway")) {
                            deletePlan(id: item.id)
                        },
                        .cancel()
                    ]
                )
            }
        }
    }
    
    func createPlan() {
        plan = planViewModel.createPlan(title: "New plan")
        showSheet.toggle()
    }
    
    func deletePlan(id: String) {
        planViewModel.deletePlanById(id: id)
    }
    
}

struct PlannerView_Previews: PreviewProvider {
    static var previews: some View {
        PlannerView()
            .environmentObject(PlanViewModel())
    }
}
