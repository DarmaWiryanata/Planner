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
        
    @State var id: String
    @State var title: String
    @State var date: Date
    @State var actualDate: Date?
    @State var note: String
    @State var isCompleted: Bool
    
    @State private var deleteAction = false
    @State private var shareSheet = false
    
    var body: some View {
        NavigationView {
            ZStack {
                
                Color(UIColor.systemGray5)
                
                ScrollView {
                    DetailSheetForm(title: $title, isCompleted: $isCompleted, date: $date, note: $note)
                }
                
                    .navigationTitle("Plan Detail")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarItems(
                        leading: Button("Cancel") {
                            presentationMode.wrappedValue.dismiss()
                        },
                        trailing: Button {
                            saveButtonPressed()
                        } label: {
                            Text("Done")
                                .bold()
                        }
                    )
                    .toolbar {
                        ToolbarItem(placement: .bottomBar) {
                            Button(
                                action: {
                                    shareSheet.toggle()
                                },
                                label: {
                                    Image(systemName: "square.and.arrow.up")
                                }
                            )
                        }
                        
                        ToolbarItem(placement: .bottomBar) {
                            Button {
                                deleteAction.toggle()
                            } label: {
                                Image(systemName: "trash")
                            }
                        }
                    }
                    .actionSheet(isPresented: $deleteAction, content: {
                        ActionSheet(
                            title: Text("Delete \"\(title)\"?"),
                            message: Text("This item will be deleted permanently"),
                            buttons: [
                                .destructive(Text("Delete anyway")) {
                                    deleteButtonPressed(id: id)
                                },
                                .cancel()
                            ]
                        )
                    })
                    .shareSheet(isPresented: $shareSheet, items: ["My next plan is \(title)\(sharePlanItem())"])
            }
        }
    }
    
    func sharePlanItem() -> String {
        if actualDate != Optional(nil) {
            return " at \(date.formatDateTime())"
        } else {
            return ""
        }
    }
    
    func printPlan() {
        print("id: \(id), title: \(title), isCompleted: \(isCompleted), date: \(date), note: \(note)")
    }
    
    func saveButtonPressed() {
        printPlan()
        planViewModel.updatePlan(id: id, title: title, date: date, note: note, isCompleted: isCompleted)
        presentationMode.wrappedValue.dismiss()
    }
    
    func deleteButtonPressed(id: String) {
        planViewModel.deletePlanById(id: id)
        presentationMode.wrappedValue.dismiss()
    }
    
}

struct DetailSheet_Previews: PreviewProvider {
    static var previews: some View {
        DetailSheet(id: "1", title: "Abc", date: Date(), note: "Def", isCompleted: true)
    }
}

struct DetailSheetForm: View {
    
    @Binding var title: String
    @Binding var isCompleted: Bool
    @Binding var date: Date
    @Binding var note: String

    
    func toggle() {
        isCompleted = !isCompleted
    }
    
    var body: some View {
        VStack {
            // Title & checkbox
            HStack {
                Button(action: toggle) {
                    Image(systemName: isCompleted ? "checkmark.circle.fill" : "circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(isCompleted ? .blue : .gray)
                        .padding(.trailing)
                }
                TextField("Type something here...", text: $title)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(.white)
                    .cornerRadius(8)
                    .shadow(color: .gray, radius: 1, x: 0, y: 1)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1))
            }
            .padding(.vertical, 15)
            .padding(.leading)
            
            // Date & time
            DatePicker("Date", selection: $date)
                .padding(.vertical, 8)
                .padding(.horizontal)
                .background(.white)
                .cornerRadius(8)
                .shadow(color: .gray, radius: 1, x: 0, y: 1)
                .padding(.bottom, 15)
            
            // Note
            VStack {
                Text("Note".uppercased())
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                
                ZStack {
                    if note.isEmpty {
                        Text("Give some note...")
                    }
                    
                    TextEditor(text: $note)
                        .frame(height: 200)
                        .shadow(color: .gray, radius: 1, x: 0, y: 1)
                        .cornerRadius(8)
                        .overlay(RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1))
                }
            }
            
        }
        .padding()
    }
}
