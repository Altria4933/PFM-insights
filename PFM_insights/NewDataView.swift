//
//  NewDataView.swift
//  PFM_insights
//
//  Created by Shane Xu on 24/04/21.
//

import SwiftUI

struct NewDataView: View {
    @ObservedObject var homeData : HomeViewModel
    @Environment(\.managedObjectContext) var context
    @State private var vendor = ""
    @State private var amount = 0.0
    @State private var date = Date()
    @State private var dateString = ""
    @State private var amountString = ""
    @State private var Category = ""
    
    @State private var alertTitle = ""
    @State private var alertBody = ""
    @State private var showingAlert = false
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20){
            
            Section{
                Text("\(homeData.updateItem == nil ? "Add a New" : "Update") Transaction")
                    .font(.system(size: 35))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding()
                Spacer(minLength: 0)
            }
           Section{
                Text("Please enter the vendor name")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding()
                TextField("Description",
                          text: $homeData.vendor)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }
            Section{
                Text("Please select the transaction amount")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding()
                TextField("Transaction amount",
                          text: $homeData.money)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .padding()
            }
            
            Divider()
                .padding(.horizontal)
            
            Section{
                Text("Please select the transaction date")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                //Spacer(minLength: 0)
                
                DatePicker("", selection: $homeData.date, displayedComponents: .date)
                    .labelsHidden()
            }
            .padding()
            
            // Add Button....
            //Button(action: {homeData.writeData(context: context)}, label: {
            Button(action: update, label: {
                Label(
                    title: { Text(homeData.updateItem == nil ? "Add Now" : "Update")
                        .font(.title)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    },
                    icon: { Image(systemName: "plus")
                        .font(.title)
                        .foregroundColor(.white)
                    })
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 30)
                    .background(
                    
                        LinearGradient(gradient: .init(colors: [Color("Color"),Color("Color1")]), startPoint: .leading, endPoint: .trailing)
                    )
                    .cornerRadius(8)
            })
            .padding()
            // disabling button when no data...
            .disabled(homeData.vendor == "" ? true : false)
            .opacity(homeData.vendor == "" ? 0.5 : 1)
        }
        .alert(isPresented: $showingAlert)  {
            Alert(title: Text(alertTitle), message: Text(alertBody), dismissButton: .default(Text("OK")))
        }
        //.background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .bottom))
    }
    func calculate () {
        let model = PFM_model()
        let dateformatter = DateFormatter()
        dateformatter.timeStyle = .medium
        dateString = dateformatter.string(from: date)
        amount = Double(amountString) ?? 0.0
        do{
            let prediction = try
                model.prediction(Date:String(dateString),Description:String(vendor),Amount:Double(amount))
            
            Category = prediction.Category__need_want_joy_
            alertTitle = "This transaction is a..."
            alertBody = Category
        }catch {
            alertTitle = "Error"
            alertBody = "Sorry, there was a problem"
        }
        showingAlert = true
    }
    
    func update() {
        calculate()
        homeData.writeData(context: context)
    }
}

struct NewDataView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
            
            
}
}



