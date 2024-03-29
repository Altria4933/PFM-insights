//
//  HomeViewModel.swift
//  PFM_insights
//
//  Created by Shane Xu on 24/04/21.
//

import SwiftUI
import CoreData

class HomeViewModel : ObservableObject{
    
    @Published var content = ""
    @Published var date = Date()
    @Published var money = ""
    @Published var amount = 0.0
    @Published var category = ""
    @Published var vendor = ""
    // For NewData Sheet...
    @Published var isNewData = false
    
   /* private let validation: ValidationService
    init (validation : ValidationService){
        self.validation = validation
        super.init()
    }
    required init(coder: NSCoder) {
        self.validation = ValidationService()
           super.init(coder: coder)
       } */
    // Checking And Updating Date....
    
    // Storing Update Item...
    @Published var updateItem : Transaction!
    
    let calendar = Calendar.current
    
    func checkDate()->String{
        
        if calendar.isDateInToday(date){
            
            return "Today"
        }
        else if calendar.isDateInTomorrow(date){
            return "Tomorrow"
        }
        else{
            return "Other day"
        }
    }
    
    func updateDate(value: String){
        
        if value == "Today"{date = Date()}
        else if value == "Tomorrow"{
            date = calendar.date(byAdding: .day, value: 1, to: Date())!
        }
        else{
            // do something...
        }
    }
    
    func writeData(context : NSManagedObjectContext){
        //convert amount(string) to double
        //amount = Double(money)!
        
        // Updating Item.....
        
        if updateItem != nil{
            
            // Means Update Old Data...
            updateItem.date = date
            updateItem.content = content
            updateItem.vendor = vendor
            updateItem.money = money
            updateItem.category = category
            updateItem.amount = amount
            try! context.save()
            
            // removing updatingItem if successful
            
            updateItem = nil
            isNewData.toggle()
            content = ""
            vendor = ""
            category = ""
            money = ""
            amount = 0.0
            date = Date()
            return
        }
        
        let newTask = Transaction(context: context)
        newTask.date = date
        newTask.content = content
        newTask.vendor = vendor
        newTask.money = money
        newTask.amount = amount
        newTask.category = category
        // saving data...
        
        do{
            
            try context.save()
            // success means closing view...
            isNewData.toggle()
            content = ""
            vendor = ""
            category = ""
            money = ""
            date = Date()
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
    func EditItem(item: Transaction){
        //convert amount(string) to double
        //amount = Double(money)!
        
        updateItem = item
        // togging the newDataView....
        date = item.date!
        content = item.content!
        vendor = item.vendor!
        category = item.category!
        money = item.money!
        amount = item.amount
        isNewData.toggle()
    }
}


