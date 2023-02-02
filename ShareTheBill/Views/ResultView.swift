//
//  ResultView.swift
//  ShareTheBill
//
//  Created by Russell Gordon on 2023-02-02.
//

import SwiftUI

struct ResultView: View {
    
    // MARK: Stored properties
    let priorResult: Result
    
    // MARK: Computed properties
    var body: some View {
        HStack {
            
            VStack(alignment: .leading, spacing: 3) {
                
                Text("Amount")

                Text("Tip")

                // Divider
                Text("")
                
                Text("Total")

                Text("People")
                
                // Divider
                Text("")

                Text("Per person")

                // Divider
                Text("")
            }
            .font(Font.custom("Courier New",
                              size: 14.0,
                              relativeTo: .body))
            .bold()

            Spacer()
            
            VStack(alignment: .trailing, spacing: 1) {

                // Amount
                Text("$ \(priorResult.billAmount)")
                
                // Tip
                Text("✕ \(priorResult.percentage)%")
                
                Text("-----------")

                // Total
                Text("$ \(priorResult.totalWithTip)")

                // People
                Text("÷ \(priorResult.peopleCount)")
                
                Text("-----------")
                
                // Amount per person
                Text("$ \(priorResult.amountPerPerson)")
                
                Text("===========")
            }
            .font(Font.custom("Courier New",
                              size: 14,
                              relativeTo: .body))

        }
        .padding(.horizontal)
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(priorResult: exampleResultForPreviews)
    }
}
