//
//  DetailSheet.swift
//  Planner
//
//  Created by Darma Wiryanata on 06/04/22.
//

import SwiftUI

struct DetailSheet: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var planViewModel: PlanViewModel
    
    @State var plan: Plan
    func printPlan() {
        print(plan)
    }
    
    var body: some View {
        NavigationView {
//            ScrollView {
                Text("abc")
//            }
            
                .navigationTitle(plan.title)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(
                    leading: Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    },
                    trailing: Button {
                        printPlan()
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Done")
                            .bold()
                    }
                )
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Button(action: {}, label: {})
                    }
                    
                    ToolbarItem(placement: .bottomBar) {
                        Button {
                        } label: {
                            Image(systemName: "trash")
                        }

                    }
                }
        }
    }
    
    func saveButtonPressed() {
//        planViewModel.createPlan(title: title)
        presentationMode.wrappedValue.dismiss()
    }
    
}

struct DetailSheet_Previews: PreviewProvider {
    static var previews: some View {
        DetailSheet(plan: Plan(id: "1", title: "Abc", date: Date(), note: "Def", isCompleted: false))
    }
}

struct DetailSheetForm: View {
    
    @Binding var title: String
    @Binding var isCompleted: Bool
    @Binding var date: Date
    @Binding var note: String
    
    var body: some View {
        VStack {
            // Title & checkbox
            HStack {
                Checkbox(isCompleted: $isCompleted)
                    .padding(.trailing)
                TextField("Type something here...", text: $title)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(UIColor.systemGray4))
                    .cornerRadius(10)
            }
            .padding(.bottom, 30)
            
            // Date & time
            DatePicker("Date", selection: $date, displayedComponents: [.date])
            DatePicker("Time", selection: $date, displayedComponents: [.hourAndMinute])
            
            // Note
            TextEditor(text: $note)
            
        }
        .padding()
    }
}
