//
//  SamplePieChartData.swift
//  Charts-SwiftUI
//
//  Created by Stewart Lynch on 2020-11-19.
//

import Charts
import Foundation

struct Wine {
    enum Category: String {
        case variety, winery
    }
    var category: Category
    var value:Double
    var label:String
    
    static func entriesForWines(_ wines: [Wine], category: Category) -> [PieChartDataEntry] {
        let requestedWines = wines.filter {$0.category == category}
        return requestedWines.map { PieChartDataEntry(value: $0.value, label: $0.label)}
    }
    static var allWines:[Wine] {
        [
            Wine(category: .variety, value: 6, label: "Need"),
            Wine(category: .variety, value: 5, label: "Want"),
            Wine(category: .variety, value: 12, label: "Joy"),
           
            Wine(category: .winery, value: 5, label: "Need"),
            Wine(category: .winery, value: 8, label: "Want"),
            Wine(category: .winery, value: 5, label: "Joy"),
            
        ]
    }
}

