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
    var categories = ["Need", "Want", "Joy"]
    @State private var selectedCategory = ""
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 2){
            
            Section{
                Text("\(homeData.updateItem == nil ? "Add a New" : "Update") Transaction")
                    .font(.system(size: 60))
                    .fontWeight(.semibold)
                    .foregroundColor(Color("MainColor"))
                    .padding()
            }
            Section{
                Text("Please enter the vendor name")
                    .font(.title3)
                    .fontWeight(.regular)
                    .foregroundColor(Color("TextColor"))
                    .padding()
                TextField("Vendor Name",
                          text: $homeData.vendor)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }
            Section{
                Text("Please select the transaction amount")
                    .font(.title3)
                    .fontWeight(.regular)
                    .foregroundColor(Color("TextColor"))
                    .padding()
                TextField("Transaction Amount",
                          text: $homeData.money)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .padding()
            }
            Section{
                Text("Please sugget a transaction category")
                    .font(.title3)
                    .fontWeight(.regular)
                    .foregroundColor(Color("TextColor"))
                    .padding()
                Picker( selection: $homeData.category,label: Text("Category")){
                    ForEach(categories, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
            }
            Section{
                Text("Please select the transaction date")
                    .font(.title3)
                    .fontWeight(.regular)
                    .foregroundColor(Color("TextColor"))
                
                //Spacer(minLength: 0)
                
                DatePicker("", selection: $homeData.date, displayedComponents: .date)
                    .labelsHidden()
                    .accentColor(Color("MainColor"))
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
                    .background(Color("MainColor"))
                    .cornerRadius(10)
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
        dateformatter.dateStyle = .short
        dateString = dateformatter.string(from: homeData.date)
        amount = Double(homeData.money) ?? 0.0
        homeData.amount = amount
        
        do{
            let prediction = try
                model.prediction(Date:String(dateString),Description:String(homeData.vendor),Amount:Double(amount))
            
            Category = prediction.Category__need_want_joy_
            homeData.category = Category
            alertTitle = "This transaction is a..."
            alertBody = Category
        }catch {
            alertTitle = "Error"
            alertBody = "Sorry, there was a problem"
            showingAlert = true
        }
        
    }
    
    func update() {
        calculate()
        //homeData.category = selectedCategory
        homeData.writeData(context: context)
    }
    
}

struct NewDataView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
        
        
    }
}



