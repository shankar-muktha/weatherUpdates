//
//  ThirdViewController.swift
//  weatherForecast
//
//  Created by M Shankar on 3/2/21.
//  Copyright © 2021 shankarm. All rights reserved.
//

import UIKit
import SQLite

class ThirdViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var dbConnection:Connection!
    @IBOutlet weak var tv: UITableView!
    var Data1:[[String:String]] = []
    var cellData:[[String:String]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tv.delegate = self
        tv.dataSource = self
        let path = NSSearchPathForDirectoriesInDomains(
                   .documentDirectory, .userDomainMask, true
               ).first!
               print(path)
              do
              {
              dbConnection = try Connection("\(path)/Users.sqlite3")
               print("DB Created successfully")
               }
               catch
               {
                   print("error in creating DB")
               }
        
        
        do
                {
                    let stmt = try dbConnection.run("SELECT firstName,lastName,email,gender,password,confirmpassword from Users")
                  
                    var data1:[String:String] = [:]
                    for row in stmt
                    {
                        for (index,name) in stmt.columnNames.enumerated(){
                            data1["\(name)"] = "\(row[index]!)"
                        }
                        Data1.append(data1)

                       
                    }
                    cellData = Data1
                    print(cellData.count)
                }
                catch
                {
                    print("error in fetching data")
                }
            
        print(cellData.count)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tv.reloadData()
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        
        cell?.textLabel?.text = cellData[indexPath.row]["firstName"]
        return (cell)!
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            cellData.remove(at: indexPath.row)
            tv.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return.delete
    }
    

   

}
