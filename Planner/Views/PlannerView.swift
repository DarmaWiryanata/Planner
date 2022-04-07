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
    
    var body: some View {
        NavigationView {
            ZStack {
                if planViewModel.items.isEmpty {
                    Text("No items")
                } else {
                    List(planViewModel.items) { item in
                        PlanListView(plan: item)
                    }
                }
            }
            
            .navigationTitle("All Plans")
            .navigationBarItems(
                leading: EditButton(),
                trailing:
                    Button("Add") {
                         showSheet.toggle()
                    }
            )
            .sheet(isPresented: $showSheet) {
                DetailSheet(title: "New plan", date: Date(), note: "Note", isCompleted: false)
            }
        }
    }
    
}

struct PlannerView_Previews: PreviewProvider {
    static var previews: some View {
        PlannerView()
            .environmentObject(PlanViewModel())
    }
}
