//
//  DetailView.swift
//  PFM_insights
//
//  Created by Shane Xu on 25/04/21.
//

import SwiftUI

struct DetailView: View {
    @FetchRequest(entity: Transaction.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: true)],animation: .spring()) var results : FetchedResults<Transaction>
    @Environment(\.managedObjectContext) var context

    var task = Transaction()
    @State var vandor = ""
    @State var money = ""
   
    var body: some View {
        VStack {
            Text(task.vendor ?? "")
                .font(.title)
                .fontWeight(.medium)
            Form {
                Section {
                    HStack {
                        Text("Price")
                        Spacer()
                        Text("$\(task.money ?? "")")
                            .foregroundColor(.gray)
                            .font(.callout)
                    }
                    HStack {
                        Text("Type")
                        Spacer()
                        Text(task.category ?? "")
                            .foregroundColor(.gray)
                            .font(.callout)
                    }
                    HStack {
                        Text("Date")
                        Spacer()
                        Text(task.date ?? Date(),style: .date)
                            .foregroundColor(.gray)
                            .font(.callout)
                            
                    }
                }
                
            }
    }
    }
}


