//
//  ToDoListTableViewController.swift
//  ToDoListUIKit
//
//  Created by stu on 2024/1/16.
//

import UIKit

class ToDoListTableViewController: UITableViewController {
    var list: ToDoList!
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
//        UserDefaults.standard.removeObject(forKey: "lists")
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
        controller?.delegate = self
        return controller
    }
    

    
    @IBAction func unwindToList(_ unwindSegue: UIStoryboardSegue) {
        tableView.reloadData()
        print("unwindToList", lists)
            
        }

    
    // 刪除表單
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        lists.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.reloadData()
        print("after deleted", lists)
    }
}

extension ToDoListTableViewController: AddOrEditTableViewControllerDelegate{
    func addOrEditTableViewController(_ controller: AddOrEditTableViewController, didlist editList: ToDoList) {
        print("protocol use")
        list = editList
        if let indexPath = tableView.indexPathForSelectedRow {
            lists[indexPath.row] = list
            tableView.reloadRows(at: [indexPath], with: .automatic)
        } else {
            lists.insert(list, at: 0)
            let newIndexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
}
