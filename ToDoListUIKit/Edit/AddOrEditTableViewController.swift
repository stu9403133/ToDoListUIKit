//
//  AddOrEditTableViewController.swift
//  ToDoListUIKit
//
//  Created by stu on 2024/1/16.
//

import UIKit

class AddOrEditTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var isSelectedImage = false
    
    var editList: ToDoList!
    
    @IBOutlet weak var titleLabel: UITextField!
    
    @IBOutlet weak var prioirtyCircle: UIImageView!
    
    @IBOutlet weak var lowButton: UIButton!
    
    @IBOutlet weak var highButton: UIButton!
    
    @IBOutlet weak var urgentButton: UIButton!
    
    @IBOutlet weak var detailLabel: UITextView!
       
    @IBOutlet weak var listImage: UIImageView!
    
    override func viewDidLoad() {
        updateUI()
        super.viewDidLoad()
        titleLabel.becomeFirstResponder()
    }
    
    // MARK: - Table view data source
    func updateUI() {
        if let editList {
            titleLabel.text = editList.title
            updateButton(priority: editList.priority)
            detailLabel.text = editList.detail
            if let imageName = editList.imageFileName {
                let url = URL.homeDirectory.appending(path: imageName).appendingPathExtension("jpeg")
                listImage.image = UIImage(contentsOfFile: url.path)
            }
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
    
  
    @IBAction func showPic(_ sender: Any) {
        let picAlertController = UIAlertController(title: "照片來源", message: "請選擇", preferredStyle: .actionSheet)
        let photoLibraryAction = UIAlertAction(title: "相簿", style: .default) { _ in
            let pickerViewController = UIImagePickerController()
            pickerViewController.sourceType = .photoLibrary
            pickerViewController.delegate = self
            self.present(pickerViewController, animated: true)
        }
        
        let cameraAction = UIAlertAction(title: "相機", style: .default) { _ in
            
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel)
        picAlertController.addAction(photoLibraryAction)
        picAlertController.addAction(cameraAction)
        picAlertController.addAction(cancelAction)
        present(picAlertController, animated: true)
    }
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            isSelectedImage = true
            listImage.image = image
            dismiss(animated: true)
        }
    }

    // 收鍵盤
    @IBAction func dismissKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    
    // 收鍵盤
    @IBAction func tapViewCloseKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    
 // 頁面跳轉與傳資料
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
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
        var fileName: String?
        let title = titleLabel.text ?? ""
        let priority = editList.priority
        let detail = detailLabel.text ?? ""
        if isSelectedImage {
            isSelectedImage.toggle()
            if let file = editList.imageFileName {
                fileName = file
            } else {
                fileName = UUID().uuidString
            }
            let data = listImage.image?.jpegData(compressionQuality: 1)
            let url = URL.homeDirectory.appending(path: fileName!).appendingPathExtension("jpeg")
            try? data?.write(to: url)
            
        } else {
            if let file = editList.imageFileName {
                fileName = file
            }
        }
        editList = ToDoList(title: title, priority: priority, detail: detail, imageFileName: fileName)
    }
    
    
    
    
    
    
    
    
    
// 顯示清單數目
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
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
