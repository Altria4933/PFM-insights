//
//  Contact.swift
//  PFM insights
//
//  Created by Shane Xu on 22/03/21.
//

import Foundation
import SwiftUI

struct Receipt: Identifiable {
    let imageName: String
    let vandor: String
    let price: String
    let type: String
    let date: String
    let id = UUID()
}

let receipts = [
    Receipt(imageName: "Receipt", vandor: "Amazon", price: "11.11", type: "Joy", date: "01/01/2018"),
    Receipt(imageName: "Receipt_1", vandor: "Mortgage Payment", price:"1247.44", type: "Need", date: "01/02/2018"),
    Receipt(imageName: "Receipt_2", vandor: "Thai Restaurant", price: "24.22", type: "Joy", date: "01/02/2018"),
    Receipt(imageName: "Receipt_3", vandor: "Credit Card Payment", price: "2298.09", type: "Want", date: "01/02/2018"),
    Receipt(imageName: "Receipt", vandor: "Netflix", price: "11.76", type: "Joy", date: "01/04/2018"),
    Receipt(imageName: "Receipt_1", vandor: "American Tavern", price: "25.85", type: "Want", date: "01/04/2018")
]

