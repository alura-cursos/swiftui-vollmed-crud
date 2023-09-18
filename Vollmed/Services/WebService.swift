//
//  WebService.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 12/09/23.
//

import UIKit

struct WebService {
    
    private let baseURL = "http://localhost:3000"
    
    func downloadImage(from imageURL: String) async throws -> UIImage? {
        guard let url = URL(string: imageURL) else {
            print("Erro na URL!")
            return nil
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        return UIImage(data: data)
    }
    
    func getAllSpecialists() async throws -> [Specialist]? {
        let endpoint = baseURL + "/especialista"
        
        guard let url = URL(string: endpoint) else {
            print("Erro na URL!")
            return nil
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let specialists = try JSONDecoder().decode([Specialist].self, from: data)
        
        return specialists
    }
}
