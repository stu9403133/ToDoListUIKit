//
//  File.swift
//  ToDoListUIKit
//
//  Created by stu on 2024/1/16.
//

import Foundation

struct ToDoList: Codable {
    var title: String
    var priority: Priority
    var detail: String
    
    static func saveLists(_ lists:[ToDoList]) {
        do{
            let data = try? JSONEncoder().encode(lists)
            UserDefaults.standard.set(data, forKey: "lists")
        }
    }
    
    static func readLists() -> [ToDoList]? {
        var result: [ToDoList]
        guard let data = UserDefaults.standard.data(forKey: "lists") else {
            let newlists = [ToDoList(title: "開始你的ToDoList", priority: Priority.low, detail: "")]
            let data = try? JSONEncoder().encode(newlists)
            UserDefaults.standard.set(data, forKey: "lists")
            return newlists
        }
        let content = String(data: data, encoding: .utf8)
        print(content!)
        let decoder = JSONDecoder()
        result = try! decoder.decode([ToDoList].self, from: data)
        if result.isEmpty {
            let newlists = [ToDoList(title: "開始你的ToDoList", priority: Priority.low, detail: "")]
            let data = try? JSONEncoder().encode(newlists)
            UserDefaults.standard.set(data, forKey: "lists")
            return newlists
        }
        return result
    }
    
}

enum Priority: String, Codable {
    case urgent = "Red"
    case high = "Orange"
    case low  = "Green"
}


