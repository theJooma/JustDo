//
//  Category.swift
//  JustDo
//
//  Created by Jumageldi on 6.06.2024.
//

import UIKit
import CoreData
class CategoryViewController: UITableViewController{
 var categoryArray = [Categori]()
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categoryArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let names = categoryArray[indexPath.row]
        cell.textLabel?.text = names.name
        return cell

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! JustDoViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
    
    
    func saveCategory() {
        do{
            try context?.save()
        }catch{
            print("Kategoriler kaydedilirken bir hata oluştu \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadCategories(with request: NSFetchRequest<Categori> = Categori.fetchRequest()){
        do{
            categoryArray = try context!.fetch(request)
        }catch{
            print("Veriler alınırken bir hata oluştu \(error)")
        }
        tableView.reloadData()
    }
    
    @IBAction func addCatButton(_ sender: UIBarButtonItem) {
        var textFieldss = UITextField()
        
        let alert = UIAlertController(title: "Yeni kategori ekle", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ekle", style: .default) { action in
            
            let newCategory = Categori(context: self.context!)
            newCategory.name = textFieldss.text!
            self.categoryArray.append(newCategory)
            self.saveCategory()
            
        }
        alert.addTextField { alertTexxtField in
            alertTexxtField.placeholder = "Ev ihtiyaçları"
            textFieldss = alertTexxtField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
}

