//
//  CustomButtonModifier.swift
//  PFM_insights
//
//  Created by Shane Xu on 24/04/21.
//

import SwiftUI

struct CustomButtonModifier: ViewModifier {

    func body(content: Content) -> some View {
        
        return content
            .foregroundColor(.white)
            .padding(.vertical)
            .padding(.horizontal,35)
            .background(
            
                LinearGradient(gradient: .init(colors: [Color("yellow-light"),Color("yellow")]), startPoint: .leading, endPoint: .trailing)
            )
            .clipShape(Capsule())
    }
}
