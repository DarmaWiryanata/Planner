//
//  Checkbox.swift
//  Planner
//
//  Created by Darma Wiryanata on 06/04/22.
//

import SwiftUI

struct Checkbox: View {
    @Binding var isCompleted: Bool
    
    var body: some View {
        Image(systemName: isCompleted ? "checkmark.circle.fill" : "circle")
            .resizable()
            .frame(width: 30, height: 30)
            .foregroundColor(isCompleted ? .blue : .gray)
    }
}

struct Checkbox_Previews: PreviewProvider {
    static var previews: some View {
        Checkbox(isCompleted: .constant(true))
    }
}
