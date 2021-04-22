//
//  ContentView.swift
//  PFM insights
//
//  Created by Altria on 11/10/20.
//

import SwiftUI

struct ContentView: View {
<<<<<<< Updated upstream
=======
    
    
    @State var title = ""
    @State var SavedTitle = ""
    @StateObject var viewRouter: ViewRouter
    
    @State var showPopUp = false
    
    @State private var pieChartEntries: [PieChartDataEntry] = []
    @State private var category: Wine.Category = .variety
    
    @Environment(\.managedObjectContext) private var managedObjectContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Transaction.date, ascending: false)])
    private var transactions: FetchedResults<Transaction>
    
    private func saveContext() {
        do {
            try managedObjectContext.save()
        } catch {
            let error = error as NSError
            fatalError("Unresolved Error: \(error)")
        }
    }
    private func addList() {
        withAnimation {
            let newList = Transaction(context: managedObjectContext)
            newList.title = "New Task \(Date())"
            newList.date = Date()
            saveContext()
        }
    }
    
    private func deleteList(offsets: IndexSet) {
        withAnimation {
            offsets.map { transactions[$0] }.forEach(managedObjectContext.delete)
            saveContext()
       }
    }
    
    private func saveData(){
        UserDefaults.standard.set(self.title, forKey: "Title")
    }
    private func getData(){
        SavedTitle = UserDefaults.standard.string(forKey: "Title") ?? ""
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
                    
                case .add:
                    VStack {
                        Text("")
                        Spacer()
                        Text("Enter Title")
                        TextField("Enter Title", text: $title)
                        Button(action:{}){
                            Text("Save")
                        }
                    }
                    
                    
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
                        
                        HStack{
                        TabBarIcon(viewRouter: viewRouter, assignedPage: .home, width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "Home", tabName: "Home")
                        TabBarIcon(viewRouter: viewRouter, assignedPage: .habit, width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "Habit", tabName: "Habit")
                        TabBarIcon(viewRouter: viewRouter, assignedPage: .add, width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "File", tabName: "Add")
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
            }.transition(.scale)
        }
}


struct TabBarIcon: View {
    @StateObject var viewRouter: ViewRouter
    let assignedPage: Page
    let width, height: CGFloat

    let systemIconName, tabName: String
>>>>>>> Stashed changes
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
