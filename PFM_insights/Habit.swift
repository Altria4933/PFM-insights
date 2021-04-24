//
//  Habit.swift
//  PFM_insights
//
//  Created by Shane Xu on 24/04/21.
//

import SwiftUI

struct Habit: View {
    var body: some View {
    NavigationView{
        
    VStack{
    
    HStack{
            
            Text("Transaction List")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.black)
            
        
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
               
                Text("$100(20%)")
                
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
                
                Text("$100(20%)")
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
               
                Text("$100(20%)")
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
