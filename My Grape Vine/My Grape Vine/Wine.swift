//
//  Wine.swift
//  My Grape Vine
//
//  Created by Daniel Martin (RIT Student) on 5/15/17.
//  Copyright © 2017 Daniel Martin (RIT Student). All rights reserved.
//

import Foundation

class Wine:NSObject, NSCoding{
    var wine: AnyObject
    
    init(w:AnyObject){
        wine = w
    }
    
    required init(coder aDecoder:NSCoder) {
        wine = (aDecoder.decodeObject(forKey: "wine"))! as AnyObject
        print("init with coder called on")
    }
    
    public func encode(with aCoder: NSCoder){
        aCoder.encode(wine, forKey: "wine")
        print("encode with coder called on")
    }
}
