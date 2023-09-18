//
//  ScheduleAppointmentView.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 18/09/23.
//

import SwiftUI

struct ScheduleAppointmentView: View {
    
    let service = WebService()
    var specialistID: String
    var isRescheduleView: Bool
    
    @State private var selectedDate = Date()
    @State private var showAlert = false
    @State private var isAppointmentScheduled = false
    
    init(specialistID: String, isRescheduleView: Bool = false) {
        self.specialistID = specialistID
        self.isRescheduleView = isRescheduleView
    }
    
    func rescheduleAppointment() async {
        
    }
    
    func scheduleAppointment() async {
        do {
            if let _ = try await  service.scheduleAppointment(specialistID: specialistID, patientID: patientID, date: selectedDate.convertToString()) {
                isAppointmentScheduled = true
            } else {
                isAppointmentScheduled = false
            }
        } catch {
            isAppointmentScheduled = false
            print("Ocorreu um erro ao agendar consulta: \(error)")
        }
        showAlert = true
    }
    
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
                Task {
                    if isRescheduleView {
                        await rescheduleAppointment()
                    } else {
                        await scheduleAppointment()
                    }
                }
            }, label: {
                ButtonView(text: isRescheduleView ? "Reagendar consulta" : "Agendar consulta")
            })
        }
        .padding()
        .navigationTitle(isRescheduleView ? "Reagendar consulta" : "Agendar consulta")
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            UIDatePicker.appearance().minuteInterval = 15
        }
        .alert(isAppointmentScheduled ? "Sucesso!" : "Ops, algo deu errado!", isPresented: $showAlert, presenting: isAppointmentScheduled) { _ in
            Button(action: {}, label: {
                Text("Ok")
            })
        } message: { isScheduled in
            if isScheduled {
                Text("A consulta foi \(isRescheduleView ? "reagendada" : "agendada") com sucesso!")
            } else {
                Text("Houve um erro ao \(isRescheduleView ? "reagendar" : "agendar") sua consulta. Por favor tente novamente ou entre em contato via telefone.")
            }
        }
    }
}

#Preview {
    ScheduleAppointmentView(specialistID: "123")
}
