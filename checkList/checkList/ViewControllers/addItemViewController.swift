//
//  addItem.swift
//  checkList
//
//  Created by Mehdi Nezamian on 27.04.2021.
//

import UIKit

class addItemViewController : UIViewController, UINavigationControllerDelegate , UITextFieldDelegate {
    
    
    @IBOutlet public var titleField: UITextField!
    @IBOutlet public var bodyField: UITextField!
    @IBOutlet public var datePicker: UIDatePicker!
    
    
    
    
    public var completion: ((String, String, Date , Bool) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title:"Save",style:.done, target: self, action: #selector(saveButtonTapped))
        titleField.placeholder = "Title here.."
        titleField.autocapitalizationType = .sentences
        titleField.autocorrectionType = .no
        titleField.spellCheckingType = .yes
        titleField.clearButtonMode = .always
        titleField.returnKeyType = .go
        bodyField.placeholder = "Description here.."
        bodyField.autocapitalizationType = .sentences
        bodyField.autocorrectionType = .no
        bodyField.spellCheckingType = .yes
        bodyField.clearButtonMode = .always
        bodyField.returnKeyType = .go
    }
    
    @objc func saveButtonTapped() {
        if let titleText = titleField.text, !titleText.isEmpty, let bodyText = bodyField.text , !bodyText.isEmpty {
            let targetDate = datePicker.date
            
            completion?(titleText,bodyText,targetDate,false)
            
        } else {
            let alertController = UIAlertController(title: "Text field is empty" , message:  "لطفا فیلد ها را پر کنید" , preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .destructive, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleField.resignFirstResponder()
        
        return true
    }
}

