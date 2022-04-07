//
//  PlannerApp.swift
//  Planner
//
//  Created by Darma Wiryanata on 06/04/22.
//

import SwiftUI

@main
struct PlannerApp: App {
    
    @StateObject var planViewModel: PlanViewModel = PlanViewModel()
    
    var body: some Scene {
        WindowGroup {
            PlannerView()
                .environmentObject(planViewModel)
        }
    }
}
