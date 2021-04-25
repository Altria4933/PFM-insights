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
            NavigationView{
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom), content: {
                
                VStack(spacing: 0){
                    
                    HStack{
                        
                        Text("Transaction List")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Spacer(minLength: 0)
                    }
                    .padding()
                    .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
                    .background(Color.white)
                    
                    // Empty View....
                    
                    if results.isEmpty{
                        
                        Spacer()
                        
                        Text("No Transaction")
                            .font(.title)
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                    else{
                        
                        ScrollView(.vertical, showsIndicators: false, content: {
                            
                            LazyVStack(alignment: .leading,spacing: 20){
                                
                                ForEach(results){task in
                                    
                                    HStack(content: {
                                        VStack(alignment: .leading){
                                        Text(task.content ?? "")
                                            .font(.title)
                                            .fontWeight(.bold)
                                            
                                        Text(task.date ?? Date(),style: .date)
                                            .font(.subheadline)
                                            .foregroundColor(Color.gray)
                                        }
                                        Spacer()
                                        VStack(alignment: .trailing){
                                            Text(task.money ?? "")
                                                .font(.subheadline)
                                                .fontWeight(.bold)
                                                .foregroundColor(Color("MainColor"))
                                        }
                                        
                                    })
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
                            }
                            .padding()
                        })
                    }
                }
               
            
            // Add Button...
            
            Button(action: {homeData.isNewData.toggle()}, label: {
                
                Image(systemName: "plus")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(20)
                    .background(
                    
                        AngularGradient(gradient: .init(colors: [Color("Color"),Color("Color1")]), center: .center)
                    )
                    .clipShape(Circle())
            })
            .padding()
        })
        .ignoresSafeArea(.all, edges: .top)
        .background(Color.black.opacity(0.04).ignoresSafeArea(.all, edges: .all))
        .sheet(isPresented: $homeData.isNewData, content: {
            
            NewDataView(homeData: homeData)
        })
    }
}
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}