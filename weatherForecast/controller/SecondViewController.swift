//
//  SecondViewController.swift
//  weatherForecast
//
//  Created by M Shankar on 3/2/21.
//  Copyright © 2021 shankarm. All rights reserved.
//

import UIKit
import SQLite
//import SQLite
class SecondViewController: UIViewController,UITextFieldDelegate{
    var dbConnection:Connection!
    @IBOutlet weak var img2: UIImageView!
     var unchecked = true
    @IBOutlet weak var TCBtn: UIButton!
    
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var genderTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var conformPasswordTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameTF.delegate = self
        lastNameTF.delegate = self
        emailTF.delegate = self
        genderTF.delegate = self
        passwordTF.delegate = self
        conformPasswordTF.delegate = self
        TCBtn.layer.borderWidth = 1
        
        
       // sqlite statements
        
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
         
         
         do{
             try dbConnection.run("CREATE TABLE IF NOT EXISTS Users (firstName text,lastName text,email text,gender text,password text,confirmpassword text)")
             print("table created sucessfully")
         }
         catch{
             print("Error in table creation")
         }
        
      
    }
    
    @IBAction func acceptConditionAction(_ sender: UIButton) {
    

        if unchecked {
            sender.setImage(UIImage(named: "check"), for: UIControl.State.normal)
//            sender.setImage(UIImage(named:"check"), forControlState: .Normal)
            print("a")
            unchecked = false
        }
        else {
            sender.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
            print("b")
            unchecked = true
        }
        
    }
    
    @IBAction func onSignUpAction(_ sender: Any) {
        
        
        
        if(firstNameTF.text!.count>0&&lastNameTF.text!.count>0&&emailTF.text!.count>0&&genderTF.text!.count>0&&passwordTF.text!.count>0 && conformPasswordTF.text!.count>0)
            {
            
            do{
                try dbConnection.run("INSERT INTO Users (firstName,lastName,email,gender,password,confirmpassword) VALUES (?,?,?,?,?,?)",firstNameTF.text!,lastNameTF.text!,emailTF.text!,genderTF.text!,passwordTF.text!,conformPasswordTF.text!)
                
            }
            catch{
                print("error in insert file")
                
            }
            
            do
                    {
                        let stmt = try dbConnection.run("SELECT firstName,lastName,email,gender,password,confirmpassword from Users")
                      
                        
                        for row in stmt
                        {
                           
                            for(index,name) in stmt.columnNames.enumerated()
                            {
                            print("\(name):\(row[index]!)")
                            }
                        }
                    }
                    catch
                    {
                        print("error in fetching data")
                    }
                
            
            
        }
            else
            {
                showMessageToUser(title: "Error", msg: "Please Enter All Field")
            }
        
    }
    
    //Textfield String validation delegate
           func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
               
               var returnValue:Bool = false
               if(string == "")
               {
                   return true
               }
             
               if(textField == firstNameTF)
               {
               let firstName = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ")
               if(string.rangeOfCharacter(from: firstName) != nil)
               {
                  returnValue = true
               }
               else
               {
                   returnValue = false
               }
               }
               else if(textField == lastNameTF){
                let lastName = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ")
                if(string.rangeOfCharacter(from: lastName) != nil)
                {
                   returnValue = true
                }
                else
                {
                    returnValue = false
                }
               }
               
               else if(textField == emailTF)
               {
                   let emailAllowChar = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@-._")
                   if(string.rangeOfCharacter(from: emailAllowChar) != nil)
                   {
                       returnValue = true
                   }
                   else
                   {
                       returnValue = false
                   }
               }
               else if(textField == passwordTF || textField == conformPasswordTF)
               {
                   let passwordAllowChar = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@-._!&$#^")
                   if(string.rangeOfCharacter(from: passwordAllowChar) != nil)
                   {
                        returnValue = true
                   }
                   else
                   {
                       returnValue = false
                   }
               }
               else if(textField == genderTF)
               {
                   let gender = CharacterSet(charactersIn: "maleMALEFEMALEfemale")
                   if(string.rangeOfCharacter(from: gender) != nil)
                   {
                        returnValue = true
                   }
                   else
                   {
                       returnValue = false
                   }
               }
           
           return returnValue
           }
           
           
           
           func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
               
               var returnValue:Bool = false
               if(textField == firstNameTF)
               {
                   returnValue =  true
               }
               else if(textField == lastNameTF){
                if(firstNameTF.text!.count>0){
                    returnValue = true
                }
                else{
                    returnValue = false
                }
               }
               else if(textField == emailTF)
               {
                if(firstNameTF.text!.count > 0 && lastNameTF.text!.count>0)
                   {
                       returnValue = true
                   }
                   else
                   {
                       returnValue = false
                   }
               }
               else if(textField == genderTF)
               {
                if(firstNameTF.text!.count > 0 && lastNameTF.text!.count > 0 && emailTF.text!.count>0)
                   {
                       returnValue = true
                   }
                   else
                   {
                      returnValue = false
                   }
               }
               else if(textField == passwordTF)
               {
                  if(firstNameTF.text!.count > 0 && lastNameTF.text!.count > 0 &&
                    emailTF.text!.count > 0 && genderTF.text!.count>0)
                   {
                       returnValue = true
                   }
                   else
                   {
                      returnValue = false
                   }
               }
               else if(textField == conformPasswordTF)
               {
                   if(firstNameTF.text!.count > 0 && lastNameTF.text!.count > 0 &&
                    emailTF.text!.count > 0 && genderTF.text!.count > 0 && passwordTF.text!.count>0)
                   {
                       returnValue = true
                   }
                   else
                   {
                      returnValue = false
                   }
               }
              
                  
              return returnValue
           }
           
           
           func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
               var returnValue:Bool = false
               if(textField == firstNameTF)
               {
                   if(textField.text!.count >= 3)
                   {
                      returnValue = true
                       
                   }
                   else
                   {
                      returnValue = false
                       showMessageToUser(title: "error", msg: "Please Enter Atleast 3 Character")
                       
                   }
               }
               else if(textField == lastNameTF){
                if(textField.text!.count >= 3)
                {
                   returnValue = true
                    
                }
                else
                {
                   returnValue = false
                    showMessageToUser(title: "error", msg: "Please Enter Atleast 3 Character")
                    
                }
               }
                   
               else if(textField == emailTF)
               {
                   if(validateEmailId(emailID: textField.text!))
                   {
                       returnValue = true
                      
                   }
                   else
                   {
                       returnValue = false
                       showMessageToUser(title: "error", msg: "Please Enter valid Email")
                      
                   }
               }
               else if(textField == genderTF){
                
                if(textField.text!.count >= 4)
                {
                   returnValue = true
                    
                }
                else
                {
                   returnValue = false
                    showMessageToUser(title: "error", msg: "Please Enter Atleast 4 Character")
                    
                }
                
               }
               else if(textField == passwordTF)
               {
                   if(validatePassword(password: textField.text!))
                   {
                       returnValue = true
                       
                       
                   }
                   else
                   {
                       returnValue = false
                       showMessageToUser(title: "error", msg: "Length 9 Atleast 1 Number 1 Capitalletter")
                       
                   }
               }
               else if(textField == conformPasswordTF)
               {
                   if(validatePassword(password: textField.text!))
                   {
                       returnValue = true
                       
                       
                   }
                   else
                   {
                       returnValue = false
                       showMessageToUser(title: "error", msg: "Length 9 Atleast 1 Number 1 Capitalletter")
                       
                   }
               }
          
    
               return returnValue
           }
       func textFieldShouldReturn(_ textField: UITextField) -> Bool
       {
           
           textField.resignFirstResponder()
           return true
       }
           
           //Regular Expression for Email
           func validateEmailId(emailID: String) -> Bool
           {
              let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
              let trimmedString = emailID.trimmingCharacters(in: .whitespaces)
              let validateEmail = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
              let isValidateEmail = validateEmail.evaluate(with: trimmedString)
              return isValidateEmail
           }
            //Regular Expression for PassWord
           func validatePassword(password: String) -> Bool
           {
              //Minimum 8 characters at least 1 Alphabet and 1 Number:
              let passRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
              let trimmedString = password.trimmingCharacters(in: .whitespaces)
              let validatePassord = NSPredicate(format:"SELF MATCHES %@", passRegEx)
              let isvalidatePass = validatePassord.evaluate(with: trimmedString)
              return isvalidatePass
           }
           //Regular Expression for Phone Number
             func validaPhoneNumber(phoneNumber: String) -> Bool
             {
              let phoneNumberRegex = "^[6-9]\\d{9}$"
              let trimmedString = phoneNumber.trimmingCharacters(in: .whitespaces)
              let validatePhone = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
              let isValidPhone = validatePhone.evaluate(with: trimmedString)
              return isValidPhone
           }
       func showMessageToUser(title:String,msg:String)
       {
           let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
           alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
           self.present(alert, animated: true, completion: nil)
       }
       func textFieldShouldClear(_ textField: UITextField) -> Bool {
           return true
       }
    
}


