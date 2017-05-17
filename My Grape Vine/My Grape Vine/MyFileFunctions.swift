//
//  MyFileFunctions.swift
//  File System Demo
//
//  Created by Daniel Martin (RIT Student) on 4/10/17.
//  Copyright © 2017 Daniel Martin (RIT Student). All rights reserved.
//

import Foundation
import UIKit

extension FileManager{
    static var documentsDirectory:URL{
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! as URL
    }
    
    static var tempDirectory:String{
        return NSTemporaryDirectory()
    }
    
    static var cachesDirectory:URL{
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first! as URL
    }
    
    static func filePathInDocumentsDirectory(fileName:String)->URL{
        return FileManager.documentsDirectory.appendingPathComponent(fileName)
    }
    
    static func fileExistsInDocumentsDirectory(fileName:String)->Bool{
        let path = filePathInDocumentsDirectory(fileName: fileName).path
        return FileManager.default.fileExists(atPath: path)
    }
    
    static func deleteFileInDocumentsDirectory(fileName:String){
        let path = filePathInDocumentsDirectory(fileName: fileName).path
        do{
            try FileManager.default.removeItem(atPath: path)
            print("FILE: \(path) was deleted")
        } catch {
            print("ERROR: \(error) - FOR FILE: \(path)")
        }
    }
    
    static func contentsOfDir(url:URL)->[String]{
        do{
            if let paths = try FileManager.default.contentsOfDirectory(atPath: url.path) as [String]?{
                return paths
            } else {
                print("none found")
                return [String]()
            }
        } catch {
            print("ERROR: \(error)")
            return [String]()
        }
    }
    
    static func clearDocumentsFolder(){
        let fileManager = FileManager.default
        let docsFolderPath = FileManager.documentsDirectory.path
        do{
            let filePaths = try fileManager.contentsOfDirectory(atPath: docsFolderPath)
            for filePath in filePaths {
                try fileManager.removeItem(atPath: docsFolderPath + "/" + filePath)
            }
            print("cleared documents folder")
        } catch{
            print("Could not clear Documents folder: \(error)")
        }
        
    }
}

extension UIImage {
    func saveImageAsPNG(url:URL){
        let pngData = UIImagePNGRepresentation(self)
        do{
            try pngData?.write(to: url)
        } catch {
            print("ERROR: saving \(url) - error = \(error)")
        }
    }
}


