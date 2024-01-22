//
//  ToDoListTableViewController.swift
//  ToDoListUIKit
//
//  Created by stu on 2024/1/16.
//

import UIKit

class ToDoListTableViewController: UITableViewController {

    var lists = [ToDoList]() {
        didSet{
            ToDoList.saveLists(lists)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
     
    }

    // MARK: - Table view data source

    func updateData() {
        UserDefaults.standard.removeObject(forKey: "lists")
        if let lists = ToDoList.readLists() {
            self.lists = lists
            print("updateData(): 以解碼", lists)
        }
        tableView.reloadData()
    }
    
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return lists.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListTableViewCell", for: indexPath) as? ToDoListTableViewCell else {
            fatalError("dequeueReusableCell ToDoListTableViewCell failed")
        }
        cell.todoTitle.text = lists[indexPath.row].title
        cell.showPriorityImage.tintColor = UIColor(named: "\(lists[indexPath.row].priority.rawValue)")
        cell.detailTextLabel?.text = lists[indexPath.row].detail
        guard let imageFileName = lists[indexPath.row].imageFileName else {
            cell.listImage.image = UIImage(systemName: "folder")
            return cell
        }
        let url = URL.homeDirectory.appending(path: imageFileName).appendingPathExtension("jpeg")
        cell.listImage.image = UIImage(contentsOfFile: url.path)
        cell.listImage.contentMode = .scaleAspectFill
        return cell
        }
    
    

    @IBSegueAction func editList(_ coder: NSCoder) -> AddOrEditTableViewController? {
        let controller = AddOrEditTableViewController(coder: coder)
        if let row = tableView.indexPathForSelectedRow?.row {
            controller?.editList = lists[row]
        }
        return controller
    }
    

    
    @IBAction func unwindToList(_ unwindSegue: UIStoryboardSegue) {
        if let source = unwindSegue.source as? AddOrEditTableViewController,
           let list = source.editList {
            if let indexPath = tableView.indexPathForSelectedRow {
                lists[indexPath.row] = list
                print("ListTableView", lists)
                tableView.reloadRows(at: [indexPath], with: .automatic)
            } else {
                lists.insert(list, at: 0)
                let newIndexPath = IndexPath(row: 0, section: 0)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }

    
    // 刪除表單
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
//        try? FileManager.default.removeItem(at: lists[indexPath.row].photoURL!)
        lists.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.reloadData()
        print("after deleted", lists)
    }
    
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
