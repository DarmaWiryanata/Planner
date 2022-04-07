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
    @State var title: String
    @State var date: Date = Date()
    @State var note: String = "Full note"
    @State var isCompleted: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView{
                DetailSheetForm(title: $title, isCompleted: $isCompleted, date: $date, note: $note)
            }
            
                .navigationTitle(title)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(
                    leading: Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    },
                    trailing: Button {
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
        planViewModel.createItem(title: title, date: date, time: date, note: note, isCompleted: isCompleted)
        presentationMode.wrappedValue.dismiss()
    }
    
}

struct DetailSheet_Previews: PreviewProvider {
    static var previews: some View {
        DetailSheet(title: "Example", date: Date(), note: "Note", isCompleted: false)
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
