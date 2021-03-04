//
//  sharedInstance.swift
//  weatherForecast
//
//  Created by M Shankar on 3/2/21.
//  Copyright © 2021 shankarm. All rights reserved.
//

import Foundation
import SQLite
class DataManager{
static var shared = DataManager()
    var userDetails:[[String:Any]] = []
    var dbconn:Connection!
   private init() {
        
    }
    
    func gettingDeatailsFromLocalDB(){
        
        
                let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!

                do{
                    dbconn = try Connection("\(path)/Users.sqlite3")
                    print("db created successfully")
                }catch{
                    print("db not created")
                }
        //
                do{
                    try dbconn.run("CREATE TABLE IF NOT EXISTS Users (firstName,lastName,email,gender,password,confirmpassword)")
                    print("created table")
                }catch{
                    print("query wrong")
                }
                do{
                  let stmt = try dbconn.run("SELECT firstName,lastName,email,gender,password,confirmpassword from Users")
                    print(type(of: stmt))
                    var datab:[String:Any] = [:]
                    for row in stmt{
                        for (index,name) in stmt.columnNames.enumerated(){
                            print("\(name):\(row[index]!)")
                            
                            datab.updateValue(row[index]!, forKey: name)
                           // print(datab["name"]!)
                            
                            
                            
                        }
                        
                        userDetails.append(datab)
                       
                    }
                }catch
                {
                    print("didnot fetched")
                }
        
    }
}
