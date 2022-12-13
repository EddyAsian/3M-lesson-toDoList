//
//  TableTableViewController.swift
//  3M Practise Test
//

//

import UIKit

class TableViewController: UITableViewController {

    @IBAction func pushEditAction(_ sender: Any) {
//     для редактирования и перемены местами заметок
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    
    @IBAction func pushAddAction(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Создать новую заметку", message: "Выберите", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "New item name"
        }
        
        let alertAction1 =  UIAlertAction(title: "Нет", style: .destructive) { (alert) in
            
        }
        
        let alertAction2 =  UIAlertAction(title: "Да", style: .cancel) { (alert) in
           let newItem = alertController.textFields![0].text
            addItem(nameItem: newItem!)
            self.tableView.reloadData()
         }
        
        alertController.addAction(alertAction1)
        alertController.addAction(alertAction2)
        present(alertController, animated: true, completion: nil)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//чтобы не было пустых линий снизу заметок для красоты
        tableView.tableFooterView = UIView()
//        сделаем цвет фона сзади заметок чуть серым для красоты
        tableView.backgroundColor = UIColor.groupTableViewBackground
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ToDoItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        let currentItem = ToDoItems[indexPath.row]
        cell.textLabel?.text = currentItem["Name"] as? String
        
        
//        currentItem["isCompleted"] as? Bool - так будет ругаться
        if (currentItem["isCompleted"] as? Bool) == true {
            cell.imageView?.image = UIImage(named: "photo1")
            
            
        } else {
            cell.imageView?.image = UIImage(named: "photo2")
        }
        return cell
    }
    

//позволет заметке при свайпе влево показать функцию Удалить
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            removeItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
   
    
    
//    сделаем функцию выбора и обратного клика отмены выбора ячейки
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if changeState(at: indexPath.row) {
            
            tableView.cellForRow(at: indexPath)?.imageView?.image = UIImage(named: "photo1")
            let elementToMove = ToDoItems[indexPath.row]
            ToDoItems.remove(at: indexPath.row)
            ToDoItems.insert(elementToMove, at: 0)
            tableView.reloadData()
            
        }else{
            tableView.cellForRow(at: indexPath)?.imageView?.image = UIImage(named: "photo2")
        }
        
        
        
    }
    
//    для замены местами заметок
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        moveItem(fromIndex: fromIndexPath.row, toIndex: to.row)
    }
    

    
    
    
    
    
    
    
    
    
    
        
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


extension TableViewController: UICollectionViewDelegateFlowLayout {
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: 180, height: 220)
    }
}
