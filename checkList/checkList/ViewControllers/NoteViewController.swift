//
//  NoteViewController.swift
//  checkList
//
//  Created by Mehdi Nezamian on 30.04.2021.
//

import UIKit

class NoteViewController: UIViewController {

    @IBOutlet var titleLabel:UILabel!
    @IBOutlet var bodyLabel:UILabel!
    
    public var noteTitle = ""
    public var noteBody = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = noteTitle
        bodyLabel.text = noteBody
       
    }
    

    

}
