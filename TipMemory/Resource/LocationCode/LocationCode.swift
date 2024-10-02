//
//  LocationCode.swift
//  TipMemory
//
//  Created by 권정근 on 9/27/24.
//

import Foundation

var locationCode: [[String]] = []

func parseCSVAt(url: URL) {
    
    do {
        let data = try Data(contentsOf: url)
        guard let dataEncoded = String(data: data, encoding: .utf8) else {
            print("Failed to decode data.")
            return
        }
        
        let dataArr = dataEncoded.components(separatedBy: "\n").map { $0.components(separatedBy: ",") }
         
        for item in dataArr {
            locationCode.append(item)
        }
        
    } catch {
        print("Error reading CSV files")
    }
}
