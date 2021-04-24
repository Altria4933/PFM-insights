//
//  DetailView.swift
//  PFM_insights
//
//  Created by Shane Xu on 25/04/21.
//

import SwiftUI

struct DetailView: View {
    @FetchRequest(entity: Transaction.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: true)],animation: .spring()) var results : FetchedResults<Transaction>
    
   
    var body: some View {
        Text("Hello, World!")
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
