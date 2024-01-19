//
//  AddOrEditTableViewController.swift
//  ToDoListUIKit
//
//  Created by stu on 2024/1/16.
//

import UIKit
import OSLog

let logger = Logger()

class AddOrEditTableViewController: UITableViewController {
    
    var editList: ToDoList!
    
    @IBOutlet weak var titleLabel: UITextField!
    
    @IBOutlet weak var prioirtyCircle: UIImageView!
    
    @IBOutlet weak var lowButton: UIButton!
    
    @IBOutlet weak var highButton: UIButton!
    
    @IBOutlet weak var urgentButton: UIButton!
    
    @IBOutlet weak var detailLabel: UITextView!
       
    override func viewDidLoad() {
        updateUI()
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    func updateUI() {
        if let editList {
            titleLabel.text = editList.title
            updateButton(priority: editList.priority)
            detailLabel.text = editList.detail
        } else {
            // 新增一個List用到的
            editList = ToDoList(title: "", priority: .low, detail: "")
            updateButton(priority: editList.priority)
        }
    }
    
    
    func updateButton(priority: Priority) {
        prioirtyCircle.tintColor = UIColor(named: "\(editList.priority.rawValue )")
        urgentButton.backgroundColor = .white
        highButton.backgroundColor = .white
        lowButton.backgroundColor = .white
        
        switch priority {
        case .urgent:
            urgentButton.backgroundColor = UIColor(ciColor: .gray)
        case .high:
            highButton.backgroundColor = UIColor(ciColor: .gray)
        case .low:
            lowButton.backgroundColor = UIColor(ciColor: .gray)
        }
    }
    
    @IBAction func choiceLowPriority(_ sender: Any) {
        editList.priority = .low
        updateButton(priority: editList.priority)
    }
    
    @IBAction func choiceHighPriority(_ sender: Any) {
        editList.priority = .high
        updateButton(priority: editList.priority)
    }
    
    @IBAction func choiceUrgentPriority(_ sender: Any) {
        editList.priority = .urgent
        updateButton(priority: editList.priority)
    }
    
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        logger.log("shouldPerformSegue")
        editList.title = titleLabel.text!
        if editList.title.isEmpty == false {
            return true
        } else {
            let alertController = UIAlertController(title: "請填入標題內容喔", message: "0.0", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(okAction)
            present(alertController, animated: true)
            return false
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let title = titleLabel.text ?? ""
        let priority = editList.priority
        let detail = detailLabel.text ?? ""
        editList = ToDoList(title: title, priority: priority, detail: detail)
        logger.log("prepare data")
    }
    
    
    
    
    
    
    
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
