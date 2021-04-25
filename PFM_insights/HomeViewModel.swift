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
    // For NewData Sheet...
    @Published var isNewData = false
    
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
        
        // Updating Item.....
        
        if updateItem != nil{
            
            // Means Update Old Data...
            updateItem.date = date
            updateItem.content = content
            updateItem.money = money
            try! context.save()
            
            // removing updatingItem if successful
            
            updateItem = nil
            isNewData.toggle()
            content = ""
            money = ""
            date = Date()
            return
        }
        
        let newTask = Transaction(context: context)
        newTask.date = date
        newTask.content = content
        newTask.money = money
        // saving data...
        
        do{
            
            try context.save()
            // success means closing view...
            isNewData.toggle()
            content = ""
            money = ""
            date = Date()
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
    func EditItem(item: Transaction){
        
        updateItem = item
        // togging the newDataView....
        date = item.date!
        content = item.content!
        money = item.money!
        isNewData.toggle()
    }
}


