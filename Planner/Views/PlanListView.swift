//
//  PlanListView.swift
//  Planner
//
//  Created by Darma Wiryanata on 06/04/22.
//

import SwiftUI

struct PlanListView: View {
    
    @EnvironmentObject var planViewModel: PlanViewModel
    let plan: Plan
    
    var body: some View {
        NavigationLink(destination: Text("Abc")) {
            HStack {
                Image(systemName: plan.isCompleted ? "checkmark.circle.fill" : "circle")
                    .onTapGesture {
                        withAnimation(.easeOut) {
                            planViewModel.updateIsCompleted(plan: plan)
                        }
                    }
                    .foregroundColor(plan.isCompleted ? .blue : .gray)
                
                
                VStack(alignment: .leading) {
                    Text(plan.title)
                    
                    if plan.date != Optional(nil) {
                        Text("\(plan.date?.formatDate() ?? Date().formatDate())")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
            }
        }
    }
}

struct PlanListView_Previews: PreviewProvider {
    static var previews: some View {
        let plan: Plan = Plan(title: "Plan 1", isCompleted: true)
        
        PlanListView(plan: plan)
    }
}

extension Date {
        func formatDate() -> String {
                let dateFormatter = DateFormatter()
            dateFormatter.setLocalizedDateFormatFromTemplate("EEEE, MMM d")
            return dateFormatter.string(from: self)
        }
}