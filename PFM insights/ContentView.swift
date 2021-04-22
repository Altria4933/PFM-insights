//
//  ContentView.swift
//  PFM insights
//
//  Created by Altria on 11/10/20.
//

import SwiftUI
import CoreData
import SwiftUICharts
import Charts

struct ContentView: View {
<<<<<<< HEAD
<<<<<<< HEAD
    
    @StateObject var viewRouter: ViewRouter
    
    @State var showPopUp = false
    
    @State private var pieChartEntries: [PieChartDataEntry] = []
    @State private var category: Wine.Category = .variety
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Transaction.date, ascending: false)])
    private var transactions: FetchedResults<Transaction>
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("Unresolved Error: \(error)")
        }
    }
    private func addList() {
        withAnimation {
            let newList = Transaction(context: viewContext)
            newList.title = "New Task \(Date())"
            newList.date = Date()
            saveContext()
        }
    }
    
    private func deleteList(offsets: IndexSet) {
        withAnimation {
            offsets.map { transactions[$0] }.forEach(viewContext.delete)
            saveContext()
       }
    }
    
    
    
    var body: some View {
        GeometryReader { geometry in
                VStack {
                switch viewRouter.currentPage {
                case .home:
                    NavigationView {
                        List(receipts) { receipt in
                            NavigationLink(destination: DetailView(receipt: receipt)) {
                                ContactRow(receipt: receipt)
                            }
                        }
                        .navigationBarTitle("Transaction List")
                    }
                    
                 
                case .habit:
                    
                    VStack {
                        Text("Spending Habits")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.top, 20.0)
                        Text("March")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.top, 20.0)
                        
                        PieChart(entries: Wine.entriesForWines(Wine.allWines,
                                                               category: category),
                                 category: $category)
                            .frame(height: 400)
                        //Picker(selection: $category, label: Text("Category")) {
                         //   Text("Variety").tag(Wine.Category.variety)
                         //   Text("Winery").tag(Wine.Category.winery)
                       // }
                      //  .pickerStyle(SegmentedPickerStyle())
                        
                    }
                    .padding(.horizontal)
                            
                case .goal:
                        Text("Budget Goal")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.top, 20.0)
                        
                    HStack{
                        Image(systemName: "checkmark.circle")
                            .resizable()
                            .frame(width: 50.0, height: 50.0)
                            .foregroundColor(/*@START_MENU_TOKEN@*/Color("MainColor")/*@END_MENU_TOKEN@*/)

                            VStack(alignment: .center) {
                                Text("Need")
                                    .font(.title)
                                    .fontWeight(.medium)
                                    .multilineTextAlignment(.leading)
                               
                                Text("$300(60%)")
                                
                            }
                            
                    }
                            .padding(.vertical, 50.0)
                    HStack{
                        Image(systemName: "heart.circle")
                            .resizable()
                            .frame(width: 50.0, height: 50.0)
                            .foregroundColor(/*@START_MENU_TOKEN@*/Color("MainColor")/*@END_MENU_TOKEN@*/)
                            VStack(alignment: .center) {
                                Text("Want")
                                    .font(.title)
                                    .fontWeight(.medium)
                                
                                Text("$100(20%)")
                            }
                    }
                            .padding(.bottom, 50.0)
                    HStack{
                        Image(systemName: "face.smiling")
                            .resizable()
                            .frame(width: 50.0, height: 50.0)
                            .foregroundColor(/*@START_MENU_TOKEN@*/Color("MainColor")/*@END_MENU_TOKEN@*/)
                            VStack(alignment: .center) {
                                Text("Joy")
                                    .font(.title)
                                    .fontWeight(.medium)
                               
                                Text("$100(20%)")
                            }
                            
                    }
                    
                    
                case .user:
                    NavigationView{
                        Login()
                            .navigationBarHidden(true)
                            .navigationBarBackButtonHidden(true)
                    }
                }
                Spacer()
                    ZStack {
                        if showPopUp {PlusMenu(widthAndHeight: geometry.size.width/7).offset(y: -geometry.size.height/6)
                            }
                        HStack{
                        TabBarIcon(viewRouter: viewRouter, assignedPage: .home, width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "Home", tabName: "Home")
                        TabBarIcon(viewRouter: viewRouter, assignedPage: .habit, width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "Habit", tabName: "Habit")
                        ZStack {
                            Circle().foregroundColor(Color("MainColor")).frame(width: geometry.size.width/7, height: geometry.size.height/7)
                                .shadow(radius: 2)
                            Image("Add").resizable().aspectRatio(contentMode: .fit).frame(width: geometry.size.width/12-6, height: geometry.size.height/12-6)
                                .rotationEffect(Angle(degrees: showPopUp ? 90:0))
                        }
                        .offset(y:-geometry.size.height/8/2)
                        .onTapGesture {
                            withAnimation {
                                showPopUp.toggle()
                            }
                        }
                        TabBarIcon(viewRouter: viewRouter, assignedPage: .goal, width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "Goal", tabName: "Goal")
                        TabBarIcon(viewRouter: viewRouter, assignedPage: .user, width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "Account", tabName: "Account")
                        
                    }
                        .frame(width:geometry.size.width, height: geometry.size.height/8).background(Color("TabBarBackground")).shadow(radius: 1)
                    }
                
            }
                .edgesIgnoringSafeArea(.bottom)
            }
        }
    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewRouter: ViewRouter())
            .preferredColorScheme(.light)
    }
}

struct PlusMenu: View {
    let widthAndHeight: CGFloat
        
        var body: some View {
            HStack(spacing: 50) {
                ZStack {
                    Circle()
                        .foregroundColor(Color("MainColor"))
                        .frame(width: widthAndHeight, height: widthAndHeight)
                    Image("File")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(15)
                        .frame(width: widthAndHeight, height: widthAndHeight)
                        .foregroundColor(.white)
                }
                ZStack {
                    Circle()
                        .foregroundColor(Color("MainColor"))
                        .frame(width: widthAndHeight, height: widthAndHeight)
                    Image("Camera")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(15)
                        .frame(width: widthAndHeight, height: widthAndHeight)
                        .foregroundColor(.white)
                }
            }
                .transition(.scale)
        }
}


struct TabBarIcon: View {
    @StateObject var viewRouter: ViewRouter
    let assignedPage: Page
    let width, height: CGFloat

    let systemIconName, tabName: String
=======
>>>>>>> parent of 1101229... Test input page
=======
>>>>>>> parent of 1101229... Test input page
    var body: some View {
        VStack{
            Image( systemIconName).resizable().aspectRatio(contentMode: .fit).frame(width:width, height:height).padding(.top, 20)
            Text(tabName).font(.footnote)
            Spacer()
        }
        .padding(.horizontal,-4)
        .onTapGesture {
            viewRouter.currentPage = assignedPage
        }
        .foregroundColor(viewRouter.currentPage == assignedPage ? Color("TabBarHighlight") : .gray)
    }
}




class Data2: NSManagedObject {
    
}


struct ContactRow: View {
    
    let receipt: Receipt
    
    var body: some View {
        HStack {
         Image(receipt.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .clipped()
                .cornerRadius(50)
 
            VStack(alignment: .leading) {
                Text(receipt.vandor)
                    .font(.system(size: 17, weight: .medium, design: .default))
                    .fontWeight(.semibold)
                Text(receipt.type)
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
                
            }
            Spacer()
            VStack(alignment: .trailing){
                Text("NZD " + receipt.price)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("MainColor"))
                Text(receipt.date)
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
            }
            
        }
    }
}
