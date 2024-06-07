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
//MARK: - New features
        var emptyStateView: UIView?
        var emptyStateImageView: UIImageView?
        var emptyStateLabel1: UILabel?
        var emptyStateLabel2: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        setupEmptyStateView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = categoryArray.count
        toggleEmptyStateView(show: count == 0)
        return count
       
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let names = categoryArray[indexPath.row]
        cell.textLabel?.text = names.name
        return cell

    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                context?.delete(categoryArray[indexPath.row])
               categoryArray.remove(at: indexPath.row)
                saveCategory()
            }
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
    
    //MARK: - CRUD
    
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
            alertTexxtField.placeholder = "Okul,İş,..."
            textFieldss = alertTexxtField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    

    
    // MARK: - Category is Empty?

       func setupEmptyStateView() {
           emptyStateView = UIView(frame: tableView.bounds)
           emptyStateImageView = UIImageView(image: UIImage(named: "empty-category"))
           emptyStateLabel1 = UILabel()
           emptyStateLabel2 = UILabel()

           emptyStateLabel1?.text = "Henüz kategori yok."
           emptyStateLabel2?.text = "Yeni bir kategori eklemek için + butonuna tıklayın."

           emptyStateLabel1?.textAlignment = .center
           emptyStateLabel2?.textAlignment = .center

           emptyStateLabel1?.translatesAutoresizingMaskIntoConstraints = false
           emptyStateLabel2?.translatesAutoresizingMaskIntoConstraints = false
           emptyStateImageView?.translatesAutoresizingMaskIntoConstraints = false
           
           emptyStateLabel1?.font = UIFont.systemFont(ofSize: 16)
           emptyStateLabel2?.font = UIFont.systemFont(ofSize: 14)

           emptyStateImageView?.contentMode = .scaleAspectFit
           emptyStateImageView?.translatesAutoresizingMaskIntoConstraints = false
           if let emptyStateView = emptyStateView, let emptyStateImageView = emptyStateImageView, let emptyStateLabel1 = emptyStateLabel1, let emptyStateLabel2 = emptyStateLabel2 {
               emptyStateView.addSubview(emptyStateImageView)
               emptyStateView.addSubview(emptyStateLabel1)
               emptyStateView.addSubview(emptyStateLabel2)

               tableView.backgroundView = emptyStateView

               NSLayoutConstraint.activate([
                   emptyStateImageView.centerXAnchor.constraint(equalTo: emptyStateView.centerXAnchor),
                   emptyStateImageView.centerYAnchor.constraint(equalTo: emptyStateView.centerYAnchor, constant: -50),
                   emptyStateImageView.widthAnchor.constraint(equalToConstant: 200),
                   emptyStateImageView.heightAnchor.constraint(equalToConstant: 200),
                   
                   
                   emptyStateLabel1.topAnchor.constraint(equalTo: emptyStateImageView.bottomAnchor, constant: 20),
                   emptyStateLabel1.leadingAnchor.constraint(equalTo: emptyStateView.leadingAnchor, constant: 20),
                   emptyStateLabel1.trailingAnchor.constraint(equalTo: emptyStateView.trailingAnchor, constant: -20),
                   emptyStateLabel2.topAnchor.constraint(equalTo: emptyStateLabel1.bottomAnchor, constant: 10),
                   emptyStateLabel2.leadingAnchor.constraint(equalTo: emptyStateView.leadingAnchor, constant: 20),
                   emptyStateLabel2.trailingAnchor.constraint(equalTo: emptyStateView.trailingAnchor, constant: -20)
               ])
           }
       }

       func toggleEmptyStateView(show: Bool) {
           tableView.backgroundView?.isHidden = !show
       }
   }
    
    
    
    


