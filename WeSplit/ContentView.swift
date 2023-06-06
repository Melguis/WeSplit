//
//  ContentView.swift
//  WeSplit
//
//  Created by Jorge Henrique on 05/06/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    private var currencyType: FloatingPointFormatStyle<Double>.Currency {
        let currencyCode = Locale.current.currency?.identifier ?? "USD"
        return FloatingPointFormatStyle<Double>.Currency(code: currencyCode)
    }
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalWithTip: Double {
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let totalWithTip = checkAmount + tipValue
        return totalWithTip
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: currencyType)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people(s)")
                        }
                    }
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header : {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(totalWithTip, format: currencyType)
                } header : {
                    Text("Total amount with tip: ")
                }
                
                Section {
                    Text(totalPerPerson, format: currencyType)
                } header : {
                    Text("Amount per person: ")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
