//
//  DetailView.swift
//  PFM insights
//
//  Created by Shane Xu on 22/03/21.
//

import SwiftUI

struct DetailView: View {
    
    let receipt: Receipt
    
    var body: some View {
        VStack {
            Image(receipt.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .clipped()
                .cornerRadius(150)
                .shadow(radius: 3)
            Text(receipt.vandor)
                .font(.title)
                .fontWeight(.medium)
            Form {
                Section {
                    HStack {
                        Text("Price")
                        Spacer()
                        Text("NZD $" + receipt.price)
                            .foregroundColor(.gray)
                            .font(.callout)
                    }
                    HStack {
                        Text("Type")
                        Spacer()
                        Text(receipt.type)
                            .foregroundColor(.gray)
                            .font(.callout)
                    }
                    HStack {
                        Text("Date")
                        Spacer()
                        Text(receipt.date)
                            .foregroundColor(.gray)
                            .font(.callout)
                            
                    }
                }
                
            }
        }
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(receipt: receipts[0])
            .padding(.top, 60)
    }
}
