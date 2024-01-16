//
//  DiceViewController.swift
//  ToDoListUIKit
//
//  Created by stu on 2024/1/16.
//

import UIKit

class DiceViewController: UIViewController {

    @IBOutlet weak var diceOne: UIImageView!
    
    @IBOutlet weak var diceTwo: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func playDice(_ sender: Any) {
        let diceArray = randomDiceName()
        print(diceArray)
        diceOne.image = UIImage(systemName: diceArray[0])
        diceTwo.image = UIImage(systemName: diceArray[1])
        UserDefaults.standard.set(diceArray, forKey: "lastDice")
    }
    
    
    func updateUI() {
        guard let lastArray = UserDefaults.standard.array(forKey: "lastDice") else {
            return
        }
        let num = lastArray
        print(num)
        diceOne.image = UIImage(systemName: num[0] as! String)
        diceTwo.image = UIImage(systemName: num[1] as! String)
    }
    
    
    func randomDiceName() -> [String] {
        var diceArray = [String]()
        for _ in 0...1{
            let diceName = "die.face."+String(Int.random(in: 1...6))
            diceArray.append(diceName)
        }
        return diceArray
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
