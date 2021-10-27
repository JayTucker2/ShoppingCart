//
//  ViewController.swift
//  ShoppingCart
//
//  Created by JAYLAN TUCKER on 10/25/21.
//

public struct Cart : Codable{
    var name : String
}
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var shopping : [Cart] = []
    @IBOutlet weak var tableOutlet: UITableView!
    @IBOutlet weak var nameOutlet: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableOutlet.delegate = self
        tableOutlet.dataSource = self
        
        shopping.append(Cart(name: "Bananas"))
        
        if let items = UserDefaults.standard.data(forKey: "theContacts"){
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Cart].self, from: items){
               shopping = decoded
            }
        }
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        shopping.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = String(shopping[indexPath.row].name)
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            shopping.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
           }
       }
        
    

    @IBAction func addBut(_ sender: Any) {
        shopping.append(Cart(name: nameOutlet.text!))
        tableOutlet.reloadData()
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(shopping) {
            UserDefaults.standard.set(encoded, forKey: "theContacts")
        }
    }
    
}

