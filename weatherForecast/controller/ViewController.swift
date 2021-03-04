//
//  ViewController.swift
//  weatherForecast
//
//  Created by M Shankar on 3/2/21.
//  Copyright © 2021 shankarm. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    
    @IBOutlet weak var errLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        errLbl.text! = ""
        // Do any additional setup after loading the view.
    }


    @IBAction func onSigninAction(_ sender: Any) {
        
        let tvc = storyboard?.instantiateViewController(identifier: "TVC") as! ThirdViewController
        tvc.modalPresentationStyle = .fullScreen
        tvc.modalTransitionStyle = .crossDissolve
        navigationController?.pushViewController(tvc, animated: true)
    }
    
    @IBAction func newAccountAction(_ sender: Any) {
        
        let svc = storyboard?.instantiateViewController(identifier: "SVC") as! SecondViewController
        svc.modalPresentationStyle = .fullScreen
        svc.modalTransitionStyle = .crossDissolve
        navigationController?.pushViewController(svc, animated: true)
    }
}

