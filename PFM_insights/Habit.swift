//
//  Habit.swift
//  PFM_insights
//
//  Created by Shane Xu on 24/04/21.
//

import SwiftUI
import CoreData
import UIKit
import Foundation

struct Habit: View {
    @StateObject var habitData = HabitViewModel()
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: Transaction.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: true)],animation: .spring()) var results : FetchedResults<Transaction>
    
    var task = Transaction()
    @State  var number = 0
    //@State var sumNeed = 0
    @State  var countWant: Float = 0.0
    @State  var countNeed: Float = 0.0
    @State  var countJoy: Float = 0.0
    @State var ratioWant: Float = 0.0
    @State  var ratioNeed: Float = 0.0
    @State  var ratioJoy: Float = 0.0
    
    func getRecordsCount() {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Transaction")
            do {
                number = try context.count(for: fetchRequest)
                
            } catch {
                print(error.localizedDescription)
            }
        }
    
    func getCount() {
       let context = PersistenceController.shared.container.viewContext
       
       let itemFetchRequestWant: NSFetchRequest<Transaction> = Transaction.fetchRequest()
       
       itemFetchRequestWant.predicate = NSPredicate(format: "category == %@", "Want")
        
        let itemFetchRequestJoy: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        
        itemFetchRequestJoy.predicate = NSPredicate(format: "category == %@", "Joy")
        
        let itemFetchRequestNeed: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        
        itemFetchRequestNeed.predicate = NSPredicate(format: "category == %@", "Need")
        
        
       do {
        countWant = Float(try context.count(for: itemFetchRequestWant))
        countJoy = Float(try context.count(for: itemFetchRequestJoy))
        countNeed = Float(try context.count(for: itemFetchRequestNeed))
           
        ratioWant = (countWant) / (countWant + countJoy + countNeed) * 100
        ratioJoy = (countJoy) / (countWant + countJoy + countNeed) * 100
        ratioNeed = (countNeed) / (countWant + countJoy + countNeed) * 100
          print (countWant)
          print (countJoy)
          print (countNeed)
          print (ratioWant)
          print (ratioJoy)
          print (ratioNeed)
       }
       catch {
          print (error)
       }
    
    }
    
        // FetchRequest with predicate set to "after now"
    @FetchRequest(entity: Transaction.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Transaction.money, ascending: false)], predicate: NSPredicate(format: "category == %@", "Need")) var fetchRequest: FetchedResults<Transaction>
    
        // sum results using reduce
    var sum : Double {
        fetchRequest.reduce(0) {
            $0+$1.amount
        }
    }
    


    var body: some View {
        
    NavigationView{
        
    VStack{
    
    HStack{
            
    
        Text("Transaction List")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.black)
                .onAppear(perform: {
                    
                    getCount()
                })
            
        
        }
    .padding(.top, -80.0)

    HStack{
        
        Image(systemName: "checkmark.circle")
            .resizable()
            .padding(.top)
            .foregroundColor(Color("MainColor"))
            .frame(width: 55.0, height: 70.0)

            VStack(alignment: .center) {
                Text("Need")
                    .font(.title)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.leading)
               
                Text("$\(sum)(\(ratioNeed)%)")
                
            }
            
    }
    .padding(.bottom, 50.0)
    
 
  
    HStack{
        Image(systemName: "heart.circle")
            .resizable()
            .frame(width: 50.0, height: 50.0)
            .foregroundColor(/*@START_MENU_TOKEN@*/Color("MainColor")/*@END_MENU_TOKEN@*/)
            VStack(alignment: .center) {
                Text("Want")
                    .font(.title)
                    .fontWeight(.medium)
                
                Text("$\(sum)(\(ratioWant)%)")
            }
    }
    .padding(.bottom, 50.0)
    
   
    
    HStack{
        Image(systemName: "face.smiling")
            .resizable()
            .frame(width: 50.0, height: 50.0)
            .foregroundColor(Color("MainColor"))
            VStack(alignment: .center) {
                Text("Joy")
                    .font(.title)
                    .fontWeight(.medium)
               
                Text("$\(sum)(\(ratioJoy)%)")
            }
            
    }
      Spacer()
    }
    }
    }
}

struct Habit_Previews: PreviewProvider {
    static var previews: some View {
        Habit()
    }
}


