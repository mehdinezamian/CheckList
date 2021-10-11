//
//  ViewController.swift
//  checkList
//
//  Created by Mehdi Nezamian on 27.04.2021.
//

import UIKit
import UserNotifications

class CheckListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    public var items = [MyReminder]()
    
    
    @IBOutlet var table:UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        title = "Reminder"
        table.isHidden = true
        
        if items.count == 0 {
            let alertController = UIAlertController(title: "There is nothing to do" , message:  "Please set new Reminder" , preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
    
        
    
    @IBAction func addButtonTapped() {
        guard let vc = storyboard?.instantiateViewController(identifier: Constants.Storyboard.newTaskPage) as? addItemViewController else {
            return
        }
        vc.title = "New Task"
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.completion = { title , body, date , isChecked in
            DispatchQueue.main.async {
            self.navigationController?.popToRootViewController(animated: true)
            let new = MyReminder(title: title,body: body, date: date, identifier: "id_\(title)", isChecked: false)
            self.items.append(new)
            self.table.isHidden = false
            self.table.reloadData()
                
                let content = UNMutableNotificationContent()
                content.title = title
                content.sound = .default
                content.body = body
                
                let targetDate = date
                let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month , .day , .hour , .minute , .second], from: targetDate),
                                                            repeats: false)
                let request = UNNotificationRequest(identifier: "some_long_id", content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
                        if error != nil {
                            print("Something went wrong")
                        }
                        
                    })
             
            if self.items.count == 1 {
                let alertController = UIAlertController(title: "Swipe right for more action" , message:  "" , preferredStyle: UIAlertController.Style.actionSheet)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
        }
         }
        navigationController?.pushViewController(vc, animated: true)
        }
     
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { _, indexPath in
            self.items.remove(at: indexPath.row)
            self.table.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let checkedItem =  UITableViewRowAction(style: .normal, title: "✔️" ) { _, indexPath in
            self.items[indexPath.row].isChecked.toggle()
            self.table.reloadRows(at: [indexPath], with: .automatic)
        }
        checkedItem.backgroundColor = .green
        return [deleteAction,checkedItem]
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell" , for: indexPath)
        cell.textLabel?.text = items[indexPath.row].title
        let date = items[indexPath.row].date
        let formatter = DateFormatter()
        formatter.dateFormat = "dd,MM,YYY"
        cell.detailTextLabel?.text = formatter.string(from: date)
        
        if items[indexPath.row].isChecked {
            cell.backgroundColor = .green
        } else {
            cell.backgroundColor = nil
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = items[indexPath.row]
        
        guard let vc = storyboard?.instantiateViewController(identifier: "note") as? NoteViewController else {
            return
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.title = "Note"
        vc.noteTitle = item.title
        vc.noteBody = item.body
        
        navigationController?.pushViewController(vc , animated: true)
        
    }
}

struct MyReminder {
    
    let title: String
    let body:String
    let date:Date
    let identifier: String
    var isChecked:Bool
    
    
}

