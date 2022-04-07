//
//  PlanListView.swift
//  Planner
//
//  Created by Darma Wiryanata on 06/04/22.
//

import SwiftUI

struct PlanListView: View {
        
    let plan: Plan
    
    var body: some View {
        NavigationLink(destination: Text("Abc")) {
            HStack {
                Image(systemName: "checkmark.circle.fill")
                    .onTapGesture {
                        withAnimation(.linear) {}
                    }
                VStack {
                    Text(plan.title)
//                    if plan.date? != nil {
//                        Text(plan.time? != nil ? "\(plan.date?) - \(plan.time?)" : plan.date?)
//                    }
                    
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
