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
                          text: $homeData.content)
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
                          text: $homeData.content)
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
            
            Button(action: {homeData.writeData(context: context)}, label: {
                
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
            .disabled(homeData.content == "" ? true : false)
            .opacity(homeData.content == "" ? 0.5 : 1)
        }
        //.background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .bottom))
    }
}
struct NewDataView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
            
            
}
}

