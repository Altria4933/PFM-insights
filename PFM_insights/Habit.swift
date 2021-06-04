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
    
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: Transaction.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: true)],animation: .spring()) var results : FetchedResults<Transaction>
    
    var task = Transaction()
    @State  var number = 0
    //@State var sumNeed = 0
    @State  var countWant: Float = 0.0
    @State  var countNeed: Float = 0.0
    @State  var countJoy: Float = 0.0
    @State var ratioWant: Float = 0.0
    @State var intWant: Int = 0
    @State  var ratioNeed: Float = 0.0
    @State var intNeed: Int = 0
    @State  var ratioJoy: Float = 0.0
    @State var intJoy: Int = 0
    
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
        intWant = Int(ratioWant)
        ratioJoy = (countJoy) / (countWant + countJoy + countNeed) * 100
        intJoy = Int(ratioJoy)
        ratioNeed = (countNeed) / (countWant + countJoy + countNeed) * 100
        intNeed = Int(ratioNeed)
          print (Int(countWant))
          print (Int(countJoy))
          print (Int(countNeed))
          print (Int(ratioWant))
          print (Int(ratioJoy))
          print (Int(ratioNeed))
       }
       catch {
          print (error)
       }
    
    }
    
        // FetchRequest with predicate set to "after now"
    @FetchRequest(entity: Transaction.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Transaction.money, ascending: false)] ) var fetchRequest: FetchedResults<Transaction>
    
        // sum results using reduce
    var sum : Double {
        fetchRequest.reduce(0) {
            $0+$1.amount
        }
    }


    
    func RatioNeed() {
        
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
                SumNeed()
                Text("Percentage: (\(intNeed)%)")
                
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
                SumWant()
                Text("Percentage: (\(intWant)%) ")
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
                SumJoy()
                Text("Percentage: (\(intJoy)%)")
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


struct SumNeed: View {
    
    @FetchRequest(entity: Transaction.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Transaction.money, ascending: false)], predicate: NSPredicate(format: "category == %@", "Need")) var fetchRequest: FetchedResults<Transaction>
    
        // sum results using reduce
    var sumNeed : Double {
        fetchRequest.reduce(0) {
            $0+$1.amount
        }
    }
    
    var body: some View {
        VStack{
            Text("$\(Int(sumNeed))")
        }
    }
}

struct SumWant: View {
    
    @FetchRequest(entity: Transaction.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Transaction.money, ascending: false)], predicate: NSPredicate(format: "category == %@", "Want")) var fetchRequest: FetchedResults<Transaction>
    
        // sum results using reduce
    var sumWant : Double {
        fetchRequest.reduce(0) {
            $0+$1.amount
        }
    }
    var body: some View {
        VStack{
            Text("$\(Int(sumWant))")
        }
    }
}

struct SumJoy: View {
    
    @FetchRequest(entity: Transaction.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Transaction.money, ascending: false)], predicate: NSPredicate(format: "category == %@", "Joy")) var fetchRequest: FetchedResults<Transaction>
    
        // sum results using reduce
    var sumJoy : Double {
        fetchRequest.reduce(0) {
            $0+$1.amount
        }
    }
    var body: some View {
        VStack{
            Text("$\(Int(sumJoy))")
        }
    }
}




