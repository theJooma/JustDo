//
//  Categorry.swift
//  JustDo
//
//  Created by Jumageldi on 6.06.2024.
//

import UIKit
import CoreData
class CategorryViewController: UITableViewController{
 var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categoryArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let names = categoryArray[indexPath.row]
       
        
        return cell
        
        
    }
    
    
    
    
}
