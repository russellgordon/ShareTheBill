//
//  Result.swift
//  ShareTheBill
//
//  Created by Russell Gordon on 2023-02-02.
//

import Foundation

struct Result: Identifiable {
    
    let id = UUID()
    let billAmount: String
    let percentage: String
    let totalWithTip: String
    let peopleCount: String
    let amountPerPerson: String
    
}

var exampleResultForPreviews = Result(billAmount: "100.00",
                                      percentage: "20",
                                      totalWithTip: "120.00",
                                      peopleCount: "2",
                                      amountPerPerson: "60.00")
