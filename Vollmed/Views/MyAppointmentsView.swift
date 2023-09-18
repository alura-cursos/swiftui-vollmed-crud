//
//  MyAppointmentsView.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 18/09/23.
//

import SwiftUI

struct MyAppointmentsView: View {
    
    let service = WebService()
    
    @State private var appointments: [Appointment] = []
    
    func getAllAppointments() async {
        do {
            if let appointments = try await service.getAllAppointmentsFromPatient(patientID: patientID) {
                self.appointments = appointments
            }
        } catch {
            print("Ocorreu um erro ao obter consultas: \(error)")
        }
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            ForEach(appointments) { appointment in
                SpecialistCardView(specialist: appointment.specialist)
            }
        }
        .navigationTitle("Minhas consultas")
        .navigationBarTitleDisplayMode(.large)
        .padding()
        .onAppear {
            Task {
                await getAllAppointments()
            }
        }
    }
}

#Preview {
    MyAppointmentsView()
}
