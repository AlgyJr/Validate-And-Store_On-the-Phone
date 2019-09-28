//
//  ViewController.swift
//  Login
//
//  Created by ALgy Aly on 9/4/19.
//  Copyright © 2019 ALgy Aly. All rights reserved.
//

import UIKit
import os.log

class ViewController: UIViewController {
    //MARK: Variables declaration
    var infos = [Information]()
    
    //MARK: Link Variables
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtNr: UITextField!
    @IBOutlet weak var butRegistar: UIButton!
    @IBOutlet weak var butList: UIButton!
    
    //MARK: Actions
    
    @IBAction func registar(_ sender: Any) {
        var name = ""
        var email = ""
        var number = ""
        
        if !txtName.text!.isEmpty {
            setupTextField(field: txtName)
            name = txtName.text!
        } else {
            shakeError(field: txtName)
        }
        if isValid(test: txtEmail.text, expression: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9-]+\\.[A-Za-z]{2,4}") {
            setupTextField(field: txtEmail)
            email = txtEmail.text!
        } else {
            shakeError(field: txtEmail)
        }
        if isValid(test: txtNr.text, expression: "\\+[0-9]{2,3}+-?[0-9]{9}") {
            setupTextField(field: txtNr)
            number = txtNr.text!
        } else {
            shakeError(field: txtNr)
        }
        
        if let info = Information(name: name, email: email, number: number) {
            infos += [info]
            txtName.text = ""
            txtEmail.text = ""
            txtNr.text = "+258-"
            //save data
            Information.settingData(infos: infos)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! InfoTableViewController
        vc.infos = self.infos
    }
    
    //MARK: Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        setupTextField(field: txtName)
        setupTextField(field: txtEmail)
        setupTextField(field: txtNr)
        txtNr.text = "+258-"
        setupButton(button: butList, backGroundColor: UIColor.black, titleColor: UIColor.white)
        setupButton(button: butRegistar, backGroundColor: UIColor.white, titleColor: UIColor.black)
        if let savedInfo = Information.getSavedInfo() {
            infos = savedInfo
            print(infos[0].name)
        }
    }
    
    //MARK: Functions
    func setupTextField(field: UITextField) {
//        field.backgroundColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1)
        field.backgroundColor = UIColor.white
        field.layer.cornerRadius = 7
        field.layer.borderWidth = 3
        field.layer.borderColor = UIColor.black.cgColor
    }
    
    func setupButton(button: UIButton, backGroundColor: UIColor, titleColor: UIColor) {
        button.setTitleColor(titleColor, for: .normal)
        button.layer.borderWidth = 3
        button.layer.cornerRadius = 7
        button.layer.borderColor = UIColor.black.cgColor
        button.backgroundColor = backGroundColor
        setShadow(button: button)
    }
    
    func shakeError(field: UITextField) {
        field.layer.borderColor = UIColor.red.cgColor
        let shake           = CABasicAnimation(keyPath: "position")
        shake.duration      = 0.1
        shake.repeatCount   = 2
        shake.autoreverses  = true
        
        let fromPoint       = CGPoint(x: field.center.x - 8, y: field.center.y)
        let fromValue       = NSValue(cgPoint: fromPoint)
        
        let toPoint         = CGPoint(x: field.center.x + 8, y: field.center.y)
        let toValue         = NSValue(cgPoint: toPoint)
        
        shake.fromValue     = fromValue
        shake.toValue       = toValue
        
        field.layer.add(shake, forKey: "position")
    }
    
    private func setShadow(button: UIButton) {
        button.layer.shadowColor   = UIColor.black.cgColor
        button.layer.shadowOffset  = CGSize(width: 0.0, height: 0.0)
        button.layer.shadowRadius  = 8
        button.layer.shadowOpacity = 0.5
        button.clipsToBounds       = true
        button.layer.masksToBounds = false
    }
    
    func isValid(test: String?, expression: String)-> Bool {
        let regex = try! NSRegularExpression(pattern: expression, options: .caseInsensitive)
        return regex.firstMatch(in: test!, options: [], range: NSRange(location: 0, length: test!.count)) != nil
    }
}
