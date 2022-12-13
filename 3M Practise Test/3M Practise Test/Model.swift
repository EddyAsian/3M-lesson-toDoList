//
//  Model.swift
//  3M Practise Test
//

//

import Foundation


var ToDoItems: [[String: Any]] = [["Name": "Доделать домашку за 3-ий месяц", "isCompleted": false],
                                  ["Name": "Купить продукты домой", "isCompleted": false],
                                  ["Name": "Прочитать больше про Delegate, DataSource, didSelectItemAt", "isCompleted": false],
                                  ["Name": "Покормить собаку и купить ошейник", "isCompleted": false],
                                  ["Name": "Сходить к доктору", "isCompleted": false]]


func addItem(nameItem: String, isCompleted: Bool = false) {
    
//    это добавит заметку в самый вниз
//    ToDoItems.append(["Name": nameItem, "isCompleted": isCompleted])
    
    
    ToDoItems.insert(["Name": nameItem, "isCompleted": isCompleted], at: 0)
    saveData()
}


func removeItem(at index: Int) {
    ToDoItems.remove(at: index)
    saveData()
}

//функция для перемены местами заметок и редактирования
func moveItem(fromIndex: Int, toIndex: Int) {
    
    let from = ToDoItems[fromIndex]
    ToDoItems.remove(at: fromIndex)
    ToDoItems.insert(from, at: toIndex)
}

/*   меняем состояние заметки: обращаемся к массиву по индексу item и для ключа IsCompleted
выставляем состояние противоположное которое было */
func changeState(at item: Int) -> Bool {
    ToDoItems[item] ["isCompleted"] = !(ToDoItems[item]["isCompleted"] as! Bool)
    saveData()
    return ToDoItems[item] ["isCompleted"] as! Bool
    
}







//функция для сохранения в базу данных и чтобы не удалялось даже после перезагрузки макбука
//чтобы работало надо написать в AppDelegate ->  loadData()
func saveData() {
    UserDefaults.standard.set(ToDoItems, forKey: "TodoDataKey")
    UserDefaults.standard.synchronize()
}



func loadData() {
    if let array =  UserDefaults.standard.array(forKey: "TodoDataKey") as? [[String: Any]] {
        ToDoItems = array
    }else{
        ToDoItems = []
    }
    
}
