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

extension Date {
    
    func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("EEEE, MMM d")
        return dateFormatter.string(from: self)
    }
    
    func formatDateTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("EEEE, MMM d hh:mm")
        return dateFormatter.string(from: self)
    }
    
}

extension UIApplication {
    
    static let keyWindow = keyWindowScene?.windows.filter(\.isKeyWindow).first
    static let keyWindowScene = shared.connectedScenes.first { $0.activationState == .foregroundActive } as? UIWindowScene
    
}

extension View {
    
    func shareSheet(isPresented: Binding<Bool>, items: [Any]) -> some View {
        guard isPresented.wrappedValue else { return self }
        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        let presentedViewController = UIApplication.keyWindow?.rootViewController?.presentedViewController ?? UIApplication.keyWindow?.rootViewController
        activityViewController.completionWithItemsHandler = { _, _, _, _ in isPresented.wrappedValue = false }
        presentedViewController?.present(activityViewController, animated: true)
        return self
    }
    
}
