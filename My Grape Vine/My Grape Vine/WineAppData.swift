//
//  WineAppData.swift
//  My Grape Vine
//
//  Created by Daniel Martin (RIT Student) on 4/26/17.
//  Copyright © 2017 Daniel Martin (RIT Student). All rights reserved.
//

import Foundation

class WineData {
    static let sharedData = WineData()
    
    var options = [
        "Popularity","Rating","State"
    ]
    var sortBy = [
        "Popularity": URL(string:"http://services.wine.com/api/beta2/service.svc/json/catalog?apikey=7dbccdc4de31b4985e1d024a261828e5&size=25&offset=10&sort=popularity|ascending"),
        "In Stock": URL(string:"http://services.wine.com/api/beta2/service.svc/json/catalog?apikey=7dbccdc4de31b4985e1d024a261828e5&size=25&offset=10&instock=true")
    ]
    var sortingOptions = ["Ascending","Descending"]
    var state = ["State":
        [
        "AL", "AK", "AS", "AZ", "AR", "CA", "CO", "CT", "DE", "DC", "FM", "FL", "GA", "GU", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME",
        "MH", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "MP", "OH", "OK", "OR", "PW", "PA", "PR",
        "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VI", "VA", "WA", "WV", "WI", "WY"
        ]
    ]

    private init(){
    }
    
    var getSortBy:[String]{
        return [String](sortBy.keys)
    }
    
    var getStates:[String]{
        return state["State"] ?? [String]()
    }
}
