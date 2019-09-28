//
//  SaveUpload.swift
//  Login
//
//  Created by ALgy Aly on 9/6/19.
//  Copyright © 2019 ALgy Aly. All rights reserved.
//

import UIKit
import os.log

func isValid(test: String?, expression: String)-> Bool {
    let regex = try! NSRegularExpression(pattern: expression, options: .caseInsensitive)
    return regex.firstMatch(in: test!, options: [], range: NSRange(location: 0, length: test!.count)) != nil
}

class Information : NSObject, NSCoding {
    
    //MARK: Properties
    
    var name:String
    var email:String
    var number:String
    
    struct PropertyKey {
        static let name = "name"
        static let email = "email"
        static let number = "number"
        static let savedObject = "saved"
    }
    
    //MARK: Setting Data
    static func settingData(infos: [Information]) {
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: infos)
        UserDefaults.standard.set(encodedData, forKey: PropertyKey.savedObject)
    }
    
    //Get
    static func getSavedInfo() -> [Information]? {
        if let decodedArray = NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.object(forKey: PropertyKey.savedObject) as! Data) as! [Information]? {
            print(decodedArray[0].name)
            return decodedArray
        }
        print("Nil")
        return nil
    }
    
    //MARK: Construtor and Inicialization
    
    init?(name: String, email: String, number: String) {
        //O nome não pode estar vazio
        guard !name.isEmpty else {
            return nil
        }
        
        //O email deve contêr nome da servidora, @, ., extensão final
        guard isValid(test: email, expression: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9-]+\\.[A-Za-z]{2,4}") else {
            return nil
        }
        
        //A inicialização deve falhar se o nome estiver vazio ou o rating for negativo
        guard isValid(test: number, expression: "\\+[0-9]{2,3}+-?[0-9]{9}") else {
            return nil
        }
        
        if name.isEmpty || !isValid(test: email, expression: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9-]+\\.[A-Za-z]{2,4}") || !isValid(test: number, expression: "\\+[0-9]{2,3}+-?[0-9]{9}") {
            return nil
        }
        
        //Armazenamento dos dados nas variaveis
        self.name      = name
        self.email     = email
        self.number    = number
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name       = aDecoder.decodeObject(forKey: PropertyKey.name) as! String
        self.email      = aDecoder.decodeObject(forKey: PropertyKey.email) as! String
        self.number     = aDecoder.decodeObject(forKey: PropertyKey.number) as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(email, forKey: PropertyKey.email)
        aCoder.encode(number, forKey: PropertyKey.number)
    }
    
    //Soon to set an information
//    func setName(name:String) {
//        self.name = name
//    }
//
//    func setEmail(email:String) {
//        self.email = email
//    }
//
//    func setNumber(number:String) {
//        self.number = number
//    }
}
