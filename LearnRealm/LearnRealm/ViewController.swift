//
//  ViewController.swift
//  LearnRealm
//
//  Created by mac on 8/2/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    let realm = try! Realm()
    var models : Results<TodoItem> {
        return realm.objects(TodoItem.self)
    }
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @IBAction func newButtonTappedEvent(_ sender: Any) {
        let alertController = UIAlertController(title: "new job",
                                                message: "what's in ur mind",
                                                preferredStyle: .alert)
        alertController.addTextField { (_) in }
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel) { (_) in }
        alertController.addAction(cancelAction)
        let addAction = UIAlertAction.init(title: "Add", style: .default) { (_) in
            let textField = (alertController.textFields?.first)! as UITextField
            print("You entered \(textField.text!)")
            let item = TodoItem()
            item.detail = textField.text ?? "batman"
            item.status = 0
            try! self.realm.write {
                self.realm.add(item)
                self.tableView.insertRows(at: [IndexPath.init(row: self.models.count - 1, section: 0)],
                                     with: .automatic)
            }
        }
        alertController.addAction(addAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = models[indexPath.item]
        try! realm.write {
            if item.status == 0 {
                item.status = 1
            } else {
                item.status = 0
            }
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete){
            let item = models[indexPath.row]
            try! realm.write({
                self.realm.delete(item)
            })
            
            tableView.deleteRows(at:[indexPath], with: .automatic)
            
        }

    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TableViewCell else {
            fatalError()
        }
        cell.jobLabel.text = models[indexPath.row].detail
        cell.doneLabel.text = "\(models[indexPath.row].status)"
        return cell
    }
}

