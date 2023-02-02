//
//  CalculationView.swift
//  ShareTheBill
//
//  Created by Russell Gordon on 2023-02-02.
//

import SwiftUI

struct CalculationView: View {
    
    // MARK: Stored properties
    
    // How much was the bill?
    @State var providedBillAmount = ""
    
    // Common tip percentages
    let tipPercentages = [10, 15, 20, 25, 0]
    
    // What tip percentage was selected?
    @State var selectedTipPercentage = 25
    
    // How many people are splitting this bill?
    @State var peopleCount = 2
    
    // Stores the history of tip calculations
    @Binding var history: [Result]
    
    // MARK: Computed properties
    
    // Handles conversion of text input to an optional Double
    var billAmount: Double? {
        
        guard let amountAsDouble = Double(providedBillAmount) else {
            // Text input was not a numeric value, so we don't know
            // what the bill amount should be
            return nil
        }
        
        // Text input was a numeric value, so return it
        return amountAsDouble
    }
    
    // Converts selected tip percentage to a Double and a value between 0 and 1
    // e.g.: 25 becomes 25.0 then after division by 100 becomes 0.25
    var tipPercentage: Double {
        return Double(selectedTipPercentage) / 100
    }
    
    // Calculates the total with the tip
    var totalWithTip: Double? {
        
        // Is the bill amount nil, or an actual numeric value?
        guard let amount = billAmount else {
            return nil
        }
        
        // Calculate the tip dollar amount
        let tipAmount = amount * tipPercentage
        
        // Calculate bill total, including the tip
        let billTotal = amount + tipAmount
        
        // Return total bill
        return billTotal
    }
    
    // Formats total with tip, or shows an error
    var totalWithTipFormatted: String {
        
        // Could the total with tip be calculated?
        // Or did that fail because the bill amount input was nonsense?
        guard let total = totalWithTip else {
            return "Cannot be calculated..."
        }
        
        // It could be calculated, so format it nicely
        return total.formatted(.number.precision(.fractionLength(2)))
        
    }
    
    // How much does each person pay?
    var amountEachPersonPays: Double? {
        
        // Could the total with tip be calculated?
        // Or did that fail because the bill amount input was nonsense?
        guard let total = totalWithTip else {
            return nil
        }
        
        // We have a valid total that includes tip
        // Now find out how much each person pays...
        // NOTE: total is now a Double that is guaranteed to not contain nil.
        // HOWEVER: We must convert "peopleCount" from an Int to a Double since
        //          we cannot divide a Double (total) by an Int (peopleCount)
        let amountPerPerson = total / Double(peopleCount)
        
        // Return the amount per person
        return amountPerPerson

    }
    
    // Format the amount each person pays, or show an error
    var amountEachPersonPaysFormatted: String {
        
        // Could the amount each person pays be calculated?
        // Or did that fail because earlier input was not valid?
        guard let amount = amountEachPersonPays else {
            return "Cannot be determined..."
        }
        
        // It could be calculated, so format it nicely
        return amount.formatted(.number.precision(.fractionLength(2)))

    }
    
    
    // Shows the user interface
    var body: some View {
        
        VStack(spacing: 0) {
            
            Group {
                
                HStack {
                    Text("Bill Amount")
                        .font(.headline.smallCaps())
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                HStack(spacing: 5) {
                    Text("$")
                    
                    TextField("100.00", text: $providedBillAmount)  // Now a "live" binding
                    // connected to providedBillAmount
                }
                .padding()
                
            }
            
            Group {
                
                HStack {
                    Text("Tip Percentage")
                        .font(.headline.smallCaps())
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                Picker("Tip Percentage",
                       selection: $selectedTipPercentage) { // Now a "live" binding
                    // connected to "selectedTipPercentage"
                    
                    // tipPercentages array does not conform to Identifiable
                    // However, by using the parameter "id" with argument "\.self"
                    // we can "promise" SwiftUI that the values in the array will
                    // all be unique.
                    ForEach(tipPercentages, id: \.self) { currentPercentage in
                        Text("\(currentPercentage)%")
                            .tag(currentPercentage)
                    }
                }
                       .pickerStyle(.segmented)
                       .padding()
                
            }
            
            Group {
                
                HStack {
                    Text("Total with Tip")
                        .font(.headline.smallCaps())
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                HStack(spacing: 5) {
                    Text("$")
                    
                    Text(totalWithTipFormatted)
                    
                    Spacer()
                }
                .padding()
                
            }
            
            Group {
                
                HStack {
                    Text("How many people?")
                        .font(.headline.smallCaps())
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                // Now a "live" binding connected to "peopleCount"
                Stepper("\(peopleCount)",
                        value: $peopleCount,
                        in: 2...20)
                .padding()
                
            }
            
            Group {
                
                HStack {
                    Text("Each person Pays...")
                        .font(.headline.smallCaps())
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                HStack(spacing: 5) {
                    Text("$")
                    
                    Text(amountEachPersonPaysFormatted)
                    
                    Spacer()
                }
                .padding()
                
            }
            
            Button(action: {
                
                // Create a string version of the bill amount
                guard let amount = billAmount else {
                    return
                }
                let amountFormatted = String( amount.formatted(.number.precision(.fractionLength(2))))
                
                // Create a string version of the percentage
                let percentage = String(selectedTipPercentage)
                
                // Create a string version of the people count
                let people = String(peopleCount)
                
                // Create the prior result, all put together into an instance of Result
                let priorResult = Result(billAmount: amountFormatted,
                                         percentage: percentage,
                                         totalWithTip: totalWithTipFormatted,
                                         peopleCount: people,
                                         amountPerPerson: amountEachPersonPaysFormatted)
                
                // Save the prior result to the history
                history.append(priorResult)
                
            }, label: {
                Text("Save")
                    .font(.headline.smallCaps())
            })
            .buttonStyle(.bordered)
            // Button stays greyed out so long as amount cannot be computed
            .disabled(amountEachPersonPays == nil)
            
            Spacer()
            
        }
        .padding(.top, 10)
        .navigationTitle("Share the Bill")
    }
}

struct CalculationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CalculationView(history: Binding.constant([exampleResultForPreviews]))
        }
    }
}
