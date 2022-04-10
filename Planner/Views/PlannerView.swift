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
    @State private var animate: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                if planViewModel.plans.isEmpty {
                    ScrollView {
                        VStack(spacing: 10) {
                            Text("There are no item!")
                                .font(.title)
                                .fontWeight(.semibold)
                            
                            Text("Are you a productive person? I think you should click the add button and add a bunch of item to your plan!")
                                .padding(.bottom, 20)
                            
                            Text("Add Something 🥳")
                                .foregroundColor(.white)
                                .font(.headline)
                                .frame(height: 55)
                                .frame(maxWidth: .infinity)
                                .background(.blue)
                                .cornerRadius(10)
                                .onTapGesture {
                                    createPlan()
                                }
                            
                            .padding(.horizontal, animate ? 30 : 50)
                            .shadow(
                                color: .blue.opacity(0.7),
                                radius: animate ? 30 : 10,
                                x: 0,
                                y: animate ? 50 : 30
                            )
                            .scaleEffect(animate ? 1.1 : 1.0)
                            .offset(y: animate ? -7 : 0)
                        }
                        .frame(maxWidth: 400)
                        .multilineTextAlignment(.center)
                        .padding(40)
                    .onAppear(perform: addAnimation)
                    }
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
    
    func addAnimation() {
        guard !animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(
                Animation
                    .easeInOut(duration: 2.0)
                    .repeatForever()
            ) {
                animate.toggle()
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
