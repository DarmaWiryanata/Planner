//
//  PlannerView.swift
//  Planner
//
//  Created by Darma Wiryanata on 06/04/22.
//

import SwiftUI

struct PlannerView: View {
    
    @EnvironmentObject var planViewModel: PlanViewModel
    
    @State private var plan: Plan?
    @State private var deletePlan: Plan?
    @State private var sharePlan: Plan?
    
    @State private var showSheet: Bool = false
    @State private var shareSheet = false

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

                                        Button {
                                            sharePlan = item
                                            shareSheet.toggle()
                                        } label: {
                                            Label("Share", systemImage: "square.and.arrow.up")
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
                DetailSheet(id: item.id, title: item.title, date: item.date ?? Date(), actualDate: item.date ?? Optional(nil), note: item.note ?? "", isCompleted: item.isCompleted)
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
            .shareSheet(isPresented: $shareSheet, items: ["My next plan is \(sharePlan?.title ?? "")\(sharePlanItem())"])
        }
    }
    
    func createPlan() {
        plan = planViewModel.createPlan(title: "New plan")
        showSheet.toggle()
    }
    
    func deletePlan(id: String) {
        planViewModel.deletePlanById(id: id)
    }
    
    func sharePlanItem() -> String {
        if sharePlan?.date != Optional(nil) {
            return " at \(sharePlan?.date?.formatDateTime() ?? "")"
        } else {
            return ""
        }
    }
    
}

struct PlannerView_Previews: PreviewProvider {
    static var previews: some View {
        PlannerView()
            .environmentObject(PlanViewModel())
    }
}
