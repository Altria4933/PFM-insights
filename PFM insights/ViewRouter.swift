//
//  ViewRouter.swift
//  PFM insights
//
//  Created by Shane Xu on 15/03/21.
//

import SwiftUI

class ViewRouter: ObservableObject {
    
    @Published var currentPage: Page = .home
    
}


enum Page {
    case home
    case habit
    case add
    case goal
    case user
}
