//
//  ContentView.swift
//  PFM insights
//
//  Created by Altria on 11/10/20.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewRouter: ViewRouter
    
    @State var showPopUp = false
    
    let transactions: [Transaction] = [
        .init(id: 0, description: "Amazon", category: "Shopping", amount: "$11.11"),
        .init(id: 1, description: "Mortgage Payment", category: "Mortgage & Rent", amount: "$1247.44"),
        .init(id: 2, description: "Thai Restaurant", category: "Restaurants", amount: "$24.22")
    
    ]
    
    var body: some View {
        GeometryReader { geometry in
                VStack {
                Spacer()
                switch viewRouter.currentPage {
                case .home:
                    
                    NavigationView {
                        
                    List (transactions) {
                       
                        Text($0.description)
                            .font(.title)
                        Text($0.category)
                            .font(.subheadline)
                            .foregroundColor(Color.gray)
                            .multilineTextAlignment(.leading)
                        Text($0.amount)
                            .font(.body)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .foregroundColor(Color.orange)
                            .multilineTextAlignment(.trailing)
                            .lineLimit(0)
                            .padding(.leading, 22.0)
                        
                    }.navigationBarTitle(Text("Transaction List"))
                        
                    
                    }
                case .habit:
                    Text("Spending Habits")
                case .goal:
                    Text("Budget Goals")
                case .user:
                    Text("User")
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

struct Transaction: Identifiable {
    var id: Int
    let description, category, amount: String
    
}
