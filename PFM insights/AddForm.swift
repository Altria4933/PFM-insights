//
//  AddForm.swift
//  PFM insights
//
//  Created by Altria on 22/04/21.
//

import SwiftUI

class AddFormModel: ObservableObject {
    @State var Description = ""
    @State var Amount = ""
    @State var TransDate = Date()
}


struct AddForm: View {
    //Need a date formatter here converts date to a string
    //let dateFormatter = DateFormatter()
    //dateFormatter.timeStyle= .medium
    @StateObject var viewModel = AddFormModel()
    
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    //The field has a * cannot be empty
                    //form sections
                    Section(header: Text("What you bought?")){
                        TextField("Description",
                                  text: $viewModel.Description)
                    }
                    Section(header: Text("Please enter the transaction amount")){
                        
                        TextField("Transaction amount",
                                  text: $viewModel.Amount)
                            .keyboardType(.numberPad)
                    }
                    Section(header: Text("Please select the transaction date")){
                        DatePicker("Enter your birthday", selection: $viewModel.TransDate, displayedComponents: .date)
                                       .datePickerStyle(GraphicalDatePickerStyle())
                                       .frame(maxHeight: 400)
                    }
                }
                
                //submitting
                Button(action: {
                //post form
                }, label: {
                    Text("Submit")
                        .frame(width: 200,
                               height: 50,
                            alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(Color("Orange"))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                })
                .padding()
            }
            .navigationTitle("Add a new transaction")
        }
    }
}

struct AddForm_Previews: PreviewProvider {
    static var previews: some View {
        AddForm()
            .preferredColorScheme(.light)
    }
}



