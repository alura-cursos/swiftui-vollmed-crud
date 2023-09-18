//
//  ScheduleAppointmentView.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 18/09/23.
//

import SwiftUI

struct ScheduleAppointmentView: View {
    
    @State private var selectedDate = Date()
    
    var body: some View {
        VStack {
            Text("Selecione a data e o horário da consulta")
                .font(.title3)
                .bold()
                .foregroundStyle(.accent)
                .multilineTextAlignment(.center)
                .padding(.top)
            
            DatePicker("Escolha a data da consulta", selection: $selectedDate, in: Date()...)
                .datePickerStyle(.graphical)
            
            Button(action: {
                print(selectedDate.convertToString().convertDateStringToReadableDate())
            }, label: {
                ButtonView(text: "Agendar consulta")
            })
        }
        .padding()
        .navigationTitle("Agendar consulta")
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            UIDatePicker.appearance().minuteInterval = 15
        }
    }
}

#Preview {
    ScheduleAppointmentView()
}
