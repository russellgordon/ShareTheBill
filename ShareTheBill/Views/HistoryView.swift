//
//  HistoryView.swift
//  ShareTheBill
//
//  Created by Russell Gordon on 2023-02-02.
//

import SwiftUI

struct HistoryView: View {
    
    // MARK: Stored properties
    
    // Connect to the source of truth at app entry point
    @Binding var history: [Result]
    
    // MARK: Computed properties
    var body: some View {
        
        NavigationView {
            List {
                ForEach(history.reversed()) { somePriorResult in
                    ResultView(priorResult: somePriorResult)
                }
                .onDelete(perform: delete)
            }
            .navigationTitle("History")
        }

    }
    
    // MARK: Functions
    func delete(at offsets: IndexSet) {
        history.remove(atOffsets: offsets)
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        
        NavigationView {
            
            HistoryView(history: Binding.constant([exampleResultForPreviews]))

        }
        
    }
}
