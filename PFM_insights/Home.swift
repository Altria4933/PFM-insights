//
//  Home.swift
//  PFM_insights
//
//  Created by Shane Xu on 24/04/21.
//

import SwiftUI
import CoreData

struct Home: View {
    @StateObject var homeData = HomeViewModel()
    // Fetching Data.....
    @FetchRequest(entity: Transaction.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: true)],animation: .spring()) var results : FetchedResults<Transaction>
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        
        GeometryReader { geometry in
        
            VStack{
                
                // Empty View....
            NavigationView{
                
                    if results.isEmpty{
                       
                            Spacer()
                            
                            Text("No Transaction")
                                .font(.title)
                                .foregroundColor(Color("TextColor"))
                                .fontWeight(.bold)
                            
                            Spacer()
                            
        
                    }
                    else{
        
                            List{
                                ForEach(results){task in
                                    NavigationLink(destination: DetailView(task:task)) {
                                        ListRow(task: task)
                                    }
                                   
                                    .foregroundColor(.black)
                                    .contextMenu{
                                        
                                        Button(action: {homeData.EditItem(item: task)}, label: {
                                            Text("Edit")
                                        })
                                        
                                        Button(action: {
                                            context.delete(task)
                                            try! context.save()
                                        }, label: {
                                            Text("Delete")
                                        })
                                    }
                                }
                                
                            }.navigationBarTitle("Transaction List")
                                
      
                    }
                
            
            // Add Button...
                
            
        }
            }
            
            Button(action: {homeData.isNewData.toggle()}, label: {
                Image(systemName: "rectangle.stack.fill.badge.plus")
                    .padding(.top, 10.0)
                    .font(.title2)
             
            })
            .padding(.leading, 350.0)
            .sheet(isPresented: $homeData.isNewData, content: {
            
            NewDataView(homeData: homeData)
        })
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct ListRow: View {
    
    let task: Transaction
    
    var body: some View {
        
        HStack{
            VStack(alignment: .leading){
            Text(task.vendor ?? "")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(Color("TextColor"))
            Text(task.category ?? "")
                    .fontWeight(.bold)
                .foregroundColor(Color.gray)
               
            }
            Spacer()
            VStack(alignment: .trailing){
                Text("$\(task.money ?? "")")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Color("MainColor"))
            Text(task.date ?? Date(),style: .date)
                    .foregroundColor(Color.gray)
            
    }
}

}
}
